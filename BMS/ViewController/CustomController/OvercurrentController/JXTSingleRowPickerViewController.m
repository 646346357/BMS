//
//  JXTSingleRowPickerViewController.m
//  SplendidGarden
//
//  Created by admin on 2017/12/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "JXTSingleRowPickerViewController.h"

static const CGFloat KPickerHeight = 216;
static const CGFloat KTopViewHeight = 40;

@interface JXTSingleRowPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource> {
    UIView *_view;
    NSInteger _currentIndex;
    NSArray *_datasource;
}

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation JXTSingleRowPickerViewController

#pragma mark - Life Cycle

- (instancetype)initWithDatasource:(NSArray *)datasource {
    if (self = [super init]) {
        _currentIndex = 0;
        _minRow = 0;
        _maxRow = datasource.count - 1;
        _datasource = datasource;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:.3 animations:^{
        [self->_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-(KTopViewHeight + KPickerHeight));
        }];
        [self.view layoutIfNeeded];
    }];
    
    _currentIndex = _minRow;
    [self.pickerView selectRow:_currentIndex inComponent:0 animated:YES];
    [self.pickerView reloadAllComponents];
}

#pragma mark - Setter Method

- (void)setMinRow:(NSInteger)minRow {
    if (minRow < 0 || minRow > _maxRow) {
        minRow = 0;
    }
    _minRow = minRow;
}

- (void)setMaxRow:(NSInteger)maxRow {
    if (maxRow > _datasource.count - 1 || maxRow < _minRow) {
        _maxRow = _datasource.count - 1;
    }
    _maxRow = maxRow;
}

#pragma mark - Override Method

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [UIView animateWithDuration:.3 animations:^{
        [self->_view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(0);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [super dismissViewControllerAnimated:NO completion:completion];
    }];
}

#pragma mark - Private Method

- (void)setupSubViews {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    _view = view;
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor lineColor];
    [view addSubview:topView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:view.bounds];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.showsSelectionIndicator = YES;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [view addSubview:pickerView];
    self.pickerView = pickerView;
    
    UIButton *cancelBtn = [UIButton buttonWithImage:nil title:@"取消" font:[UIFont boldSystemFontOfSize:18.0f] titleColor:[UIColor defaultItemColor] target:self selector:@selector(datePickerCancelButtonClicked:)];
    cancelBtn.tag = 100;
    [topView addSubview:cancelBtn];
    
    UIButton *okBtn = [UIButton buttonWithImage:nil title:@"确认" font:[UIFont boldSystemFontOfSize:18.0f] titleColor:[UIColor defaultItemColor] target:self selector:@selector(datePickerOKButtonClicked:)];
    okBtn.tag = 100 ;
    [topView addSubview:okBtn];

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(KTopViewHeight + KPickerHeight);
        make.top.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view);
        make.height.equalTo(KTopViewHeight);
    }];
    
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(view);
        make.top.equalTo(topView.mas_bottom);
    }];
    
    CGFloat btnWidth = [cancelBtn.titleLabel widthOfLabelWithFixedHeight:16];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(btnWidth + 60);
        make.left.equalTo(30 - 60/2);
        make.top.bottom.equalTo(topView);
    }];
    
    btnWidth = [okBtn.titleLabel widthOfLabelWithFixedHeight:16];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(btnWidth + 60);
        make.right.equalTo(topView.mas_right).offset(-30 + 60/2);
        make.top.bottom.equalTo(topView);
    }];
}

#pragma mark - Action Method

- (void)datePickerCancelButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)datePickerOKButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.singleRowPickerViewDelegate respondsToSelector:@selector(singleRowPickerViewController: didSlelectRow: content:)]) {
        [self.singleRowPickerViewDelegate singleRowPickerViewController:self didSlelectRow:_currentIndex content:_datasource[_currentIndex]];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _datasource.count;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [UILabel labelWithText:_datasource[row] font:[UIFont systemFontOfSize:18] textColor:nil textAlignment:NSTextAlignmentCenter];
    }
    
    if (row < _minRow || row > _maxRow) {
        label.textColor = JXT_HEX_COLOR(0x9fa0a0);
    } else {
        if (row == _currentIndex) {
            label.textColor = [UIColor defaultItemColor];
        } else {
            label.textColor = JXT_HEX_COLOR(0x595757);
        }
    }
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row < _minRow || row > _maxRow) {
        _currentIndex = _minRow;
        [self.pickerView selectRow:_currentIndex inComponent:0 animated:YES];
        [pickerView reloadAllComponents];
        return;
    }
    
    _currentIndex = row;
    UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
    label.textColor = [UIColor defaultItemColor];
    // 重置当前选中项
    [self.pickerView selectRow:_currentIndex inComponent:0 animated:YES];
    [pickerView reloadAllComponents];
}

@end
