//
//  JXTFunctionView.m
//  SplendidGarden
//
//  Created by admin on 2017/9/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTFunctionView.h"
#import "JXTButton.h"
#import <objc/runtime.h>

@interface JXTFunctionView ()<UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation JXTFunctionView

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    
    return self;
}

#pragma mark - Private Method

- (void)setupSubviews {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    [self addSubview:self.pageControl];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(20);
        make.width.equalTo(40);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)updateButtonsIfNeeded:(NSArray *)imageAndTitles {
    BOOL needsUpdate = NO;
    if (imageAndTitles.count == _imageAndTitles.count) {
        for (NSInteger i = 0; i < imageAndTitles.count; i++) {
            NSDictionary *x1 = imageAndTitles[i];
            NSDictionary *x2 = _imageAndTitles[i];
            if (![x1 isEqualToDictionary:x2]) {
                needsUpdate = YES;
                break;
            }
        }
    } else {
        needsUpdate = YES;
    }
    
    if (!needsUpdate) {
        return;
    }
    
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger columns = 3;
    NSUInteger row = 2;
    CGFloat itemWidth = 70;
    CGFloat itemHeight = 80;
//    CGFloat verticalMargin = 20;
//    CGFloat rowMargin = 30;
    
    NSInteger pageNumber = (imageAndTitles.count-1) / (columns * row);
    pageNumber = pageNumber > 0 ? pageNumber : 0;
    self.pageControl.numberOfPages = pageNumber + 1;
    NSUInteger itemCount = imageAndTitles.count;
    __block UIView *leftBgView;
    for (NSUInteger i = 0; i <= pageNumber; i++) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor clearColor];
        [self.containerView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.containerView);
            make.width.equalTo(self);
            if (!leftBgView) {//最左边
                make.left.equalTo(self.containerView);
            } else {
                make.left.equalTo(leftBgView.mas_right);
            }
            if (pageNumber == i) {//最右边
                make.right.equalTo(self.containerView);
            }
        }];
        leftBgView = bgView;
        
        NSUInteger beginIndex = i * (columns * row);
        NSUInteger endIndex = beginIndex + columns * row > itemCount ? itemCount : beginIndex + columns * row;
        for (NSUInteger j = beginIndex; j < endIndex; j++) {
            NSUInteger columnNumber = j % columns;
            NSUInteger rowNumber = j / columns % row;
            NSDictionary *dic = imageAndTitles[j];
            JXTButton *button = [JXTButton buttonWithImage:dic[@"image"] imageSize:CGSizeMake(50, 50) title:dic[@"title"] titleColor:[UIColor defaultBlackColor] space:12 titleFont:[UIFont fontOfSize_16]  subviewLayout:ImageTopTitleBottom];
            [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = [dic[@"index"] integerValue];
            [bgView addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(itemWidth, itemHeight));
                if (0 == columnNumber) {
                    make.left.equalTo(bgView);
                } else if (1 == columnNumber) {
                    make.centerX.equalTo(bgView);
                } else {
                    make.right.equalTo(bgView);
                }
                
                if (0 == rowNumber) {
                    make.top.equalTo(bgView);
                } else {
                    make.bottom.equalTo(bgView);
                }
            }];
        }
    }
}

#pragma mark - Action Method

- (void)buttonDidClicked:(UIButton *)sender {
    JXTLogDebug(@"button clicked%ldd",(long) sender.tag);
    if ([self.delegate respondsToSelector:@selector(functionViewButtonDidClicked:)]) {
        [self.delegate functionViewButtonDidClicked:sender.tag];
    }
}

- (void)pageChange:(UIPageControl *)controller {
    [self.scrollView setContentOffset:CGPointMake(controller.currentPage * self.jxt_width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {//平滑停止
    CGPoint point = scrollView.contentOffset;
    NSUInteger count = point.x / self.jxt_width;
    self.pageControl.currentPage =count;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {//生硬停止
    if (!decelerate) {
        CGPoint point = scrollView.contentOffset;
        NSUInteger count = point.x / self.jxt_width;
        self.pageControl.currentPage =count;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    NSUInteger count = point.x / self.jxt_width;
    self.pageControl.currentPage =count;
}

#pragma mark - Getter & Setter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    
    return _scrollView;
}

- (UIView *)containerView {
    if (!_containerView) {
        UIView *containerView = [[UIView alloc] init];
        containerView.backgroundColor = [UIColor clearColor];
        _containerView = containerView;
    }
    
    return _containerView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.hidesForSinglePage = YES;
        pageControl.currentPageIndicatorTintColor = [UIColor defaultItemColor];
        pageControl.pageIndicatorTintColor = JXT_HEX_COLOR(0xb5b5b6);
        [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
        _pageControl = pageControl;
    }
    
    return _pageControl;
}

- (void)setImageAndTitles:(NSArray *)imageAndTitles {
    [self updateButtonsIfNeeded:imageAndTitles];
    _imageAndTitles = imageAndTitles;
}

@end
