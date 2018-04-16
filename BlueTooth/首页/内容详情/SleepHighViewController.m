//
//  SleepHighViewController.m
//  BlueTooth
//
//  Created by Chen on 2018/4/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "SleepHighViewController.h"
#import "UIColor+Hex.h"
#import "InfoTableViewCell.h"
#import "ErectView.h"
#import "SleepModel.h"
#import <JQFMDB/JQFMDB.h>

@interface SleepHighViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) ErectView *erectView;

@end

@implementation SleepHighViewController

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor colorWithHex:@"fafafa"];
    }
    return _topView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self creatView];
}

- (void)creatView {
    WS(ws);
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(@0);
        make.height.equalTo(@(285 * HeightNum));
    }];
    
    self.erectView = [[ErectView alloc]initWithFrame:CGRectMake(0, 85 * HeightNum, SCREEN_WIDTH, 200 * HeightNum)];
    [self.topView addSubview:self.erectView];
    self.erectView.maxValue = 12;
    [self.erectView setVerticalDaySource:@[@"5.2",@"5.3",@"5.5"] horizontalValueArray:@[[NSNumber numberWithFloat:9.1],[NSNumber numberWithFloat:7.2],[NSNumber numberWithFloat:10.2]]];
    [self.erectView show];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"月",@"年"]];
    _segmentedControl.backgroundColor = [UIColor clearColor];
    _segmentedControl.momentary = NO;
    _segmentedControl.tintColor = RGB(173, 119, 205);
    _segmentedControl.selectedSegmentIndex = 0;
    NSDictionary *selected = @{NSFontAttributeName :[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    NSDictionary *normal = @{NSFontAttributeName :[UIFont systemFontOfSize:13],
                             NSForegroundColorAttributeName:RGB(173, 119, 205)};
    [_segmentedControl setTitleTextAttributes:selected forState:UIControlStateSelected];
    [_segmentedControl setTitleTextAttributes:normal forState:UIControlStateNormal];
    [_segmentedControl addTarget:self action:@selector(changeTypeAction:) forControlEvents:UIControlEventValueChanged];
    [self.topView addSubview:_segmentedControl];
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.top.equalTo(@30);
        make.height.equalTo(@28);
    }];
    
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.topView.mas_bottom);
        make.left.right.equalTo(ws.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(ws.view);
        }
    }];
    
}
- (void)changeTypeAction:(UISegmentedControl *)sgc{
    NSArray *dateArr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    NSArray *monthArr = [db jq_lookupTable:@"sleep" dicOrModel:[SleepModel class] whereFormat:@"where month = '%@'",dateArr[1]]; //1.当月所有数据
    NSArray *yearArr = [db jq_lookupTable:@"sleep" dicOrModel:[SleepModel class] whereFormat:@"where year = '%@'",dateArr[0]];  //1.当年所有数据
    
    switch (sgc.selectedSegmentIndex) {
        case 0:
            break;
        case 1:
            break;
        default:
            break;
    }
}

#pragma mark --
#pragma mark --UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark --
#pragma mark --UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[InfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoTableViewCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.bigLabel.text = @"睡得最多";
    cell.dateLabel.text = @"2017/09/28 达成";
    cell.timeLabel.text = @"12h 34min";
    return cell;
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
