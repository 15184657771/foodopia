//
//  SideViewController.m
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import "SideViewController.h"
#import "SlideCell.h"
#import "SlideModel.h"
@interface SideViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation SideViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(160, 134, 208);
    self.sourceArray = [NSMutableArray array];
    NSArray* strArray = @[@"我的数据",@"储物冰箱",@"旅行日志",@"旅行商店",@"荣誉徽章",@"同行好友"];
    NSArray* imageArray = @[@"page",@"page",@"page",@"page",@"page",@"page"];
    for (int i = 0; i < 6; i++) {
        SlideModel *model = [[SlideModel alloc]init];
        model.titleStr= strArray[i];
        model.imageName= imageArray[i];
        [self.sourceArray addObject:model];
    }

    [self createView];
}

- (void)createView {
    [self.view addSubview:self.tableView];
    WS(ws);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(ws.view.mas_safeAreaLayoutGuideBottom);
            make.top.equalTo(ws.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.bottom.equalTo(ws.view);
        }
    }];
    [self.tableView registerClass:[SlideCell class] forCellReuseIdentifier:@"slideCell"];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SlideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"slideCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SlideModel *model = self.sourceArray[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



@end
