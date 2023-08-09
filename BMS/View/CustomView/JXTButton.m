//
//  QQWButton.m
//  PingTool
//
//  Created by qinwen on 2017/8/12.
//  Copyright © 2017年 qinwen. All rights reserved.
//

#import "JXTButton.h"

@interface JXTButton () {
   
}

@property (nonatomic, assign) ButtonPosition position;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGFloat space;

@end

@implementation JXTButton

#pragma mark - Life Cycle

+ (instancetype)buttonWithImage:(UIImage *)image
                      imageSize:(CGSize)imageSize
                          title:(NSString *)title
                     titleColor:(UIColor *)color
                      space:(CGFloat)space
                      titleFont:(UIFont *)font
                  subviewLayout:(ButtonPosition)position {
    JXTButton *btn = [JXTButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        btn.imageSize = image.size;
    } else {
        btn.imageSize = imageSize;
    }
    
    btn.space = space;
    btn.position = position;
    return btn;
}

+ (instancetype)buttonWithImage:(UIImage *)image
                    selectImage:(UIImage *)selectImage
                      imageSize:(CGSize)imageSize
                          title:(NSString *)title
                     titleColor:(UIColor *)color
                      space:(CGFloat)space
                      titleFont:(UIFont *)font
                  subviewLayout:(ButtonPosition)position {
    JXTButton *btn = [JXTButton buttonWithImage:image imageSize:imageSize title:title titleColor:color space:space titleFont:font subviewLayout:position];
    if (selectImage) {
        [btn setImage:selectImage forState:UIControlStateSelected];
    }
    
    return btn;
}

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
                  subviewLayout:(ButtonPosition)position {
    JXTButton *btn = [JXTButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setAttributedTitle:[NSAttributedString stringWithString:title color:color font:font verticalAlignment:JXTVerticalAlignmentMiddle] forState:UIControlStateNormal];
    if (selectImage) {
        [btn setImage:selectImage forState:UIControlStateSelected];
    }
    if (selectTitle.length > 0) {
        [btn setAttributedTitle:[NSAttributedString stringWithString:selectTitle color:selectTitleColor font:selectTitleFont verticalAlignment:JXTVerticalAlignmentMiddle] forState:UIControlStateSelected];
    }
    
    if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
        btn.imageSize = image.size;
    } else {
        btn.imageSize = imageSize;
    }
    
    btn.space = space;
    btn.position = position;
    return btn;
}

#pragma mark - Override Method

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.frame;
    CGFloat buttonWidth = self.jxt_width;
    CGFloat buttonHeight = self.jxt_height;
    CGFloat imageWidth = _imageSize.width;
    CGFloat imageHeight = _imageSize.height;
    
    switch (_position) {
        case ImageLeftTitleRight: {
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            CGFloat verticalImageSpace = (buttonHeight - imageHeight) * 0.5;
            CGFloat labelWidth = [self.titleLabel widthOfLabelWithFixedHeight:999];
            CGFloat labelHeight = buttonHeight;
            imageRect.size = _imageSize;
            imageRect.origin.x = (buttonWidth - imageWidth - _space - labelWidth)/2;
            imageRect.origin.y = verticalImageSpace;
            
            titleRect.size = CGSizeMake(labelWidth, labelHeight);
            titleRect.origin.x = (buttonWidth - imageWidth - _space - labelWidth)/2 + imageWidth + _space;
            titleRect.origin.y = 0;
            break;
        }
            
        case ImageRightTitleLeft: {
            self.titleLabel.textAlignment = NSTextAlignmentRight;
            CGFloat verticalImageSpace = (buttonHeight - imageHeight) * 0.5;
            CGFloat labelWidth = [self.titleLabel widthOfLabelWithFixedHeight:999];
            CGFloat labelHeight = buttonHeight;
            
            imageRect.size = _imageSize;
            imageRect.origin.x = buttonWidth - imageWidth - (buttonWidth - imageWidth - _space - labelWidth)/2;
            imageRect.origin.y = verticalImageSpace;
            
            titleRect.size = CGSizeMake(labelWidth, labelHeight);
            titleRect.origin.x = (buttonWidth - imageWidth - _space - labelWidth)/2;
            titleRect.origin.y = 0;
            break;
        }
            
        case ImageTopTitleBottom: {
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            CGFloat horizonImageSpace = (buttonWidth - imageWidth) * 0.5;
            CGFloat labelWidth = buttonWidth;
            CGFloat labelHeight = [self.titleLabel heightOfLabelWithFixedWidth:999];
            
            imageRect.size = _imageSize;
            imageRect.origin.x = horizonImageSpace;
            imageRect.origin.y = (buttonHeight - imageHeight - _space - labelHeight)/2;
            
            titleRect.size = CGSizeMake(labelWidth, labelHeight);
            titleRect.origin.x = 0;
            titleRect.origin.y = buttonHeight - labelHeight - (buttonHeight - imageHeight - _space - labelHeight)/2;
            break;
        }
            
        case ImageBottomTitleTop: {
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            CGFloat horizonImageSpace = (buttonWidth - imageWidth) * 0.5;
            CGFloat labelWidth = buttonWidth;
            CGFloat labelHeight = [self.titleLabel heightOfLabelWithFixedWidth:999];
            
            imageRect.size = _imageSize;
            imageRect.origin.x = horizonImageSpace;
            imageRect.origin.y = buttonHeight - imageHeight - (buttonHeight - imageHeight - _space - labelHeight)/2;
            
            titleRect.size = CGSizeMake(labelWidth, labelHeight);
            titleRect.origin.x = 0;
            titleRect.origin.y = (buttonHeight - imageHeight - _space - labelHeight)/2;
            break;
        }
    }
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}

@end
