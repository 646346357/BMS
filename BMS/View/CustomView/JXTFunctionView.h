//
//  JXTFunctionView.h
//  SplendidGarden
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXTFunctionDelegate <NSObject>

- (void)functionViewButtonDidClicked:(NSInteger)index;

@end

@interface JXTFunctionView : UIView

@property (nonatomic, copy) NSArray *imageAndTitles;
@property (nonatomic, weak) id<JXTFunctionDelegate> delegate;

@end
