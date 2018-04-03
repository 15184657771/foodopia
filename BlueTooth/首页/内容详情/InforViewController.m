//
//  InforViewController.m
//  BlueTooth
//
//  Created by Chen on 2018/4/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "InforViewController.h"
#import "HealthScrollContentView.h"
#import "WeightHighViewController.h"
#import "DrinkHighViewController.h"
#import "SleepHighViewController.h"

@interface InforViewController ()< HealthScrollContentViewDelegate>

@property (nonatomic, strong) HealthScrollContentView *contentView;
@property (nonatomic, strong) UIView *moveView;

@end

@implementation InforViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showTag = 0;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createView];
    [self segmentValue];

    
}

- (void)createView {
    WS(ws);
    NSArray *normalArr = @[@"体重_未选",@"喝水_未选",@"睡眠_未选"];
    NSArray *selectedArr = @[@"体重_已选",@"喝水_已选",@"睡眠_已选"];
    int width = SCREEN_WIDTH/3;
    for (NSInteger index = 0; index <3; index ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = index + 100;
        if (index == self.showTag) {
            btn.selected = YES;
        }
        btn.frame = CGRectMake(index * width, 0, width, 52);
        [btn setImage:[UIImage imageNamed:normalArr[index]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectedArr[index]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.contentView = [[HealthScrollContentView alloc] init];
    self.contentView.delegate = self;
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws.view);
        make.top.equalTo(@52);
    }];
    self.moveView = [[UIView alloc]init];
    [self.moveView setBackgroundColor:RGB(173, 119, 205)];
    [self.view addSubview:self.moveView];
    [self.moveView setFrame:CGRectMake(self.showTag * SCREEN_WIDTH/3, 51.5, SCREEN_WIDTH/3, 1)];
}

- (void)segmentValue {

    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    WeightHighViewController *weightHighViewController = [[WeightHighViewController alloc] init];
    DrinkHighViewController *drinkHighViewController = [[DrinkHighViewController alloc] init];
    SleepHighViewController *sleepHighViewController = [[SleepHighViewController alloc] init];
    [vcs addObject:weightHighViewController];
    [vcs addObject:drinkHighViewController];
    [vcs addObject:sleepHighViewController];
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.contentView.currentIndex = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)contentViewDidScroll:(HealthScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress{
    //    NSLog(@"%ld------%ld",fromIndex,toIndex);
}

- (void)contentViewDidEndDecelerating:(HealthScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
//    self.findSegmentView.selectedIndex = endIndex;
    self.showTag = endIndex;
    [self viewChange];
}

//切换控制器
- (void)touch:(UIButton *)selectBtn {
    self.contentView.currentIndex = selectBtn.tag - 100;
    self.showTag = selectBtn.tag - 100;
    [self viewChange];
}

- (void)viewChange {
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [self.view viewWithTag:100 + i];
        if (btn.tag == self.showTag + 100) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.moveView setFrame:CGRectMake(self.showTag * SCREEN_WIDTH/3, 51.5, SCREEN_WIDTH/3, 1)];
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

@end
