//
//  JXTDocumentManager.h
//  BMS
//
//  Created by qinwen on 2019/3/22.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JXTDocumentManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy, readonly) NSString *logPath;
@property (nonatomic, copy, readonly) NSString *binPath;

- (void)presentDocumentInteractionControllerWithPreviewController:(UIViewController *)vc url:(NSURL *)url preview:(BOOL)preview;

- (BOOL)removeFileAtPath:(NSString *)path;
- (BOOL)saveBinFile:(NSURL *)url;
- (NSData *)readBinFileWithPath:(NSString *)path;

@end

