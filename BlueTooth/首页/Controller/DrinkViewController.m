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
#import "DrinkModel.h"
#import <JQFMDB/JQFMDB.h>

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
    [self.drinkBtn addTarget:self action:@selector(drinkBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.drinkBtn];
    
    self.drinkView = [[RecordDrinkView alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(self.drinkBtn.frame) + 30, SCREEN_WIDTH - 18 * 2, 167 * HeightNum) andCount:3];
    [self.view addSubview:self.drinkView];
    
    UITapGestureRecognizer *drinkTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(drinkTapAction)];
    [self.drinkView addGestureRecognizer:drinkTap];
    
}

#pragma mark -- UITapGestureRecognizer
- (void)drinkTapAction {
    [self.delegate DrinkViewBackIndex:1];
}
#pragma mark -- button click methods
- (void)drinkBtnAction:(UIButton *)sender {
    DrinkModel *model = [self getDate];
    model.count = 1;
    JQFMDB *db = [JQFMDB shareDatabase];
    if (![db jq_isExistTable:@"drink"]) {  //如果没有 drink 表  创建
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [db jq_inDatabase:^{
                if ([db jq_createTable:@"drink" dicOrModel:model]) {
                    NSLog(@"创建成功！！！");
                }
            }];
        });
    } else { //有表  直接插入
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [db jq_inDatabase:^{
                if ([db jq_insertTable:@"drink" dicOrModel:model]) {
                    NSLog(@"插入成功！！！");
                }
            }];
        });
    }
}


- (DrinkModel *)getDate {
    DrinkModel *model = [[DrinkModel alloc]init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df setTimeZone:timeZone];
    NSString * currentTime = [df stringFromDate:currentDate];
    NSLog(@"currentTime=====%@",currentTime);
    NSArray *arr = [currentTime componentsSeparatedByString:@" "];
    NSArray *time1 = [arr[0] componentsSeparatedByString:@"-"];
    NSArray *time2 = [arr[1] componentsSeparatedByString:@":"];
    model.year = time1[0];
    model.month = time1[1];
    model.day = time1[2];
    model.hour = time2[0];
    model.min = time2[1];
    model.second = time2[2];
    
    return model;
}

@end
