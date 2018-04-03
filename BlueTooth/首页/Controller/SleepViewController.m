//
//  SleepViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "SleepViewController.h"
#import "UIColor+Hex.h"

@interface SleepViewController ()


@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UIButton *button;

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
    [self.view addSubview:self.button];
    
    
}



@end
