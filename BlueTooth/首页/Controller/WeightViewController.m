//
//  WeightViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "WeightViewController.h"
#import "TXHRrettyRuler.h"
#import "UIColor+Hex.h"
#import "RecordWeightView.h"

@interface WeightViewController ()<TXHRrettyRulerDelegate>

@property (nonatomic, strong) UILabel *showLabel;

@property (nonatomic, strong) UIButton *recordBtn;

@property (nonatomic, strong) RecordWeightView *weightView;

@end

@implementation WeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 1.创建一个显示的标签
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, 34)];
    self.showLabel.font = [UIFont systemFontOfSize:34.f];
    self.showLabel.text = @"55kg";
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.showLabel];
    
    // 2.创建 TXHRrettyRuler 对象 并设置代理对象
    TXHRrettyRuler *ruler = [[TXHRrettyRuler alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.showLabel.frame) + 20, [UIScreen mainScreen].bounds.size.width - 50 * 2, 105 * HeightNum)];
    ruler.rulerDeletate = self;
    [ruler showRulerScrollViewWithCount:200 average:[NSNumber numberWithFloat:1] currentValue:50.5f smallMode:YES];
    [self.view addSubview:ruler];
    
    self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordBtn.frame = CGRectMake(50, CGRectGetMaxY(ruler.frame) + 24, SCREEN_WIDTH - 50 * 2, 40);
    self.recordBtn.backgroundColor = [UIColor colorWithHex:@"ad77cd"];
    [self.recordBtn setTitle:@"记录" forState:UIControlStateNormal];
    self.recordBtn.layer.cornerRadius = 20;
    self.recordBtn.clipsToBounds = YES;
    [self.view addSubview:self.recordBtn];

    self.weightView = [[RecordWeightView alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(self.recordBtn.frame) + 30, SCREEN_WIDTH - 18 * 2, 147 * HeightNum)];
    [self.view addSubview:self.weightView];
    
    
}

- (void)txhRrettyRuler:(TXHRulerScrollView *)rulerScrollView {
    self.showLabel.text = [NSString stringWithFormat:@"%.1fkg",rulerScrollView.rulerValue];
}


@end
