//
//  UIImage+JXTImage.h
//  SplendidGarden
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIImage (JXTImage)

+ (instancetype)imageWithColor:(UIColor *)color;
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (instancetype)imageWithColors:(NSArray *)colors;

+ (instancetype)expandImageWithImage:(UIImage *)image size:(CGSize)size;
- (instancetype)expandImageWithExpandSize:(CGSize)size;

+ (void)imageWithAssets:(id)asset resultHandler:(void(^)(UIImage *resultImage, NSDictionary *info))resultHandler;

@end

@interface UIImage (JXTQRImage)

+ (UIImage *)imageWithString:(NSString *)QRString centerImage:(UIImage *)centerImage;
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

@end

@interface UIImage (JXTColor)

- (UIImage *)imageChangeColor:(UIColor *)color;

@end
