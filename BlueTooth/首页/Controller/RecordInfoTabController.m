//
//  RecordInfoTabController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/16.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "RecordInfoTabController.h"
#import "HealthScrollContentView.h"
#import "WeightViewController.h"
#import "DrinkViewController.h"
#import "SleepViewController.h"
#import "InforViewController.h"
#import "UIColor+Hex.h"

@interface RecordInfoTabController ()< HealthScrollContentViewDelegate>

@property (nonatomic, strong) HealthScrollContentView *contentView;

@property (nonatomic, strong) UIImageView *energyView;
@property (nonatomic, strong) UIImageView *smallImage;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *moveView;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation RecordInfoTabController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showTag = 0;
        
    }
    return self;
}

- (UIImageView *)energyView {
    if (!_energyView) {
        _energyView = [[UIImageView alloc]init];
        _energyView.image = [UIImage imageNamed:@"发光特效"];
    }
    return _energyView;
}
- (UIImageView *)smallImage {
    if (!_smallImage) {
        _smallImage = [[UIImageView alloc]init];
        _smallImage.image = [UIImage imageNamed:@"能量"];
    }
    return _smallImage;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.backgroundColor = [UIColor colorWithHex:@"f6b000"];
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:10];
        _label.clipsToBounds = YES;
        _label.layer.cornerRadius = 10;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHex:@"28313D" alpha:0.7f];
    UIView *cancelBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 147 * HeightNum)];
    cancelBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cancelBackView];
    
    [self.view addSubview:self.energyView];
    self.energyView.hidden = YES;
    WS(ws);
    [self.energyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelBackView.mas_top).with.offset(55);
        make.centerX.equalTo(cancelBackView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(372 * WidthNum, 326 * HeightNum));
    }];
    [self.energyView addSubview:self.smallImage];
    [self.smallImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.energyView.mas_top).with.offset(0);
        make.centerX.equalTo(ws.energyView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120 * WidthNum, 80 * HeightNum));
    }];
    [self.energyView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.energyView.mas_top).with.offset(65);
        make.centerX.equalTo(ws.energyView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(78 * WidthNum, 20 * HeightNum));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisView)];
    [cancelBackView addGestureRecognizer:tap];
    [self createView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self segmentValue];
}

- (void)createView {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 147 * HeightNum, SCREEN_WIDTH, SCREEN_HEIGHT - 147 * HeightNum)];
    backView.backgroundColor = [UIColor colorWithHex:@"efefef"];
    [self.view addSubview:backView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = backView.bounds;
    maskLayer.path = maskPath.CGPath;
    backView.layer.mask = maskLayer;
    
    NSArray *normalArr = @[@"体重_未选",@"喝水_未选",@"睡眠_未选"];
    NSArray *selectedArr = @[@"体重_已选",@"喝水_已选",@"睡眠_已选"];
    int width = SCREEN_WIDTH/3;
    for (NSInteger index = 0; index <3; index ++) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backView addSubview:self.btn];
        self.btn.backgroundColor = [UIColor whiteColor];
        self.btn.tag = index + 100;
        if (index == self.showTag) {
            self.btn.selected = YES;
        }
        self.btn.frame = CGRectMake(index * width, 0, width, 44);
        [self.btn setImage:[UIImage imageNamed:normalArr[index]] forState:UIControlStateNormal];
        [self.btn setImage:[UIImage imageNamed:selectedArr[index]] forState:UIControlStateSelected];
        [self.btn addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    self.moveView = [[UIView alloc]init];
    self.moveView.backgroundColor = [UIColor colorWithHex:@"ad77cd"];
    [backView addSubview:self.moveView];
    [self.moveView setFrame:CGRectMake(self.showTag * SCREEN_WIDTH/3, CGRectGetMaxY(self.btn.frame), SCREEN_WIDTH/3, 1)];
    
    self.contentView = [[HealthScrollContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.moveView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.moveView.frame))];
    self.contentView.delegate = self;
    [backView addSubview:self.contentView];
    
   
}

- (void)segmentValue {
    
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    WeightViewController *weightHighViewController = [[WeightViewController alloc] init];
    weightHighViewController.delegate = self;
    DrinkViewController *drinkHighViewController = [[DrinkViewController alloc] init];
    drinkHighViewController.delegate = self;
    SleepViewController *sleepHighViewController = [[SleepViewController alloc] init];
    sleepHighViewController.delegate = self;
//    if (self.showTag == 0) {
//        [vcs addObject:weightHighViewController];
//        [vcs addObject:drinkHighViewController];
//        [vcs addObject:sleepHighViewController];
//    } else if (self.showTag == 1) {
//        [vcs addObject:drinkHighViewController];
//        [vcs addObject:weightHighViewController];
//        [vcs addObject:sleepHighViewController];
//    } else {
//        [vcs addObject:sleepHighViewController];
//        [vcs addObject:weightHighViewController];
//        [vcs addObject:drinkHighViewController];
//    }
    [vcs addObject:weightHighViewController];
    [vcs addObject:drinkHighViewController];
    [vcs addObject:sleepHighViewController];
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
    self.contentView.currentIndex = self.showTag;
}


- (void)contentViewDidScroll:(HealthScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress{
    //    NSLog(@"%ld------%ld",fromIndex,toIndex);
}

- (void)contentViewDidEndDecelerating:(HealthScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    //    self.findSegmentView.selectedIndex = endIndex;
    self.showTag = endIndex;
    [self viewChange];
}

#pragma mark -- UITapGestureRecognizer methods
- (void)dismisView {
    [self dismissViewControllerAnimated:NO completion:nil];
}

//切换控制器
- (void)touch:(UIButton *)selectBtn {
    self.contentView.currentIndex = selectBtn.tag - 100;
    self.showTag = selectBtn.tag - 100;
    [self viewChange];
}

- (void)viewChange {
    NSArray *titleArray = @[@"体重",@"喝水",@"睡眠"];
    self.title = titleArray[self.showTag];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [self.view viewWithTag:100 + i];
        if (btn.tag == self.showTag + 100) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.moveView setFrame:CGRectMake(self.showTag * SCREEN_WIDTH/3, CGRectGetMaxY(self.btn.frame), SCREEN_WIDTH/3, 1)];
    }];
}

#pragma mark -- delegate methods
- (void)WeightViewBackIndex:(NSInteger)index {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate RecordTabBackIndex:index];
}

- (void)weightBtnClick:(NSInteger )index {
    if (index == 0) {
        self.label.text = @"能量 +300";
    } else {
        self.label.text = @"能量 +20";
    }
    
    
    self.energyView.hidden = NO;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.energyView.hidden = YES;
    });
}

- (void)DrinkViewBackIndex:(NSInteger)index {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate RecordTabBackIndex:index];
}

- (void)drinkBtnClick {
    self.label.text = @"能量 +20";
    self.energyView.hidden = NO;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.energyView.hidden = YES;
    });
}

- (void)SleepViewBackIndex:(NSInteger)index {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate RecordTabBackIndex:index];
}

- (void)sleepBtnClick {
    self.label.text = @"能量 +200";
    self.energyView.hidden = NO;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.energyView.hidden = YES;
    });
}

@end
