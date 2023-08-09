//
//  JXTGlobalMacro.h
//  SplendidGarden
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#ifndef JXTGlobalMacro_h
#define JXTGlobalMacro_h


/*********************** Comman *********************/
//#define JXTLocalizedString(key) \
//[NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:nil]

#define JXT_CHARACTERISTIC_UUID @"FFE1"
#define JXT_REFRESH_TIME 1.0

/*********************** Log *********************/
#define JXTLogError(format, ...)  DDLogError((@"%@.m:%d %@ Err:" format), NSStringFromClass([self class]), __LINE__, NSStringFromSelector(_cmd), ## __VA_ARGS__)

#define JXTLogWarn(format, ...)  DDLogWarn((@"%@.m:%d %@ Warn:" format), NSStringFromClass([self class]), __LINE__, NSStringFromSelector(_cmd), ## __VA_ARGS__)

#define JXTLogInfo(format, ...)  DDLogInfo((@"%@.m:%d %@ Info:" format), NSStringFromClass([self class]), __LINE__, NSStringFromSelector(_cmd), ## __VA_ARGS__)

#define JXTLogDebug(format, ...)  DDLogDebug((@"%@.m:%d %@ Debug:" format), NSStringFromClass([self class]), __LINE__, NSStringFromSelector(_cmd), ## __VA_ARGS__)

#define JXTLogVerbose(format, ...)  DDLogVerbose((@"%@.m:%d %@ Verb:" format), NSStringFromClass([self class]), __LINE__, NSStringFromSelector(_cmd), ## __VA_ARGS__)


/*********************** Common Factory *********************/
#define JXT_IMAGE(imageName) (UIImage *)[UIImage imageNamed:imageName]
#define JXT_IMAGE_VIEW(imageName) (UIImageView *)[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]]
#define JXT_COLOR(redColor,greenColor,blueColor) (UIColor *)[UIColor colorWithRed:(redColor)/255.0 green:(greenColor)/255.0 blue:(blueColor)/255.0 alpha:1.0]
#define JXT_ALPHA_COLOR(redColor,greenColor,blueColor,alpha) (UIColor *)[UIColor colorWithRed:(redColor)/255.0 green:(greenColor)/255.0 blue:(blueColor)/255.0 alpha:(alpha)]
#define JXT_HEX_COLOR(hex) ((UIColor *)[UIColor colorWithHex:(hex)])
#define JXT_HEX_ALPHA_COLOR(hex,alp) ((UIColor *)[UIColor colorWithHex:(hex) alpha:(alp)])
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

/*********************** Screen Size *********************/
#define JXT_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define JXT_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define JXT_IPHONE_X ((JXT_SCREEN_HEIGHT == 812.0f) ? YES : NO)
#define JXT_NAVIGATIONBAR_HEIGHT (JXT_IPHONE_X ? 88 : 64)
#define JXT_STATUSBAR_HEIGHT (JXT_IPHONE_X ? 44 : 20)
#define JXT_BOTTOM_SAFE_HEIGHT (JXT_IPHONE_X ? 34 : 0)
#define JXT_TOP_EXTEND_HEIGHT (JXT_IPHONE_X ? 24 : 0)
#define JXT_SMALL_SCREEN ([UIScreen mainScreen].bounds.size.width < 375) //小屏幕 iPhone4、4S、5、5S、SE


/*********************** Notificatin Name *********************/
#define JXT_VERSION_NOTIFY             @"JXT_VERSION_NOTIFY"
#define JXT_BATTERY_INFO_NOTIFY             @"JXT_BATTERY_INFO_NOTIFY"
#define JXT_CENTRAL_STATE_NOTIFY            @"JXT_CENTRAL_STATE_NOTIFY"
#define JXT_PERIPHERAL_DISCOVER_NOTIFY      @"JXT_PERIPHERAL_DISCOVER_NOTIFY"
#define JXT_PERIPHERAL_CONNECTED_NOTIFY     @"JXT_PERIPHERAL_CONNECTED_NOTIFY"
#define JXT_PERIPHERAL_DISCONNECTED_NOTIFY     @"JXT_PERIPHERAL_DISCONNECTED_NOTIFY"
#define JXT_PERIPHERAL_CONNECTE_FAIL_NOTIFY     @"JXT_PERIPHERAL_CONNECTE_FAIL_NOTIFY"
#define JXT_CHARACTERISTIC_DISCOVER_NOTIFY     @"JXT_CHARACTERISTIC_DISCOVER_NOTIFY"
#define JXT_CHARACTERISTIC_RSSI_NOTIFY     @"JXT_CHARACTERISTIC_RSSI_NOTIFY"
#define JXT_CHARACTERISTIC_WRITE_VALUE_NOTIFY     @"JXT_CHARACTERISTIC_WRITE_VALUE_NOTIFY"
#define JXT_CHARACTERISTIC_READ_VALUE_NOTIFY     @"JXT_CHARACTERISTIC_READ_VALUE_NOTIFY"


/*********************** User Defaults *********************/

/*********************** Systerm Version *********************/
#define JXT_iOS11_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)
#define JXT_iOS10_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define JXT_iOS9_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
#define JXT_iOS8_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define JXT_iOS7_OR_LATER ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


/************************ jamfer add **************************/

#define JXT_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define JXT_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* JXTGlobalMacro_h */
