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
#import "UIViewController+XYSideCategory.h"
#import "InforViewController.h"

@interface SideViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation SideViewController

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 235)];
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(95, 70, 98, 98)];
        [_headerView addSubview:self.headImage];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(96, CGRectGetMaxY(self.headImage.frame) + 5, 200, 20)];
        self.nameLabel.font = [UIFont systemFontOfSize:20];
        self.nameLabel.textColor = [UIColor whiteColor];
        [_headerView addSubview:self.nameLabel];
        
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userDic"]) {
        self.headImage.image = [[NSUserDefaults standardUserDefaults]objectForKey:@"headImage"];
        self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    } else {
        self.headImage.image = [UIImage imageNamed:@"添加头像"];
        self.nameLabel.text = @"李李李阿鹿";
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sourceArray = [NSMutableArray array];
    NSArray* strArray = @[@"我的数据",@"储物冰箱",@"旅行日志",@"旅行商店",@"荣誉徽章",@"同行好友"];
    NSArray* imageArray = @[@"我的数据icon",@"储物冰箱icon",@"旅行日志icon",@"商店",@"徽章",@"我的好友"];
    for (int i = 0; i < 6; i++) {
        SlideModel *model = [[SlideModel alloc]init];
        model.titleStr= strArray[i];
        model.imageName= imageArray[i];
        [self.sourceArray addObject:model];
    }

    [self createView];
}

- (void)createView {
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageview.image = [UIImage imageNamed:@"背景图"];
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];
    [imageview addSubview:self.tableView];
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
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 42;
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
    
    if (indexPath.row == 0) {
        InforViewController *inforViewController = [[InforViewController alloc]init];
        inforViewController.showTag = 0;
        [self XYSidePushViewController:inforViewController animated:YES];
    }
    
}



@end
