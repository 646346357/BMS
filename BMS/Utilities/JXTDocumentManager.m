//
//  JXTDocumentManager.m
//  BMS
//
//  Created by qinwen on 2019/3/22.
//  Copyright © 2019 admin. All rights reserved.
//

#import "JXTDocumentManager.h"

#define kDocPath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Logs"]
#define kBinPath [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"BinFile"]

@interface JXTDocumentManager()<UIDocumentInteractionControllerDelegate> {
    
}

@property (nonatomic, assign, readonly) NSStringEncoding encoding;
@property (nonatomic, copy) NSString *currentFilePath;
@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;
@property (nonatomic, weak) UIViewController *vc;


+(instancetype) new __attribute__((unavailable("JXTBluetooth类只能初始化一次")));
-(instancetype) copy __attribute__((unavailable("JXTBluetooth类只能初始化一次")));
-(instancetype) mutableCopy  __attribute__((unavailable("JXTBluetooth类只能初始化一次")));

@end

@implementation JXTDocumentManager

#pragma mark - Life Cycle

static JXTDocumentManager *_instance;

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JXTDocumentManager alloc] init];
    });
    
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        //        _encoding = 0x80000632; //GBK编码
        _encoding = NSUTF8StringEncoding; //UTF8编码
        [self addNotification];
    }
    
    return self;
}

+ (instancetype)alloc
{
    if(_instance)
    {
        return  _instance;
    }
    return [super alloc];
}

- (void)dealloc {
    [self removeNotification];
}

#pragma mark - Public Method

- (void)presentDocumentInteractionControllerWithPreviewController:(UIViewController *)vc url:(NSURL *)url preview:(BOOL)preview{
    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
    _documentInteractionController = documentController;
    _vc = vc;
    documentController.delegate = self;
    if (!preview) {
        documentController.UTI = [self getUTI];
        [documentController presentOptionsMenuFromRect:CGRectZero
                                                inView:vc.view
                                              animated:YES];
    } else {
        [documentController presentPreviewAnimated:YES];
    }
}

- (BOOL)saveBinFile:(NSURL *)url {
    NSFileManager *manager = [NSFileManager defaultManager];
    //创建日志根目录
    if (![manager fileExistsAtPath:kBinPath]) {
        NSError *err;
        [manager createDirectoryAtPath:kBinPath withIntermediateDirectories:YES attributes:nil error:&err];
        if (err) {
            NSLog(@"创建bin根目录err:%@", err);
            return NO;
        }
    }
    
    NSError *err;
    NSArray *paths = [manager contentsOfDirectoryAtPath:kBinPath error:&err];
    if (err) {
        NSLog(@"获取旧bin文件err:%@", err);
    }
    
    for (NSString *path in paths) {
        if ([path isEqualToString:url.lastPathComponent]) {//如果存在同名文件，删除旧文件
            NSError *err;
            [manager removeItemAtPath:[kBinPath stringByAppendingPathComponent:path] error:&err];
            if (err) {
                NSLog(@"删除旧目录err:%@", err);
            }
            break;
        }
    }
    
    NSError *err1;
    NSString *path = [kBinPath stringByAppendingPathComponent:url.lastPathComponent];
    [manager moveItemAtURL:url toURL:[NSURL fileURLWithPath:path] error:&err1];
    if (err1) {
        NSLog(@"保存bin文件err:%@", err1);
        return NO;
    }
    
    return YES;
}

- (NSData *)readBinFileWithPath:(NSString *)path {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *data = [handle readDataToEndOfFile];
    [handle closeFile];
    NSLog(@"读bin文件 length:%lu  content:%@",(unsigned long)data.length, data);
    
    return data;
}

- (BOOL)removeFileAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *err;
    [manager removeItemAtPath:path error:&err];
    if (err) {
        NSLog(@"删除%@失败", err);
        return NO;
    }
    
    return YES;
}

#pragma mark - Action Method

- (void)batteryInfoDidChanged:(NSNotification *)ntf{
    [self createCurrentFilePathIfNeeded];
    if (!self.currentFilePath) {
        return;
    }
    
    NSData *data = ntf.object;
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter2 stringFromDate:[NSDate date]];
//    static NSString *lastTime;
//    if ([lastTime isEqualToString:dateStr]) {
//        return;
//    }
//    lastTime = dateStr;
    
    NSMutableString *string = [dateStr mutableCopy];
    for (NSInteger i = 0, length = data.length;  i < length; i++) {
        NSData *sub = [data subdataWithRange:NSMakeRange(i, 1)];
        NSMutableString *subStr = [NSMutableString stringWithFormat:@"%@",sub];
        [subStr deleteCharactersInRange:NSMakeRange(0, 1)];
        [subStr deleteCharactersInRange:NSMakeRange(subStr.length-1, 1)];
        [string appendString:[NSString stringWithFormat:@",%@", subStr]];
    }
    [string appendString:@"\n"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:self.currentFilePath];
        [handle seekToEndOfFile];
        [handle writeData:[string dataUsingEncoding:self.encoding]];
        [handle closeFile];
    });
}

#pragma mark - Private Method

- (void)addNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(batteryInfoDidChanged:) name:JXT_BATTERY_INFO_NOTIFY object:nil];
}

- (void)removeNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

- (void)createCurrentFilePathIfNeeded {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (self.currentFilePath && [manager fileExistsAtPath:self.currentFilePath]) {
        return;
    }
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dicStr = [dateFormatter stringFromDate:date];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fileStr = [dateFormatter2 stringFromDate:date];
    
    
    NSString *docPath = kDocPath;
    NSString *dicPath = [docPath stringByAppendingPathComponent:dicStr];
    NSString *filePath = [dicPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.csv", fileStr]];
    
    //创建日志根目录
    if (![manager fileExistsAtPath:docPath]) {
        NSError *err;
        [manager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:&err];
        if (err) {
            NSLog(@"创建日志根目录err:%@", err);
            return;
        }
    }
    
    //创建日志日期目录
    if (![manager fileExistsAtPath:dicPath]) {
        NSError *err;
        [manager createDirectoryAtPath:dicPath withIntermediateDirectories:YES attributes:nil error:&err];
        if (err) {
            NSLog(@"创建日志日期目录err:%@", err);
            return;
        }
    }
    
    //创建文件
    BOOL createFile = [manager createFileAtPath:filePath contents:nil attributes:nil];
    if (!createFile) {
        NSLog(@"创建文件失败");
        return;
    }
    
    self.currentFilePath = filePath;
}

- (NSString *)getUTI
{
    NSString *typeStr = [self getFileTypeStr:[NSURL URLWithString:kDocPath].pathExtension];
    if ([typeStr isEqualToString:@"PDF"]) {
        return @"com.adobe.pdf";
    }
    if ([typeStr isEqualToString:@"Word"]){
        return @"com.microsoft.word.doc";
    }
    if ([typeStr isEqualToString:@"PowerPoint"]){
        return @"com.microsoft.powerpoint.ppt";
    }
    if ([typeStr isEqualToString:@"Excel"]){
        return @"com.microsoft.excel.xls";
    }
    return @"public.data";
}


- (NSString *)getFileTypeStr:(NSString *)pathExtension
{
    if ([pathExtension isEqualToString:@"pdf"] || [pathExtension isEqualToString:@"PDF"]) {
        return @"PDF";
    }
    if ([pathExtension isEqualToString:@"doc"] || [pathExtension isEqualToString:@"docx"] || [pathExtension isEqualToString:@"DOC"] || [pathExtension isEqualToString:@"DOCX"]) {
        return @"Word";
    }
    if ([pathExtension isEqualToString:@"ppt"] || [pathExtension isEqualToString:@"PPT"]) {
        return @"PowerPoint";
    }
    if ([pathExtension isEqualToString:@"xls"] || [pathExtension isEqualToString:@"XLS"] || [pathExtension isEqualToString:@"csv"] || [pathExtension isEqualToString:@"CSV"]) {
        return @"Excel";
    }
    return @"其它";
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return _vc;
}

- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller{
    return _vc.view;
    
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller{
    return _vc.view.frame;
    
}

#pragma mark - Getter & Setter

- (NSString *)logPath {
    return kDocPath;
}

- (NSString *)binPath {
    return kBinPath;
}

@end
