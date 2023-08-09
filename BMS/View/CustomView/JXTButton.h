//
//  QQWButton.h
//  PingTool
//
//  Created by qinwen on 2017/8/12.
//  Copyright © 2017年 qinwen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonPosition) {
    ImageLeftTitleRight,
    ImageRightTitleLeft,
    ImageTopTitleBottom,
    ImageBottomTitleTop
};

@interface JXTButton : UIButton

+ (instancetype)buttonWithImage:(UIImage *)image
                      imageSize:(CGSize)imageSize
                         title:(NSString *)title
                     titleColor:(UIColor *)color
                     space:(CGFloat)space
                     titleFont:(UIFont *)font
                  subviewLayout:(ButtonPosition)position;

+ (instancetype)buttonWithImage:(UIImage *)image
                    selectImage:(UIImage *)selectImage
                      imageSize:(CGSize)imageSize
                          title:(NSString *)title
                     titleColor:(UIColor *)color
                      space:(CGFloat)space
                      titleFont:(UIFont *)font
                  subviewLayout:(ButtonPosition)position;

+ (instancetype)buttonWithImage:(UIImage *)image
                    selectImage:(UIImage *)selectImage
                      imageSize:(CGSize)imageSize
                          title:(NSString *)title
                     titleColor:(UIColor *)color
                      titleFont:(UIFont *)font
                          selectTitle:(NSString *)selectTitle
                     selectTitleColor:(UIColor *)selectTitleColor
                      selectTitleFont:(UIFont *)selectTitleFont
                          space:(CGFloat)space
                  subviewLayout:(ButtonPosition)position;

@end
