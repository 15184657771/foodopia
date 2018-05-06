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
#import "RefrigeratorViewController.h"

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
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(95, 70, 90, 90)];
        [_headerView addSubview:self.headImage];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, CGRectGetMaxY(self.headImage.frame) + 5, 90, 20)];
        self.nameLabel.font = [UIFont systemFontOfSize:20];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:self.nameLabel];
        
    }
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"userPic.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    self.headImage.image = savedImage;
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    
    self.headImage.userInteractionEnabled = YES;
    [self.headImage.layer setCornerRadius:45];
    [self.headImage.layer setMasksToBounds:YES];
    self.headImage.layer.borderWidth = 2;
    self.headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upPic)];
//    [self.headImage addGestureRecognizer:tap];
    
    
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

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveUserInfo) name:@"userInfo" object:nil];
    
    [self createView];
}

- (void)receiveUserInfo {
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"userPic.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    self.headImage.image = savedImage;
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
//    headView.backgroundColor = [UIColor redColor];
    return headView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SlideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"slideCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SlideModel *model = self.sourceArray[indexPath.section];
    [cell setValueWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        InforViewController *inforViewController = [[InforViewController alloc]init];
        inforViewController.showTag = 0;
        [self XYSidePushViewController:inforViewController animated:YES];
    } else if (indexPath.row == 1) {
        RefrigeratorViewController *refrigeratorVC = [[RefrigeratorViewController alloc]init];
        [self.navigationController pushViewController:refrigeratorVC animated:YES];
    }
    
}



@end
