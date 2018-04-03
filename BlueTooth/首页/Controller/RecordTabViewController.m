//
//  RecordTabViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/2.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "RecordTabViewController.h"
#import "UIColor+Hex.h"
#import "WeightViewController.h"
#import "DrinkViewController.h"
#import "SleepViewController.h"

@interface RecordTabViewController ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong)UIViewController *currentVC;

@property (nonatomic, strong)WeightViewController *weightVC;
@property (nonatomic, strong)DrinkViewController *drinkVC;
@property (nonatomic, strong)SleepViewController *sleepVC;

@end

@implementation RecordTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"28313D" alpha:0.7f];
    
    UIView *cancelBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 147 * HeightNum)];
    cancelBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cancelBackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisView)];
    [cancelBackView addGestureRecognizer:tap];
    //切换栏
    [self setUpSelectedBar];
    
    //设置子控制器
    [self configChildControllers];
}

- (void)setUpSelectedBar {

    CGFloat width = [UIScreen mainScreen].bounds.size.width /3;
    
    NSArray *normalArr = @[@"体重_未选",@"喝水_未选",@"睡眠_未选"];
    NSArray *selectedArr = @[@"体重_已选",@"喝水_已选",@"睡眠_已选"];
    for (NSInteger index = 0; index <3; index ++) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:self.btn];
        self.btn.backgroundColor = [UIColor whiteColor];
        self.btn.tag = index + 100;
        self.btn.frame = CGRectMake(index *width, 147 * HeightNum, width, 44);
        [self.btn setImage:[UIImage imageNamed:normalArr[index]] forState:UIControlStateNormal];
        [self.btn setImage:[UIImage imageNamed:selectedArr[index]] forState:UIControlStateSelected];
        [self.btn addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        
        if (index == 0) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.btn.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.btn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.btn.layer.mask = maskLayer;
        } else if (index == 2) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.btn.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.btn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.btn.layer.mask = maskLayer;
        }
    }
    
    UILabel *backLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btn.frame), SCREEN_WIDTH, 1)];
    backLineLabel.backgroundColor = [UIColor colorWithHex:@"efefef"];
    [self.view addSubview:backLineLabel];
    
    self.lineLabel = [[UILabel alloc]init];
    self.lineLabel.frame = CGRectMake(0, CGRectGetMaxY(self.btn.frame), SCREEN_WIDTH / 3, 1);
    self.lineLabel.backgroundColor = [UIColor colorWithHex:@"ad77cd"];
    [self.view addSubview:self.lineLabel];
    
}

- (void)configChildControllers {
    self.weightVC = [[WeightViewController alloc]init];
    [self.weightVC.view setFrame:CGRectMake(0, CGRectGetMaxY(self.lineLabel.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.lineLabel.frame))];
    [self addChildViewController:self.weightVC];
    self.drinkVC = [[DrinkViewController alloc]init];
    [self.drinkVC.view setFrame:CGRectMake(0, CGRectGetMaxY(self.lineLabel.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.lineLabel.frame))];    [self addChildViewController:self.drinkVC];
    self.sleepVC = [[SleepViewController alloc]init];
    [self.sleepVC.view setFrame:CGRectMake(0, CGRectGetMaxY(self.lineLabel.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(self.lineLabel.frame))];
    [self addChildViewController:self.sleepVC];
    
    [self.view addSubview:self.weightVC.view];
     self.currentVC = self.weightVC;
}


#pragma mark -- UITapGestureRecognizer methods
- (void)dismisView {
    [self dismissViewControllerAnimated:NO completion:nil];
}

//切换控制器
- (void)touch:(UIButton *)btn {
    [self selectTab:btn.tag];
}

#pragma mark - Actions
-(void)selectTab:(NSUInteger)index {
    //获取当前的btn
    UIButton *btn = [self.view viewWithTag:index];
    /** 把以前选中的button设置为不选中 */
    self.selectedBtn.selected = NO;
    /** 把当前选中的button设置为选中 */
    btn.selected = YES;
    /** 把当前选中的button赋值给全局button */
    self.selectedBtn = btn;
    
    if (index == 100) {
        if (self.currentVC == self.weightVC) {
            return;
        } else {
           [self replaceController:self.currentVC newController:self.weightVC];
        }
        self.lineLabel.frame = CGRectMake(0, CGRectGetMaxY(self.btn.frame), SCREEN_WIDTH / 3, 1);
    } else if (index == 101) {
        if (self.currentVC == self.drinkVC) {
            return;
        } else {
            [self replaceController:self.currentVC newController:self.drinkVC];
        }
        self.lineLabel.frame = CGRectMake(SCREEN_WIDTH / 3, CGRectGetMaxY(self.btn.frame), SCREEN_WIDTH / 3, 1);
    } else {
        if (self.currentVC == self.sleepVC) {
            return;
        } else {
            [self replaceController:self.currentVC newController:self.sleepVC];
        }
        self.lineLabel.frame = CGRectMake(SCREEN_WIDTH / 3 * 2, CGRectGetMaxY(self.btn.frame), SCREEN_WIDTH / 3, 1);
    }
    
  
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController {
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
            self.currentVC = oldController;
            
        }
    }];
}


@end
