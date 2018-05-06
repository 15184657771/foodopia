//
//  WeightHighViewController.m
//  BlueTooth
//
//  Created by Chen on 2018/4/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "WeightHighViewController.h"
#import "UIColor+Hex.h"
#import "InfoTableViewCell.h"
#import "BaseView.h"
#import <JQFMDB/JQFMDB.h>
#import "WeightModel.h"
#import "NSString+Helper.h"
@interface WeightHighViewController ()<UITableViewDelegate,UITableViewDataSource,BaseViewDelegate>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) BaseView *baseView;

@property (nonatomic, strong) NSArray *lookForDayArr;

@property (nonatomic, strong) NSMutableArray *timeArr;

@property (nonatomic, strong) NSMutableArray *weightArr;

@end

@implementation WeightHighViewController {
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    NSString *piancha;
}

- (NSMutableArray *)timeArr {
    if (!_timeArr) {
        _timeArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _timeArr;
}

- (NSMutableArray *)weightArr {
    if (!_weightArr) {
        _weightArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _weightArr;
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
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"日",@"月",@"年"]];
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
        make.left.equalTo(@(15 * HeightNum));
        make.right.equalTo(@(-15 * HeightNum));
        make.top.equalTo(@(30 * HeightNum));
        make.height.equalTo(@(28 * HeightNum));
    }];
    
    self.baseView = [[BaseView alloc]initWithFrame:CGRectMake(0, 85 * HeightNum, SCREEN_WIDTH, 200 * HeightNum)];
    self.baseView.delegate = self;
    [self.topView addSubview:self.baseView];
    
    NSArray *arr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    //查询当天的数据
    self.lookForDayArr = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where day = '%@'",arr[2]];
    if (self.lookForDayArr.count > 0) {
        for (WeightModel *model in self.lookForDayArr) {
            [self.timeArr addObject:[NSString stringWithFormat:@"%@:%@",model.hour,model.min]];
            [self.weightArr addObject:[NSNumber numberWithFloat:[model.weight floatValue]]];
        }
        [self.baseView setVerticalDaySource:self.timeArr horizontalValueArray:self.weightArr];
        [self.baseView show];
    } else {
        [self.baseView setVerticalDaySource:@[@"8:30",@"9:30",@"10.45"] horizontalValueArray:@[[NSNumber numberWithFloat:50],[NSNumber numberWithFloat:50.2],[NSNumber numberWithFloat:49.9]]];
        [self.baseView show];
    }

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
    
    arr1 = @[@"目前最重",@"目前最轻",@"我想变成"];
    if (self.lookForDayArr.count > 0) {
        WeightModel *model = self.lookForDayArr[self.lookForDayArr.count - 1];
        piancha = [NSString stringWithFormat:@"%.1fkg",[[[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"][@"weight"] floatValue] - [model.weight floatValue]];
    } else {
        piancha = @"目标偏差+5.1kg";
    }
    
    NSArray *lookForArr = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where weight = (select max(weight) from weight)"];
    NSArray *lookForArr2 = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where weight = (select min(weight) from weight)"];
    
    NSLog(@"%@",lookForArr);
    if (lookForArr.count > 0 && lookForArr2.count > 0) {
        WeightModel *model1 = lookForArr[0];  //最重
        WeightModel *model2 = lookForArr2[0]; //最轻
        
        arr2 = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@/%@/%@达成",model1.year,model1.month,model1.day],[NSString stringWithFormat:@"%@/%@/%@达成",model2.year,model2.month,model2.day],piancha, nil];
        arr3 = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@kg",model1.weight],[NSString stringWithFormat:@"%@kg",model2.weight],[NSString stringWithFormat:@"%@kg",[[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"][@"weight"]], nil];
        
    } else {
        arr2 = [NSArray arrayWithObjects:@"2017/09/28达成",@"2018/01/14达成",@"目标偏差+5.1kg", nil];
        arr3 = [NSArray arrayWithObjects:@"57.8kg",@"53.4kg",@"50.0kg", nil];
    }
   
    [self.tableView reloadData];
    
    
}
- (void)changeTypeAction:(UISegmentedControl *)sgc{
    
    NSArray *dateArr = [self getDate];
    JQFMDB *db = [JQFMDB shareDatabase];
    NSArray *dayArr = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where day = '%@'",dateArr[2]];   //1.当日所有数据
    NSArray *monthArr = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where month = '%@'",dateArr[1]]; //1.当月所有数据
    NSArray *yearArr = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where year = '%@'",dateArr[0]];  //1.当年所有数据
    
    
    [self.timeArr removeAllObjects];
    [self.weightArr removeAllObjects];
    
    NSDate *date = [NSDate date];
    switch (sgc.selectedSegmentIndex) {
        case 0:
            if (dayArr.count > 0) {
                for (WeightModel *model in dayArr) {
                    [self.timeArr addObject:[NSString stringWithFormat:@"%@:%@",model.hour,model.min]];
                    [self.weightArr addObject:[NSNumber numberWithFloat:[model.weight floatValue]]];
                }
                [self.baseView setVerticalDaySource:self.timeArr horizontalValueArray:self.weightArr];
                [self.baseView show];
            } else {
                [self.baseView setVerticalDaySource:@[@"8:30",@"9:30",@"10.45"] horizontalValueArray:@[[NSNumber numberWithFloat:50],[NSNumber numberWithFloat:50.2],[NSNumber numberWithFloat:49.9]]];
                [self.baseView show];
            }
            break;
        case 1:
            for (int i = 0;i < 7;i ++) {
                NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"userDic"];
                float weightNum = [dic[@"weight"] floatValue];
                float value=(float)arc4random()/0x100000000;
                float y = weightNum +  (arc4random() % 3) + value;
                [self.timeArr insertObject:[NSString stringWithFormat:@"%@日",[NSString standFromDate:date]] atIndex:0];
                [self.weightArr insertObject:[NSNumber numberWithFloat:y] atIndex:0];

                date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - 24*3600)];
                
            }
            [self.baseView setVerticalDaySource:self.timeArr horizontalValueArray:self.weightArr];
            [self.baseView show];
            break;
        case 2:
            for (int i = 0;i < 7;i ++) {
                NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"userDic"];
                float weightNum = [dic[@"weight"] floatValue];
                float value=(float)arc4random()/0x100000000;
                float y = weightNum +  (arc4random() % 3) + value;
                [self.timeArr insertObject:[NSString stringWithFormat:@"%@年",[NSString yearDate:date]] atIndex:0];
                [self.weightArr insertObject:[NSNumber numberWithFloat:y] atIndex:0];
                
                date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - 24*3600 * 365)];
                
            }
            [self.baseView setVerticalDaySource:self.timeArr horizontalValueArray:self.weightArr];
            [self.baseView show];
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
#pragma mark - BaseViewDelegate
- (void)tapShowNum:(NSNumber *)num {
    [self.baseView setText:[NSString stringWithFormat:@"%.1f",[num floatValue]] andLast:@"kg"];
}

@end
