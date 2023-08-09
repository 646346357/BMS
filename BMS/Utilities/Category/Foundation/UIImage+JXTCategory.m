//
//  UIImage+JXTImage.m
//  SplendidGarden
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UIImage+JXTCategory.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>
#import <CoreImage/CoreImage.h>

@implementation UIImage (JXTImage)

#pragma mark - Public Method

+ (instancetype)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (instancetype)imageWithColors:(NSArray *)colors {
    CGRect rect=CGRectMake(0, 0, 1, colors.count);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 1; i <= colors.count; i++) {
        UIColor *color = colors[i-1];
        CGRect rect1 =CGRectMake(0, i-1, 1, i);
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect1);
    }
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (instancetype)expandImageWithImage:(UIImage *)image size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    //Determine whether the screen is retina
    if([[UIScreen mainScreen] scale] == 2.0){      // @2x
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else if([[UIScreen mainScreen] scale] == 3.0){ // @3x ( iPhone 6plus 、iPhone 6s plus)
        UIGraphicsBeginImageContextWithOptions(size, NO, 3.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    
    CGRect smallRect = CGRectZero;
    smallRect = CGRectMake((size.width - image.size.width)/2, (size.height - image.size.height)/2, image.size.width, image.size.height);
    [image drawInRect:smallRect];
    UIImage *resultingImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

- (instancetype)expandImageWithExpandSize:(CGSize)size {
    return [UIImage expandImageWithImage:self size:size];
}

+ (void)imageWithAssets:(id)asset resultHandler:(void (^)(UIImage *, NSDictionary *))resultHandler {
    //------------------------------ALAsset---------------------------------//
    if ([asset isKindOfClass:[ALAsset class]]) {
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        CGImageRef imgRef = [assetRep fullResolutionImage];   //获取高清图片
        UIImage *img = [UIImage imageWithCGImage:imgRef  scale:assetRep.scale                        orientation:(UIImageOrientation)assetRep.orientation];
        if (resultHandler) {
            resultHandler(img, nil);
        }
    } else if ([asset isKindOfClass:[PHAsset class]]) {
        //------------------------------PHAsset---------------------------------//
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        options.synchronous = YES;
        options.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
            if (resultHandler) {
                resultHandler(result, info);
            }
        }];
    } else {
        if (resultHandler) {
            resultHandler(nil, nil);
        }
    }
}


@end

@implementation UIImage (JXTQRImage)

+ (UIImage *)imageWithString:(NSString *)QRString centerImage:(UIImage *)centerImage {
    // 创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 将字符串转换成 NSdata
    NSData *dataString = [QRString dataUsingEncoding:NSUTF8StringEncoding];
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:dataString forKey:@"inputMessage"];
    // 获得滤镜输出的图像
    CIImage *outImage = [filter outputImage];
    // 图片小于(27,27),我们需要放大
    outImage = [outImage imageByApplyingTransform:CGAffineTransformMakeScale(30, 30)];
    // 将CIImage类型转成UIImage类型
    UIImage *startImage = [UIImage imageWithCIImage:outImage];
    // 开启绘图, 获取图形上下文
    UIGraphicsBeginImageContext(startImage.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [startImage drawInRect:CGRectMake(0, 0, startImage.size.width, startImage.size.height)];
    // 再把小图片画上去
    CGFloat icon_imageW = 200;
    CGFloat icon_imageH = icon_imageW;
    CGFloat icon_imageX = (startImage.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (startImage.size.height - icon_imageH) * 0.5;
    [centerImage drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    // 获取当前画得的这张图片
    UIImage *qrImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    //返回二维码图像
    return qrImage;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    [path addClip];
    CGContextAddPath(ctx, path.CGPath);
    [self drawInRect:rect];
    
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

@end

@implementation UIImage (JXTColor)

- (UIImage *)imageChangeColor:(UIColor *)color {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
