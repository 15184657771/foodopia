//
//  SleepViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "SleepViewController.h"
#import "UIColor+Hex.h"
#import "RecordSleepView.h"

@interface SleepViewController ()


@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UIButton *button;

@property (nonatomic, strong)RecordSleepView *recordView;
@end

@implementation SleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
}

- (void)createUI {
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 32)];
    self.timeLabel.text = @"08:30 am";
    self.timeLabel.textColor = [UIColor colorWithHex:@"ad77cd"];
    self.timeLabel.font = [UIFont systemFontOfSize:30];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timeLabel];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.timeLabel.frame) + 20, SCREEN_WIDTH - 40 * 2, 108 * HeightNum)];
    self.imageView.image = [UIImage imageNamed:@"起床"];
    [self.view addSubview:self.imageView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(40, CGRectGetMaxY(self.imageView.frame) + 28, SCREEN_WIDTH - 40 * 2, 40);
    self.button.backgroundColor = [UIColor colorWithHex:@"ad77cd"];
    [self.button setTitle:@"起 床 了" forState:UIControlStateNormal];
    self.button.layer.cornerRadius = 20;
    self.button.clipsToBounds = YES;
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    
    self.recordView = [[RecordSleepView alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(self.button.frame) + 30, SCREEN_WIDTH - 18 * 2, 146 * HeightNum)];
    [self.view addSubview:self.recordView];
    
    UITapGestureRecognizer *recordTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recordTapAction)];
    [self.recordView addGestureRecognizer:recordTap];
    
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.recordView.frame), SCREEN_WIDTH, 30)];
    bottomLabel.text = @"每天的数据会从中午12点到次日中午计算噢";
    bottomLabel.textColor = [UIColor colorWithHex:@"c1c1c3"];
    bottomLabel.font = [UIFont systemFontOfSize:10];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomLabel];
    
    
}

#pragma mark -- UITapGestureRecognizer
- (void)recordTapAction {
    [self.delegate SleepViewBackIndex:2];
}
#pragma mark -- button click methods
- (void)buttonAction:(UIButton *)sender {
    
    if ([sender.currentTitle isEqualToString:@"起 床 了"]) {
        self.imageView.image = [UIImage imageNamed:@"起床"];
        [self.button setTitle:@"起 床 了" forState:UIControlStateNormal];
        //TODO:
        /**
         1.更新上一次起床时间
         2.取上一次点击去睡觉时间 ，算出距现在的时间 得到一次睡眠时间
         3.取出睡眠总时间 + 这一次睡眠时间
         3.更新睡眠时间
         */
   
    } else {
        self.imageView.image = [UIImage imageNamed:@"睡觉"];
        [self.button setTitle:@"去 睡 觉" forState:UIControlStateNormal];
        //TODO:
        /**
         1.更新上一次睡觉时间
         */
        
        
    }
    
    
}

@end
