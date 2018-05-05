//
//  DrinkHighViewController.m
//  BlueTooth
//
//  Created by Chen on 2018/4/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "DrinkHighViewController.h"
#import "UIColor+Hex.h"
#import "InfoTableViewCell.h"
#import <JQFMDB/JQFMDB.h>
#import "DrinkModel.h"
#import "ErectView.h"


@interface DrinkHighViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) ErectView *erectView;

@property (nonatomic, strong) NSArray *lookForDayArr;

@property (nonatomic, strong) NSMutableArray *timeArr;

@property (nonatomic, strong) NSMutableArray *countArr;

@end

@implementation DrinkHighViewController {
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
}

- (NSMutableArray *)timeArr {
    if (!_timeArr) {
        _timeArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _timeArr;
}

- (NSMutableArray *)countArr {
    if (!_countArr) {
        _countArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _countArr;
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.erectView.maxValue = 3000;
    
    
    NSArray *arr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    //查询当月的数据
    self.lookForDayArr = [db jq_lookupTable:@"weight" dicOrModel:[DrinkModel class] whereFormat:@"where month = '%@'",arr[1]];
    if (self.lookForDayArr.count > 0) {
        for (DrinkModel *model in self.lookForDayArr) {
            [self.timeArr addObject:[NSString stringWithFormat:@"%@:%@",model.hour,model.second]];
            [self.countArr addObject:[NSNumber numberWithFloat:[model.count floatValue]]];
        }
        [self.erectView setVerticalDaySource:self.timeArr horizontalValueArray:self.countArr];
        [self.erectView show];
    } else {
        [self.erectView setVerticalDaySource:@[@"2日",@"3日",@"5日"] horizontalValueArray:@[[NSNumber numberWithFloat:1000],[NSNumber numberWithFloat:1250],[NSNumber numberWithFloat:2000]]];
        [self.erectView show];
    }
    
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
    
    arr1 = @[@"喝的最多",@"喝的最少",@"我要喝够"];
    
    NSArray *lookForArr = [db jq_lookupTable:@"drink" dicOrModel:[DrinkModel class] whereFormat:@"where count = (select max(count) from drink)"];
    NSArray *lookForArr2 = [db jq_lookupTable:@"drink" dicOrModel:[DrinkModel class] whereFormat:@"where count = (select min(count) from drink)"];

    if (lookForArr.count > 0 && lookForArr2.count > 0) {
        DrinkModel *model1 = lookForArr[0];  //最多
        DrinkModel *model2 = lookForArr2[0];  //最少
        
        arr2 = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@/%@/%@达成",model1.year,model1.month,model1.day],[NSString stringWithFormat:@"%@/%@/%@达成",model2.year,model2.month,model2.day],@"目标偏差+250ml", nil];
        arr3 = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ldml",[model1.count integerValue] * 250],[NSString stringWithFormat:@"%ldml",[model2.count integerValue] * 250],[NSString stringWithFormat:@"%@ml",[[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"][@"drink"]], nil];
    } else {
        arr2 = [NSArray arrayWithObjects:@"2017/09/28达成",@"2018/01/14达成",@"目标偏差+250ml", nil];
        arr3 = [NSArray arrayWithObjects:@"2500ml",@"1000ml",@"1250ml", nil];
    }
    
    [self.tableView reloadData];
    
}
- (void)changeTypeAction:(UISegmentedControl *)sgc{
    
    NSArray *dateArr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    NSArray *monthArr = [db jq_lookupTable:@"drink" dicOrModel:[DrinkModel class] whereFormat:@"where month = '%@'",dateArr[1]]; //1.当月所有数据
    NSArray *yearArr = [db jq_lookupTable:@"drink" dicOrModel:[DrinkModel class] whereFormat:@"where year = '%@'",dateArr[0]];  //1.当年所有数据
    [self.timeArr removeAllObjects];
    [self.countArr removeAllObjects];
    switch (sgc.selectedSegmentIndex) {
        case 0:
            
            if (monthArr.count > 0) {
                for (DrinkModel *model in monthArr) {
                    [self.timeArr addObject:[NSString stringWithFormat:@"%@日",model.day]];
                    [self.countArr addObject:[NSNumber numberWithFloat:[model.count floatValue] * 250]];
                }
                [self.erectView setVerticalDaySource:self.timeArr horizontalValueArray:self.countArr];
                [self.erectView show];
            } else {
                [self.erectView setVerticalDaySource:@[@"2日",@"3日",@"5日"] horizontalValueArray:@[[NSNumber numberWithFloat:1000],[NSNumber numberWithFloat:1250],[NSNumber numberWithFloat:2000]]];
                [self.erectView show];
            }
            
            break;
        case 1:
            if (yearArr.count > 0) {
                for (DrinkModel *model in monthArr) {
                    [self.timeArr addObject:[NSString stringWithFormat:@"%@月",model.month]];
                    [self.countArr addObject:[NSNumber numberWithFloat:[model.count floatValue] * 250]];
                }
                [self.erectView setVerticalDaySource:self.timeArr horizontalValueArray:self.countArr];
                [self.erectView show];
            } else {
                [self.erectView setVerticalDaySource:@[@"2月",@"3月",@"5月"] horizontalValueArray:@[[NSNumber numberWithFloat:1000],[NSNumber numberWithFloat:1250],[NSNumber numberWithFloat:2000]]];
                [self.erectView show];
            }
            
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
    cell.bigLabel.text = arr1[indexPath.row];
    cell.dateLabel.text = arr2[indexPath.row];
    cell.timeLabel.text = arr3[indexPath.row];
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
