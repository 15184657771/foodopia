//
//  PetViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "PetViewController.h"
#import "RefrigeratorViewController.h"
#import "UIViewController+XYSideCategory.h"

@interface PetViewController ()
//背景
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;

//能量提示view
@property (strong, nonatomic) IBOutlet UIView *energyView;

//提示文字
@property (strong, nonatomic) IBOutlet UIImageView *toastView;
//熊
@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
 
//地图
@property (strong, nonatomic) IBOutlet UIView *locationView;
//冰箱
@property (strong, nonatomic) IBOutlet UIView *RefrigeratorView;
//饥饿提示
@property (strong, nonatomic) IBOutlet UIImageView *hungerImageView;

//喂养
@property (strong, nonatomic) IBOutlet UIButton *eatBtn;
//喂食物的view
@property (strong, nonatomic) IBOutlet UIView *eatView;
@property (strong, nonatomic) IBOutlet UIImageView *eatTopImage;
@property (strong, nonatomic) IBOutlet UIImageView *foodImageView;

@end

@implementation PetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
    
    UITapGestureRecognizer *bigImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigImageTap)];
    [self.bigImageView addGestureRecognizer:bigImageTap];
    
    UITapGestureRecognizer *locationViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationViewTap)];
    [self.locationView addGestureRecognizer:locationViewTap];
    
    UITapGestureRecognizer *RefrigeratorViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RefrigeratorViewTap)];
    [self.RefrigeratorView addGestureRecognizer:RefrigeratorViewTap];

    
    UITapGestureRecognizer *eatViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(eatViewTap)];
    [self.eatView addGestureRecognizer:eatViewTap];
   
}

- (void)setUpUI {
    self.backImageView.userInteractionEnabled = YES;
    self.bigImageView.userInteractionEnabled = YES;
    self.eatView.hidden = YES;
    self.energyView.hidden = YES;
    self.hungerImageView.hidden = YES;
    
    self.backImageView.image = [UIImage imageNamed:@"0-背景"];
    self.bigImageView.image = [UIImage imageNamed:@"原始形态"];
    self.toastView.hidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)bigImageTap {
   
//    //如果是原始形态
    if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"原始形态"])]){
        NSLog(@"原始形态");
        self.toastView.hidden = YES;
        self.bigImageView.image = [UIImage imageNamed:@"0-熊"];
        self.hungerImageView.hidden = NO;
    }

}

- (void)locationViewTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RefrigeratorViewTap {
    RefrigeratorViewController *refrigeratorVC = [[RefrigeratorViewController alloc]init];
    [self.navigationController pushViewController:refrigeratorVC animated:YES];
}

- (void)eatViewTap {
    
    self.foodImageView.hidden = YES;
    self.hungerImageView.hidden = YES;
    if ([UIImagePNGRepresentation(self.foodImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"0-巧克力纸杯蛋糕"])]){
        self.eatTopImage.image = [UIImage imageNamed:@"0-旋转飞起"];
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            self.bigImageView.image = [UIImage imageNamed:@"1-熊"];
            self.backImageView.image = [UIImage imageNamed:@"1-背景"];
            self.eatView.hidden = YES;
            self.energyView.hidden = NO;
            self.eatBtn.hidden = NO;
            self.locationView.hidden = NO;
            self.RefrigeratorView.hidden = NO;
        });
        
        dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime2, dispatch_get_main_queue(), ^{

            self.energyView.hidden = YES;
            self.hungerImageView.hidden = NO;
            
        });
  
    } else if ([UIImagePNGRepresentation(self.foodImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"1-蓝莓慕斯"])]) {
        
        self.eatTopImage.image = [UIImage imageNamed:@"1-旋转飞起"];
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            self.bigImageView.image = [UIImage imageNamed:@"2-熊"];
            self.backImageView.image = [UIImage imageNamed:@"2-背景"];
            self.eatView.hidden = YES;
            self.energyView.hidden = NO;
            self.eatBtn.hidden = NO;
            self.locationView.hidden = NO;
            self.RefrigeratorView.hidden = NO;
            
        });
        dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
            self.energyView.hidden = YES;
            self.hungerImageView.hidden = NO;
            
        });
        
    } else if ([UIImagePNGRepresentation(self.foodImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"2-草莓芝士"])]) {
        self.eatTopImage.image = [UIImage imageNamed:@"2-旋转飞起"];
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            self.bigImageView.image = [UIImage imageNamed:@"3-熊"];
            self.backImageView.image = [UIImage imageNamed:@"3-背景"];
            self.eatView.hidden = YES;
            self.energyView.hidden = NO;
            self.eatBtn.hidden = NO;
            self.locationView.hidden = NO;
            self.RefrigeratorView.hidden = NO;
            
        });
        dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
            
            self.energyView.hidden = YES;
            self.hungerImageView.hidden = NO;
            
        });
    } else if ([UIImagePNGRepresentation(self.foodImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"3-抹茶蛋糕卷"])]) {
        self.eatTopImage.image = [UIImage imageNamed:@"3-旋转飞起"];
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            self.bigImageView.image = [UIImage imageNamed:@"4-熊"];
            self.backImageView.image = [UIImage imageNamed:@"4-背景"];
            self.eatView.hidden = YES;
            self.energyView.hidden = NO;
            self.eatBtn.hidden = NO;
            self.locationView.hidden = NO;
            self.RefrigeratorView.hidden = NO;
            
        });
        dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
            self.energyView.hidden = YES;
            self.hungerImageView.hidden = NO;
            self.hungerImageView.image = [UIImage imageNamed:@"完成提示气泡"];
            
        });
    }
}


- (IBAction)leftBtnAction:(UIButton *)sender {
    [self XYSideOpenVC];
}


- (IBAction)eatBtnAction:(UIButton *)sender {
    if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"0-熊"])]){
        NSLog(@"0-熊");
        //冰箱中是否有巧克力
//        您还未获得食物
        
        self.eatView.hidden = NO;
        self.foodImageView.hidden = NO;
        self.eatBtn.hidden = YES;
        self.locationView.hidden = YES;
        self.RefrigeratorView.hidden = YES;
        self.foodImageView.image = [UIImage imageNamed:@"0-巧克力纸杯蛋糕"];
        self.eatTopImage.image = [UIImage imageNamed:@"拖动提示气泡"];
   
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"1-熊"])]) {
        self.eatView.hidden = NO;
        self.foodImageView.hidden = NO;
        self.eatBtn.hidden = YES;
        self.locationView.hidden = YES;
        self.RefrigeratorView.hidden = YES;
        self.foodImageView.image = [UIImage imageNamed:@"1-蓝莓慕斯"];
        self.eatTopImage.image = [UIImage imageNamed:@"拖动提示气泡"];
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"2-熊"])]) {
        self.eatView.hidden = NO;
        self.foodImageView.hidden = NO;
        self.eatBtn.hidden = YES;
        self.locationView.hidden = YES;
        self.RefrigeratorView.hidden = YES;
        self.foodImageView.image = [UIImage imageNamed:@"2-草莓芝士"];
        self.eatTopImage.image = [UIImage imageNamed:@"拖动提示气泡"];
 
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"3-熊"])]) {
        self.eatView.hidden = NO;
        self.foodImageView.hidden = NO;
        self.eatBtn.hidden = YES;
        self.locationView.hidden = YES;
        self.RefrigeratorView.hidden = YES;
        self.foodImageView.image = [UIImage imageNamed:@"3-抹茶蛋糕卷"];
        self.eatTopImage.image = [UIImage imageNamed:@"拖动提示气泡"];
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"4-熊"])]) {
        
        
        
    }
    
}





@end
