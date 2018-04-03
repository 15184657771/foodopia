//
//  DrinkViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "DrinkViewController.h"
#import "UIColor+Hex.h"
#import "RecordDrinkView.h"

@interface DrinkViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *drinkBtn;

@property (nonatomic, strong) RecordDrinkView *drinkView;
@end

@implementation DrinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
}

- (void)createUI {
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 58, SCREEN_WIDTH - 50 * 2, 134 * HeightNum)];
    self.imageView.image = [UIImage imageNamed:@"水杯"];
    [self.view addSubview:self.imageView];
    
    self.drinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.drinkBtn.frame = CGRectMake(50, CGRectGetMaxY(self.imageView.frame) + 28, SCREEN_WIDTH - 50 * 2, 40);
    self.drinkBtn.backgroundColor = [UIColor colorWithHex:@"ad77cd"];
    [self.drinkBtn setTitle:@"喝一杯" forState:UIControlStateNormal];
    self.drinkBtn.layer.cornerRadius = 20;
    self.drinkBtn.clipsToBounds = YES;
    [self.view addSubview:self.drinkBtn];
    
    self.drinkView = [[RecordDrinkView alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(self.drinkBtn.frame) + 30, SCREEN_WIDTH - 18 * 2, 167 * HeightNum) andCount:3];
    [self.view addSubview:self.drinkView];
    
}

@end
