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
#import <JQFMDB/JQFMDB.h>
#import "WeightModel.h"

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
    [self.recordBtn addTarget:self action:@selector(recordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recordBtn];

    self.weightView = [[RecordWeightView alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(self.recordBtn.frame) + 30, SCREEN_WIDTH - 18 * 2, 147 * HeightNum)];
    self.weightView.userInteractionEnabled = YES;
    [self.view addSubview:self.weightView];
    
    UITapGestureRecognizer *weightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weightTapAction)];
    [self.weightView addGestureRecognizer:weightTap];
    
}

- (void)txhRrettyRuler:(TXHRulerScrollView *)rulerScrollView {
    self.showLabel.text = [NSString stringWithFormat:@"%.1fkg",rulerScrollView.rulerValue];
}

#pragma mark -- UITapGestureRecognizer
- (void)weightTapAction {
    [self.delegate WeightViewBackIndex:0];
    
}
#pragma mark -- button click methods
- (void)recordBtnAction:(UIButton *)sender {
    WeightModel *model = [self getDate];
    model.weight = [[self.showLabel.text stringByReplacingOccurrencesOfString:@"kg" withString:@""] doubleValue];
    JQFMDB *db = [JQFMDB shareDatabase];
    if (![db jq_isExistTable:@"weight"]) {  //如果没有 weight 表  创建
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [db jq_inDatabase:^{
                if ([db jq_createTable:@"weight" dicOrModel:model]) {
                    NSLog(@"创建成功！！！");
                }
            }];
        });
    } else { //有表  直接插入
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [db jq_inDatabase:^{
                if ([db jq_insertTable:@"weight" dicOrModel:model]) {
                    NSLog(@"插入成功！！！");
                }
            }];
        });
    }
}

- (WeightModel *)getDate {
    WeightModel *model = [[WeightModel alloc]init];
    
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
