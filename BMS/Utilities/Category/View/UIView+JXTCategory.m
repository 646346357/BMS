//
//  UIView+JXTViewController.m
//  SplendidGarden
//
//  Created by admin on 2017/10/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UIView+JXTCategory.h"
#import "JXTNavigationController.h"

@implementation UIView (JXTView)

#pragma mark - Public Method

- (void)setJxt_x:(CGFloat)jxt_x
{
    CGRect frame = self.frame;
    frame.origin.x = jxt_x;
    self.frame = frame;
}

- (CGFloat)jxt_x
{
    return self.jxt_origin.x;
}

- (void)setJxt_centerX:(CGFloat)jxt_centerX
{
    CGPoint center = self.center;
    center.x = jxt_centerX;
    self.center = center;
}

- (CGFloat)jxt_centerX
{
    return self.center.x;
}

-(void)setJxt_centerY:(CGFloat)jxt_centerY
{
    CGPoint center = self.center;
    center.y = jxt_centerY;
    self.center = center;
}

- (CGFloat)jxt_centerY
{
    return self.center.y;
}

- (void)setJxt_y:(CGFloat)jxt_y
{
    CGRect frame = self.frame;
    frame.origin.y = jxt_y;
    self.frame = frame;
}

- (CGFloat)jxt_y
{
    return self.frame.origin.y;
}

- (void)setJxt_size:(CGSize)jxt_size
{
    CGRect frame = self.frame;
    frame.size = jxt_size;
    self.frame = frame;
    
}

- (CGSize)jxt_size
{
    return self.frame.size;
}

- (void)setJxt_height:(CGFloat)jxt_height
{
    CGRect frame = self.frame;
    frame.size.height = jxt_height;
    self.frame = frame;
}

- (CGFloat)jxt_height
{
    return self.frame.size.height;
}

- (void)setJxt_width:(CGFloat)jxt_width
{
    CGRect frame = self.frame;
    frame.size.width = jxt_width;
    self.frame = frame;
    
}

-(CGFloat)jxt_width
{
    return self.frame.size.width;
}

- (void)setJxt_origin:(CGPoint)jxt_origin
{
    CGRect frame = self.frame;
    frame.origin = jxt_origin;
    self.frame = frame;
}

- (CGPoint)jxt_origin
{
    return self.frame.origin;
}

+ (instancetype)lineView {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lineColor];
    
    return line;
}

/***************************** Jamfer Add ***************************************************/
-(CGFloat)jxt_bottom{
    return (self.frame.origin.y+self.frame.size.height);
}

-(CGFloat)jxt_right{
    return (self.frame.origin.x+self.frame.size.width);
}

@end


@implementation UIView (JXTViewController)

#pragma mark - Public Method

- (UIViewController *)controller {
    UIViewController * vc = nil;
    UIResponder * responder = self.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            vc = (UIViewController *)responder;
            break;
        } else {
            responder = responder.nextResponder;
        }
    }
    
    if ([responder isKindOfClass:[UIViewController class]]) {
        vc = (UIViewController *)responder;
    }
    
    return vc;
}

@end

@implementation UIView (JXTHUDView)
static UIView *lastViewWithHUD = nil;

#pragma mark - Public Method

+ (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    return result;
}

+ (void)showActivityIndicatorViewWithString:(NSString *)tip {
    
    //show the HUD
    UIView* targetView = [self presentingVC].view;
    if (targetView==nil) return;
    
    lastViewWithHUD = targetView;
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    
    hud.userInteractionEnabled = YES;
    if (tip!=nil) {
        hud.label.text = tip;
    } else {
        hud.label.text = @"正在加载...";
    }
}

+ (void)updateActivityIndicatorViewWithString:(NSString *)tip {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:lastViewWithHUD];
    if (hud) {
        hud.label.text = tip;
    }
}

+ (void)dismissActivityIndicatorView {
    [MBProgressHUD hideHUDForView:lastViewWithHUD animated:YES];
}

+ (void)showHudString:(NSString *)string stayDuration:(CGFloat)stayDuration animationDuration:(CGFloat)animationDuration hudDidHide:(JXTHudDidHideBlock)block{
    if (string && string.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        for(NSObject* obj in [UIApplication sharedApplication].keyWindow.subviews){
            if([obj isKindOfClass:[MBProgressHUD class]]){
                MBProgressHUD* shud = (MBProgressHUD*)obj;
                if(![shud.detailsLabel.text isEqualToString:string]){
                    CGPoint offset = hud.offset;
                    offset.y = shud.offset.y+20;
                    hud.offset = offset;
                }
            }
        }
        hud.userInteractionEnabled = NO;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.text = string;
        hud.margin = 10.f;
//        hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:.65];
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.removeFromSuperViewOnHide = YES;
//        hud.cornerRadius = 5.0;
        [hud hideAnimated:YES afterDelay:stayDuration+0.5];
    }
    /*[[UIApplication sharedApplication].keyWindow showHudString:string stayDuration:stayDuration animationDuration:animationDuration hudDidHide:block];*/
}

- (UIView *)customBackgroundView {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect frame = self.frame;
    if (self.superview) {
        frame = [keyWindow convertRect:self.frame fromView:self.superview];
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [UIColor clearColor];
    [keyWindow addSubview:bgView];
    
    return bgView;
}

@end

