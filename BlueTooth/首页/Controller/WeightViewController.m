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
#import "BaseView.h"

@interface WeightViewController ()<TXHRrettyRulerDelegate>

@property (nonatomic, strong) UILabel *showLabel;

@property (nonatomic, strong) UIButton *recordBtn;

@property (nonatomic, strong) RecordWeightView *weightView;

@property (nonatomic, strong) BaseView *baseView;

@property (nonatomic, strong) NSArray *lookForArr;

@property (nonatomic, strong) NSMutableArray *timeArr;

@property (nonatomic, strong) NSMutableArray *weightArr;

@end

@implementation WeightViewController

- (NSMutableArray *)timeArr {
    if (!_timeArr) {
        _timeArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _timeArr;
}

- (NSMutableArray *)weightArr {
    if (!_weightArr) {
        _weightArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _weightArr;
}

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
    [ruler showRulerScrollViewWithCount:220 average:[NSNumber numberWithFloat:1] currentValue:50.0f smallMode:YES];
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
    
    NSArray *arr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    
    //查询当天的数据
    self.lookForArr = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where day = '%@'",arr[2]];
     self.baseView = [[BaseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 18 * 2, 147 * HeightNum)];
    [self.weightView addSubview:self.baseView];
    if (self.lookForArr.count > 0) {
        for (WeightModel *model in self.lookForArr) {
            [self.timeArr addObject:[NSString stringWithFormat:@"%@:%@",model.hour,model.second]];
            [self.weightArr addObject:[NSNumber numberWithFloat:[model.weight floatValue]]];
        }
        [self.baseView setVerticalDaySource:self.timeArr horizontalValueArray:self.weightArr];
        [self.baseView show];
    } else {
        [self.baseView setVerticalDaySource:@[@"8:30",@"9:30",@"10:45"] horizontalValueArray:@[[NSNumber numberWithFloat:50],[NSNumber numberWithFloat:50.2],[NSNumber numberWithFloat:49.9]]];
        [self.baseView show];
    }
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
    
    [self.delegate weightBtnClick:0];
    
    NSArray *arr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    
    WeightModel *model = [self getWeightModel];
    model.weight = [self.showLabel.text stringByReplacingOccurrencesOfString:@"kg" withString:@""];
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
    self.lookForArr = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where day = '%@'",arr[2]];
    if (self.lookForArr.count > 0) {
        for (WeightModel *model in self.lookForArr) {
            [self.timeArr addObject:[NSString stringWithFormat:@"%@:%@",model.hour,model.second]];
            [self.weightArr addObject:[NSNumber numberWithFloat:[model.weight floatValue]]];
        }
        [self.baseView setVerticalDaySource:self.timeArr horizontalValueArray:self.weightArr];
        [self.baseView show];
    } else {
        [self.baseView setVerticalDaySource:@[@"8:30",@"9:30",@"10:45"] horizontalValueArray:@[[NSNumber numberWithFloat:50],[NSNumber numberWithFloat:50.2],[NSNumber numberWithFloat:49.9]]];
        [self.baseView show];
    }
}

- (WeightModel *)getWeightModel {
    WeightModel *model = [[WeightModel alloc]init];
    NSArray *arr = [self getDate];
    model.year = arr[0];
    model.month = arr[1];
    model.day = arr[2];
    model.hour = arr[3];
    model.min = arr[4];
    model.second = arr[5];
    return model;
}

- (NSArray *)getDate {
    NSMutableArray *arrAll = [[NSMutableArray alloc]initWithCapacity:0];
    
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
    
    [arrAll addObject:time1[0]];
    [arrAll addObject:time1[1]];
    [arrAll addObject:time1[2]];
    [arrAll addObject:time2[0]];
    [arrAll addObject:time2[1]];
    [arrAll addObject:time2[2]];
    
    //返回 年、月、日、时、分、秒
    return arrAll;
}


@end
