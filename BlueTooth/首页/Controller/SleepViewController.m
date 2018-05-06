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
#import <JQFMDB/JQFMDB.h>
#import "SleepModel.h"
#import "NSString+Helper.h"

@interface SleepViewController ()


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int count;

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong)UIButton *button;

@property (nonatomic, strong)RecordSleepView *recordView;
@end

@implementation SleepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    JQFMDB *db = [JQFMDB shareDatabase];
    SleepModel *model = [[SleepModel alloc]init];
    if (![db jq_isExistTable:@"sleep"]) {
        if ([db jq_createTable:@"sleep" dicOrModel:model]) {
            NSLog(@"创建成功！！！");
        }
    }
    
    [self createUI];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)createUI {
    
    //获取当前时间
    NSArray *arr = [self getDate];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH, 32)];
    
    if ([arr[3] integerValue] >= 18) {
        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@ pm",arr[3],arr[4]];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@ am",arr[3],arr[4]];
    }
    self.timeLabel.textColor = [UIColor colorWithHex:@"ad77cd"];
    self.timeLabel.font = [UIFont systemFontOfSize:30];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.timeLabel];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(self.timeLabel.frame) + 20, SCREEN_WIDTH - 40 * 2, 108 * HeightNum)];
    [self.view addSubview:self.imageView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(50, CGRectGetMaxY(self.imageView.frame) + 28, SCREEN_WIDTH - 50 * 2, 44 * HeightNum);
    self.button.backgroundColor = RGB(173, 119, 205);
    self.button.layer.cornerRadius = 20;
    self.button.clipsToBounds = YES;
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
   
    
//    if ([arr[3] integerValue] >= 18) {
        self.imageView.image = [UIImage imageNamed:@"睡觉"];
        [self.button setTitle:@"去 睡 觉" forState:UIControlStateNormal];
        if ([[NSString notNullStr:[[NSUserDefaults standardUserDefaults] objectForKey:@"shuijiao"]] isEqualToString:[NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]]]) {
            self.button.enabled = NO;
        } else {
            self.button.enabled = YES;
        }
//    } else {
//        self.imageView.image = [UIImage imageNamed:@"起床"];
//        [self.button setTitle:@"起 床 了" forState:UIControlStateNormal];
//        if ([[NSString notNullStr:[[NSUserDefaults standardUserDefaults] objectForKey:@"qichuang"]] isEqualToString:[NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]]]) {
//            self.button.enabled = NO;
//        } else {
//            self.button.enabled = YES;
//        }
//    }
    
    
    
    self.recordView = [[RecordSleepView alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(self.button.frame) + 30, SCREEN_WIDTH - 18 * 2, 146 * HeightNum)];
    [self.view addSubview:self.recordView];
    
    JQFMDB *db = [JQFMDB shareDatabase];
    NSArray *array = [db jq_lookupTable:@"sleep" dicOrModel:[SleepModel class] whereFormat:@"WHERE rowid = (SELECT min(rowid) FROM sleep)"];
    
    if (array.count > 0) {
        SleepModel *model = array[0];
        if ([model.isAll isEqualToString:@"NO"]) {
            NSArray *dateArr = [self getDate]; //点起床的时间
            NSString *endStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",dateArr[0],dateArr[1],dateArr[2],dateArr[3],dateArr[4],dateArr[5]];
            //记录的睡觉的时间
            NSString *startStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",model.year,model.month,model.day,model.hour,model.min,model.second];
            
            NSDateComponents *cmps = [self pleaseInsertStarTimeo:startStr andInsertEndTime:endStr];
            
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
            self.count = cmps.hour * 3600 + cmps.minute * 60 + cmps.second;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatShowTime) userInfo:@"admin" repeats:YES];
            
            [self.recordView setText:[NSString stringWithFormat:@"%.2ld时 %.2ld分 %.2ld秒",cmps.hour,cmps.minute,cmps.second]];
            
            
            
        } else {
            [self.recordView setText:@"00时 00分 00秒"];
        }
    } else {
        [self.recordView setText:@"00时 00分 00秒"];
    }
    
    

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
    [self.delegate sleepBtnClick];
    NSArray *dateArr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    if ([sender.currentTitle isEqualToString:@"起 床 了"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@-%@-%@",dateArr[0],dateArr[1],dateArr[2]] forKey:@"qichuang"];
        //TODO:
        NSArray *arr = [db jq_lookupTable:@"sleep" dicOrModel:[SleepModel class] whereFormat:@"where isAll = 'NO'"];
        
        if (arr.count > 0) {
            NSArray *dateArr = [self getDate]; //点起床的时间
            NSString *endStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",dateArr[0],dateArr[1],dateArr[2],dateArr[3],dateArr[4],dateArr[5]];
            
            SleepModel *model = arr[arr.count - 1]; //记录的睡觉的时间
            NSString *startStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",model.year,model.month,model.day,model.hour,model.min,model.second];
            
            NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
            NSString *time = [NSString stringWithFormat:@"%f",a - [model.time floatValue]];
            
            NSDateComponents *cmps = [self pleaseInsertStarTimeo:startStr andInsertEndTime:endStr];
            NSString *sleepStr = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld:%ld",cmps.year,cmps.month,cmps.day,cmps.hour,cmps.minute,cmps.second];
            [db jq_updateTable:@"sleep" dicOrModel:@{@"time":time,@"sleepTime":sleepStr,@"isAll":@"YES"} whereFormat:@"WHERE rowid = (SELECT max(rowid) FROM sleep)"];
            
            NSArray *array = [db jq_lookupTable:@"sleep" dicOrModel:[SleepModel class] whereFormat:@"where isAll = 'YES'"];
            
            if (array.count > 0) {
                SleepModel *model = array[array.count - 1];
                NSArray *arr1 = [model.sleepTime componentsSeparatedByString:@" "];
                NSArray *arr2 = [arr1[1] componentsSeparatedByString:@":"];
                [self.recordView setText:[NSString stringWithFormat:@"%@时 %@分 %@秒",arr2[0],arr2[1],arr2[2]]];
                
            } else {
                [self.recordView setText:@"00时 00分 00秒"];
            }
            
        }
    } else {
        
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.count = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatShowTime) userInfo:@"admin" repeats:YES];
        
        //TODO:
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@-%@-%@",dateArr[0],dateArr[1],dateArr[2]] forKey:@"shuijiao"];
        SleepModel *model = [self getSleepModel];
        model.sleepTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",model.year,model.month,model.day,model.hour,model.min,model.second];
        model.isAll = @"NO";
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970]*1000;
        model.time = [NSString stringWithFormat:@"%f", a];
        
        if ([db jq_insertTable:@"sleep" dicOrModel:model]) {
            NSLog(@"插入成功！！！");
        }
    }
}

- (void)repeatShowTime {
    self.count++;
    [self.recordView setText:[NSString stringWithFormat:@"%02d时 %02d分 %02d秒",self.count/3600,self.count/60,self.count%60]];
}

- (NSDateComponents *)pleaseInsertStarTimeo:(NSString *)time1 andInsertEndTime:(NSString *)time2{
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    // 4.输出结果
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return cmps;
}

- (SleepModel *)getSleepModel {
    SleepModel *model = [[SleepModel alloc]init];
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
