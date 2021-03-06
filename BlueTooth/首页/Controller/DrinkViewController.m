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

@property (nonatomic, strong) NSArray *lookForArr;

@end

@implementation DrinkViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    JQFMDB *db = [JQFMDB shareDatabase];
    DrinkModel *model = [[DrinkModel alloc]init];
    if (![db jq_isExistTable:@"drink"]) {
        if ([db jq_createTable:@"drink" dicOrModel:model]) {
            NSLog(@"创建成功！！！");
        }
    }
    
    [self createUI];
    
}

- (void)createUI {
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 58, SCREEN_WIDTH - 50 * 2, 134 * HeightNum)];
    self.imageView.image = [UIImage imageNamed:@"水杯"];
    [self.view addSubview:self.imageView];
    [self gifPlay];
    self.drinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.drinkBtn.frame = CGRectMake(50, CGRectGetMaxY(self.imageView.frame) + 28, SCREEN_WIDTH - 50 * 2, 44 * HeightNum);
    self.drinkBtn.backgroundColor = RGB(173, 119, 205);
    [self.drinkBtn setTitle:@"喝一杯" forState:UIControlStateNormal];
    self.drinkBtn.layer.cornerRadius = 20;
    self.drinkBtn.clipsToBounds = YES;
    [self.drinkBtn addTarget:self action:@selector(drinkBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.drinkBtn];

    NSArray *arr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    
    //查询当天的数据
    self.lookForArr = [db jq_lookupTable:@"drink" dicOrModel:[DrinkModel class] whereFormat:@"where day = '%@' and year = '%@' and month = '%@'",arr[2],arr[0],arr[1]];
    NSLog(@"where day:%@", self.lookForArr);
    
    if (self.lookForArr.count > 0) {
        DrinkModel *model = self.lookForArr[0];
        self.drinkView = [[RecordDrinkView alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(self.drinkBtn.frame) + 30, SCREEN_WIDTH - 18 * 2, 167 * HeightNum)];
        [self.drinkView setUpCount:[model.count integerValue]];
        [self.view addSubview:self.drinkView];
    } else {
        self.drinkView = [[RecordDrinkView alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(self.drinkBtn.frame) + 30, SCREEN_WIDTH - 18 * 2, 167 * HeightNum)];
        [self.drinkView setUpCount:0];
        [self.view addSubview:self.drinkView];
    }

    UITapGestureRecognizer *drinkTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(drinkTapAction)];
    [self.drinkView addGestureRecognizer:drinkTap];
    
}

#pragma mark -- UITapGestureRecognizer
- (void)drinkTapAction {
    [self.delegate DrinkViewBackIndex:1];
}
#pragma mark -- button click methods
- (void)drinkBtnAction:(UIButton *)sender {
    
    [self.imageView startAnimating];
    
    dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
        [self.imageView stopAnimating];
        
        
    });
    
    NSArray *arr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    self.lookForArr = [db jq_lookupTable:@"drink" dicOrModel:[DrinkModel class] whereFormat:@"where day = '%@'",arr[2]];
    if (self.lookForArr.count > 0) {   //如果今天有数据， 更新count+1
        DrinkModel *model = self.lookForArr[0];
        model.count = [NSString stringWithFormat:@"%ld",[model.count integerValue] + 1];
        [db jq_updateTable:@"drink" dicOrModel:model whereFormat:@"WHERE rowid = (SELECT min(rowid) FROM drink)"];
        [self.drinkView setUpCount:[model.count integerValue]];
        [self.drinkView layoutSubviews];
    } else {
        [self.drinkView setUpCount:1];
        [self.drinkView layoutSubviews];
        DrinkModel *model = [self getDrinkModel];
        model.count = @"1";
        if ([db jq_insertTable:@"drink" dicOrModel:model]) {
            NSLog(@"插入成功！！！");
        }   
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger percentNum = [[user objectForKey:@"percentNum"] integerValue];
    [user setObject:[NSString stringWithFormat:@"%ld",percentNum + 200] forKey:@"percentNum"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"powerChange" object:nil];
    [self.delegate drinkBtnClick];
}



- (DrinkModel *)getDrinkModel {
    DrinkModel *model = [[DrinkModel alloc]init];
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

- (void)gifPlay {
    self.imageView.animationImages = @[
                                       [UIImage imageNamed:@"喝水动画_00000"],
                                       [UIImage imageNamed:@"喝水动画_00001"],
                                       [UIImage imageNamed:@"喝水动画_00002"],
                                       [UIImage imageNamed:@"喝水动画_00003"],
                                       [UIImage imageNamed:@"喝水动画_00004"],
                                       [UIImage imageNamed:@"喝水动画_00005"],
                                       [UIImage imageNamed:@"喝水动画_00006"],
                                       [UIImage imageNamed:@"喝水动画_00007"],
                                       [UIImage imageNamed:@"喝水动画_00008"],
                                       [UIImage imageNamed:@"喝水动画_00009"],
                                       [UIImage imageNamed:@"喝水动画_00010"],
                                       [UIImage imageNamed:@"喝水动画_00011"],
                                       [UIImage imageNamed:@"喝水动画_00012"],
                                       [UIImage imageNamed:@"喝水动画_00013"],
                                       [UIImage imageNamed:@"喝水动画_00014"],
                                       [UIImage imageNamed:@"喝水动画_00015"],
                                       [UIImage imageNamed:@"喝水动画_00016"],
                                       [UIImage imageNamed:@"喝水动画_00017"],
                                       [UIImage imageNamed:@"喝水动画_00018"],
                                       [UIImage imageNamed:@"喝水动画_00019"],
                                       
                                       ];
    
    self.imageView.animationDuration = 2.0f;
    self.imageView.animationRepeatCount = 1;
    [self.view addSubview: self.imageView];
    
}

@end
