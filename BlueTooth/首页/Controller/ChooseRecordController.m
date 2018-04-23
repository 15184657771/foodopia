//
//  ChooseRecordController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "ChooseRecordController.h"
#import "UIColor+Hex.h"

@interface ChooseRecordController ()


@property (nonatomic, strong) UIView *backView;
/**体重按钮*/
@property (nonatomic, strong) UIButton *weightBtn;
/**喝水按钮*/
@property (nonatomic, strong) UIButton *drinkBtn;
/**睡觉按钮*/
@property (nonatomic, strong) UIButton *sleepBtn;

@property (nonatomic, strong) UILabel *weightLabel;
@property (nonatomic, strong) UILabel *drinkLabel;
@property (nonatomic, strong) UILabel *sleepLabel;
@end

@implementation ChooseRecordController

#pragma mark -- init methods

- (UIButton *)weightBtn {
    if (!_weightBtn) {
        _weightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weightBtn setImage:[UIImage imageNamed:@"h2"] forState:UIControlStateNormal];
    }
    [_weightBtn addTarget:self action:@selector(weigthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _weightBtn;
}

- (UIButton *)drinkBtn {
    if (!_drinkBtn) {
        _drinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_drinkBtn setImage:[UIImage imageNamed:@"h1"] forState:UIControlStateNormal];
        [_drinkBtn setTitle:@"喝水" forState:UIControlStateNormal];
        
    }
    [_drinkBtn addTarget:self action:@selector(drinkBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _drinkBtn;
}

- (UIButton *)sleepBtn {
    if (!_sleepBtn) {
        _sleepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sleepBtn setImage:[UIImage imageNamed:@"h3"] forState:UIControlStateNormal];
        [_sleepBtn setTitle:@"睡眠" forState:UIControlStateNormal];
        
    }
    [_sleepBtn addTarget:self action:@selector(sleepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _sleepBtn;
}

- (UILabel *)weightLabel {
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.text = @"体重";
        _weightLabel.textColor = RGB(17, 17, 17);
        _weightLabel.font = [UIFont systemFontOfSize:16];
        _weightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weightLabel;
}

- (UILabel *)drinkLabel {
    if (!_drinkLabel) {
        _drinkLabel = [[UILabel alloc]init];
        _drinkLabel.text = @"喝水";
        _drinkLabel.textColor = RGB(17, 17, 17);
        _drinkLabel.font = [UIFont systemFontOfSize:16];
        _drinkLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _drinkLabel;
}
- (UILabel *)sleepLabel {
    if (!_sleepLabel) {
        _sleepLabel = [[UILabel alloc]init];
        _sleepLabel.text = @"睡觉";
        _sleepLabel.textColor = RGB(17, 17, 17);
        _sleepLabel.font = [UIFont systemFontOfSize:16];
        _sleepLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _sleepLabel;
}

#pragma mark -- lifeCycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"28313D" alpha:0.7f];
    
    UIView *cancelBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    cancelBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cancelBackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisView)];
    [cancelBackView addGestureRecognizer:tap];
    [self createUI];
}

- (void)createUI {
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 10;
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(@20);
        make.height.equalTo(@(230 * WidthNum));
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"typeshow"]];
    [self.backView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).with.offset(18 * WidthNum);
        make.size.mas_equalTo(CGSizeMake(52 * WidthNum, 47 * WidthNum));
        make.top.equalTo(self.backView.mas_top).with.offset(-5 * WidthNum);
    }];
    
    WS(ws);
    [self.backView addSubview:self.weightBtn];
    [self.backView addSubview:self.drinkBtn];
    [self.backView addSubview:self.sleepBtn];
    
    [self.weightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.mas_centerY);
        make.right.equalTo(self.drinkBtn.mas_left).with.offset(-10 * WidthNum);
        make.size.mas_equalTo(CGSizeMake(106 * WidthNum, 106 * WidthNum));
    }];
    [self.drinkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.mas_centerY);
        make.centerX.equalTo(self.backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(106 * WidthNum, 106 * WidthNum));
    }];
    [self.sleepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.equalTo(self.drinkBtn.mas_right).with.offset(10 * WidthNum);
        make.size.mas_equalTo(CGSizeMake(106 * WidthNum, 106 * WidthNum));
    }];
    
    [self.backView addSubview:self.weightLabel];
    [self.backView addSubview:self.drinkLabel];
    [self.backView addSubview:self.sleepLabel];
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.weightBtn.mas_centerX);
        make.top.equalTo(ws.weightBtn.mas_bottom).with.offset(10);
    }];
    [self.drinkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.drinkBtn.mas_centerX);
        make.top.equalTo(ws.drinkBtn.mas_bottom).with.offset(10);
    }];
    [self.sleepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.sleepBtn.mas_centerX);
        make.top.equalTo(ws.sleepBtn.mas_bottom).with.offset(10);
    }];
    
}

#pragma mark -- UITapGestureRecognizer methods
- (void)dismisView {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark -- buttonAction methods
- (void)weigthBtnAction:(UIButton *)sender {
    NSLog(@"ChooseRecordController=====weigthBtnAction");
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate ChooseRecordBackIndex:100];
    
}

- (void)drinkBtnAction:(UIButton *)sender {
    NSLog(@"ChooseRecordController======drinkBtnAction");
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate ChooseRecordBackIndex:101];
    
    
    
}

- (void)sleepBtnAction:(UIButton *)sender {
    NSLog(@"ChooseRecordController======sleepBtnAction");
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate ChooseRecordBackIndex:102];
   
}
@end
