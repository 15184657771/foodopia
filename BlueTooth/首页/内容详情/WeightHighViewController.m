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

@interface WeightHighViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) BaseView *baseView;
@end

@implementation WeightHighViewController {
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
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
    [self.topView addSubview:self.baseView];
    [self.baseView setVerticalDaySource:@[@"8:30",@"9:30",@"10.45"] horizontalValueArray:@[[NSNumber numberWithFloat:50],[NSNumber numberWithFloat:50.2],[NSNumber numberWithFloat:49.9]]];
    [self.baseView show];
    
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
    
    JQFMDB *db = [JQFMDB shareDatabase];
    NSArray *lookForArr = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where weight = (select max(weight) from weight)"];
    NSArray *lookForArr2 = [db jq_lookupTable:@"weight" dicOrModel:[WeightModel class] whereFormat:@"where weight = (select min(weight) from weight)"];
    
    NSLog(@"%@",lookForArr);
    if (lookForArr.count > 0) {
        WeightModel *model1 = lookForArr[0];  //最重
        WeightModel *model2 = lookForArr2[0]; //最轻
        
        arr2 = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@/%@/%@达成",model1.year,model1.month,model1.day],[NSString stringWithFormat:@"%@/%@/%@达成",model2.year,model2.month,model2.day],@"目标偏差+5.1kg", nil];
        arr3 = [NSArray arrayWithObjects:model1.weight,model2.weight,@"50kg", nil];
        
        [self.tableView reloadData];
    }
   
    
}
- (void)changeTypeAction:(UISegmentedControl *)sgc{
    switch (sgc.selectedSegmentIndex) {
        case 0:
            break;
        case 1:
            break;
        case 2:
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

@end
