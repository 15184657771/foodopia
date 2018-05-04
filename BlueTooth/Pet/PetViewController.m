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
#import "BlueTooth-Swift.h"
#import "NoFoodViewController.h"

@interface PetViewController ()<NoFoodViewDelegate>
//背景
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;
@property (strong, nonatomic) IBOutlet UIButton *leftTopBtn;

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


@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIImageView *finishFoodImage;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *toastViewTop;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *eatBtnBottom;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bigImageBottom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *finishFoodTop;

@end

@implementation PetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.toastViewTop.constant = 205 * HeightNum;
    self.eatBtnBottom.constant = 45 * HeightNum;
    self.bigImageBottom.constant = 50 * HeightNum;
    self.finishFoodTop.constant = 370 * HeightNum;
    [self setUpUI];

    UITapGestureRecognizer *bigImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigImageTap)];
    [self.bigImageView addGestureRecognizer:bigImageTap];
    
    UITapGestureRecognizer *locationViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationViewTap)];
    [self.locationView addGestureRecognizer:locationViewTap];
    
    UITapGestureRecognizer *RefrigeratorViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RefrigeratorViewTap)];
    [self.RefrigeratorView addGestureRecognizer:RefrigeratorViewTap];

    UISwipeGestureRecognizer *eatViewTap = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(eatViewTap:)];
    [eatViewTap setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.imageView addGestureRecognizer:eatViewTap];
    
    
   
}

- (void)gifPlay {
    self.imageView.animationImages = @[
                                       [UIImage imageNamed:@"合成 1_00000"],
                                       [UIImage imageNamed:@"合成 1_00001"],
                                       [UIImage imageNamed:@"合成 1_00002"],
                                       [UIImage imageNamed:@"合成 1_00003"],
                                       [UIImage imageNamed:@"合成 1_00004"],
                                       [UIImage imageNamed:@"合成 1_00005"],
                                       [UIImage imageNamed:@"合成 1_00006"],
                                       [UIImage imageNamed:@"合成 1_00007"],
                                       [UIImage imageNamed:@"合成 1_00008"],
                                       [UIImage imageNamed:@"合成 1_00009"],
                                       [UIImage imageNamed:@"合成 1_00010"],
                                       [UIImage imageNamed:@"合成 1_00011"],
                                       [UIImage imageNamed:@"合成 1_00012"],
                                       [UIImage imageNamed:@"合成 1_00013"],
                                       [UIImage imageNamed:@"合成 1_00014"],
                                       [UIImage imageNamed:@"合成 1_00015"],
                                       [UIImage imageNamed:@"合成 1_00016"],
                                       [UIImage imageNamed:@"合成 1_00017"],
                                       [UIImage imageNamed:@"合成 1_00018"],
                                       [UIImage imageNamed:@"合成 1_00019"],
                                       [UIImage imageNamed:@"合成 1_00020"],
                                       [UIImage imageNamed:@"合成 1_00021"],
                                       [UIImage imageNamed:@"合成 1_00022"],
                                       [UIImage imageNamed:@"合成 1_00023"],
                                       [UIImage imageNamed:@"合成 1_00024"],
                                       ];
    
    self.imageView.animationDuration = 2.0f;
    self.imageView.animationRepeatCount = 1;
    [self.view addSubview: self.imageView];
    [self.imageView startAnimating];
    
    dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
        [self.imageView stopAnimating];
        
        
    });
}
- (void)gifPlayTwo {
    self.imageView.animationImages = @[
                                       [UIImage imageNamed:@"喂养02_00000"],
                                       [UIImage imageNamed:@"喂养02_00001"],
                                       [UIImage imageNamed:@"喂养02_00002"],
                                       [UIImage imageNamed:@"喂养02_00003"],
                                       [UIImage imageNamed:@"喂养02_00004"],
                                       [UIImage imageNamed:@"喂养02_00005"],
                                       [UIImage imageNamed:@"喂养02_00006"],
                                       [UIImage imageNamed:@"喂养02_00007"],
                                       [UIImage imageNamed:@"喂养02_00008"],
                                       [UIImage imageNamed:@"喂养02_00009"],
                                       [UIImage imageNamed:@"喂养02_00010"],
                                       [UIImage imageNamed:@"喂养02_00011"],
                                       [UIImage imageNamed:@"喂养02_00012"],
                                       [UIImage imageNamed:@"喂养02_00013"],
                                       [UIImage imageNamed:@"喂养02_00014"],
                                       [UIImage imageNamed:@"喂养02_00015"],
                                       [UIImage imageNamed:@"喂养02_00016"],
                                       [UIImage imageNamed:@"喂养02_00017"],
                                       [UIImage imageNamed:@"喂养02_00018"],
                                       [UIImage imageNamed:@"喂养02_00019"],
                                       [UIImage imageNamed:@"喂养02_00020"],
                                       [UIImage imageNamed:@"喂养02_00021"],
                                       [UIImage imageNamed:@"喂养02_00022"],
                                       [UIImage imageNamed:@"喂养02_00023"],
                                       [UIImage imageNamed:@"喂养02_00024"],
                                       ];
    
    self.imageView.animationDuration = 2.0f;
    self.imageView.animationRepeatCount = 1;
    [self.view addSubview: self.imageView];
    [self.imageView startAnimating];
    
    dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
        [self.imageView stopAnimating];
        
        
    });
}
- (void)gifPlayThree {
    self.imageView.animationImages = @[
                                       [UIImage imageNamed:@"喂养03_00000"],
                                       [UIImage imageNamed:@"喂养03_00001"],
                                       [UIImage imageNamed:@"喂养03_00002"],
                                       [UIImage imageNamed:@"喂养03_00003"],
                                       [UIImage imageNamed:@"喂养03_00004"],
                                       [UIImage imageNamed:@"喂养03_00005"],
                                       [UIImage imageNamed:@"喂养03_00006"],
                                       [UIImage imageNamed:@"喂养03_00007"],
                                       [UIImage imageNamed:@"喂养03_00008"],
                                       [UIImage imageNamed:@"喂养03_00009"],
                                       [UIImage imageNamed:@"喂养03_00010"],
                                       [UIImage imageNamed:@"喂养03_00011"],
                                       [UIImage imageNamed:@"喂养03_00012"],
                                       [UIImage imageNamed:@"喂养03_00013"],
                                       [UIImage imageNamed:@"喂养03_00014"],
                                       [UIImage imageNamed:@"喂养03_00015"],
                                       [UIImage imageNamed:@"喂养03_00016"],
                                       [UIImage imageNamed:@"喂养03_00017"],
                                       [UIImage imageNamed:@"喂养03_00018"],
                                       [UIImage imageNamed:@"喂养03_00019"],
                                       [UIImage imageNamed:@"喂养03_00020"],
                                       [UIImage imageNamed:@"喂养03_00021"],
                                       [UIImage imageNamed:@"喂养03_00022"],
                                       [UIImage imageNamed:@"喂养03_00023"],
                                       [UIImage imageNamed:@"喂养03_00024"],
                                       ];
    
    self.imageView.animationDuration = 2.0f;
    self.imageView.animationRepeatCount = 1;
    [self.view addSubview: self.imageView];
    [self.imageView startAnimating];
    
    dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
        [self.imageView stopAnimating];
        
        
    });
}
- (void)gifPlayFour {
    self.imageView.animationImages = @[
                                       [UIImage imageNamed:@"喂养04_00000"],
                                       [UIImage imageNamed:@"喂养04_00001"],
                                       [UIImage imageNamed:@"喂养04_00002"],
                                       [UIImage imageNamed:@"喂养04_00003"],
                                       [UIImage imageNamed:@"喂养04_00004"],
                                       [UIImage imageNamed:@"喂养04_00005"],
                                       [UIImage imageNamed:@"喂养04_00006"],
                                       [UIImage imageNamed:@"喂养04_00007"],
                                       [UIImage imageNamed:@"喂养04_00008"],
                                       [UIImage imageNamed:@"喂养04_00009"],
                                       [UIImage imageNamed:@"喂养04_00010"],
                                       [UIImage imageNamed:@"喂养04_00011"],
                                       [UIImage imageNamed:@"喂养04_00012"],
                                       [UIImage imageNamed:@"喂养04_00013"],
                                       [UIImage imageNamed:@"喂养04_00014"],
                                       [UIImage imageNamed:@"喂养04_00015"],
                                       [UIImage imageNamed:@"喂养04_00016"],
                                       [UIImage imageNamed:@"喂养04_00017"],
                                       [UIImage imageNamed:@"喂养04_00018"],
                                       [UIImage imageNamed:@"喂养04_00019"],
                                       [UIImage imageNamed:@"喂养04_00020"],
                                       [UIImage imageNamed:@"喂养04_00021"],
                                       [UIImage imageNamed:@"喂养04_00022"],
                                       [UIImage imageNamed:@"喂养04_00023"],
                                       [UIImage imageNamed:@"喂养04_00024"],
                                       ];
    
    self.imageView.animationDuration = 2.0f;
    self.imageView.animationRepeatCount = 1;
    [self.view addSubview: self.imageView];
    [self.imageView startAnimating];
    
    dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
        [self.imageView stopAnimating];
        
        
    });
}


- (void)setUpUI {
    self.backImageView.userInteractionEnabled = YES;
    self.bigImageView.userInteractionEnabled = YES;
    self.imageView.userInteractionEnabled = YES;
    
    self.energyView.hidden = YES;
    self.hungerImageView.hidden = YES;
    self.imageView.hidden = YES;
    self.finishFoodImage.hidden = YES;
    self.eatBtn.hidden = NO;
    self.locationView.hidden = NO;
    self.RefrigeratorView.hidden = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"]) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"-1"]) {  //原始形态
            self.backImageView.image = [UIImage imageNamed:@"0-背景"];
            self.bigImageView.image = [UIImage imageNamed:@"原始形态"];
            self.toastView.hidden = NO;
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"0"]) {  //
            self.backImageView.image = [UIImage imageNamed:@"0-背景"];
            self.bigImageView.image = [UIImage imageNamed:@"0-熊"];
            self.toastView.hidden = YES;
            self.hungerImageView.hidden = NO;
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"1"]) {  //喂完巧克力
            self.bigImageView.image = [UIImage imageNamed:@"1-熊"];
            self.backImageView.image = [UIImage imageNamed:@"1-背景"];
            self.toastView.hidden = YES;
            self.hungerImageView.hidden = NO;
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"2"]) { //喂完蓝莓蛋糕
            self.bigImageView.image = [UIImage imageNamed:@"2-熊"];
            self.backImageView.image = [UIImage imageNamed:@"2-背景"];
            self.toastView.hidden = YES;
            self.hungerImageView.hidden = NO;
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"3"]) { //喂完草莓蛋糕
            self.bigImageView.image = [UIImage imageNamed:@"3-熊"];
            self.backImageView.image = [UIImage imageNamed:@"3-背景"];
            self.toastView.hidden = YES;
            self.hungerImageView.hidden = NO;
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"3"]) { //喂完抹茶卷
            self.bigImageView.image = [UIImage imageNamed:@"4-熊"];
            self.backImageView.image = [UIImage imageNamed:@"4-背景"];
            self.toastView.hidden = YES;
            self.hungerImageView.hidden = NO;
        }
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"-1" forKey:@"petprogress"];
        self.backImageView.image = [UIImage imageNamed:@"0-背景"];
        self.bigImageView.image = [UIImage imageNamed:@"原始形态"];
        self.toastView.hidden = NO;
    }
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)bigImageTap {
//    //如果是原始形态
    if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"原始形态"])]){
        NSLog(@"原始形态");
        self.toastView.hidden = YES;
        self.bigImageView.image = [UIImage imageNamed:@"0-熊"];
        self.hungerImageView.hidden = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"petprogress"];
    }
}

- (void)locationViewTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RefrigeratorViewTap {
    RefrigeratorViewController *refrigeratorVC = [[RefrigeratorViewController alloc]init];
    [self.navigationController pushViewController:refrigeratorVC animated:YES];
}

- (void)eatViewTap:(UISwipeGestureRecognizer *)recognizer {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger percentNum = [[user objectForKey:@"percentNum"] integerValue];
    
    NSInteger chocolate = [[user objectForKey:@"chocolate"] integerValue];
    NSInteger blueberry_cake = [[user objectForKey:@"blueberry_cake"] integerValue];
    NSInteger strawberry_cake = [[user objectForKey:@"strawberry_cake"] integerValue];
    NSInteger motcha_roll = [[user objectForKey:@"motcha_roll"] integerValue];
    
    
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0/*延迟执行时间*/ * NSEC_PER_SEC));
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"0"]) {  //
            self.toastView.hidden = YES;
            [user setObject:[NSString stringWithFormat:@"%ld",percentNum + 500] forKey:@"percentNum"];
            [user setObject:@"1" forKey:@"petprogress"];
            [user setObject:[NSString stringWithFormat:@"%ld",chocolate - 1] forKey:@"chocolate"];
            [self gifPlay];
        
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                self.energyView.hidden = NO;
                self.hungerImageView.hidden = YES;
                self.finishFoodImage.hidden = NO;
                self.finishFoodImage.image = [UIImage imageNamed:@"0-旋转飞起"];
                self.imageView.image = [UIImage imageNamed:@"合成 1_00024"];
            });
            dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
                self.backImageView.image = [UIImage imageNamed:@"1-背景"];
                self.bigImageView.image = [UIImage imageNamed:@"1-熊"];
                self.imageView.hidden = YES;
                self.energyView.hidden = YES;
                self.hungerImageView.hidden = NO;
                self.eatBtn.hidden = NO;
                self.locationView.hidden = NO;
                self.RefrigeratorView.hidden = NO;
                self.finishFoodImage.hidden = YES;
            });
            
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"1"]) {  //喂完巧克力
            self.toastView.hidden = YES;
            [user setObject:[NSString stringWithFormat:@"%ld",percentNum + 500] forKey:@"percentNum"];
            [user setObject:@"2" forKey:@"petprogress"];
            [user setObject:[NSString stringWithFormat:@"%ld",blueberry_cake - 1] forKey:@"blueberry_cake"];
            [self gifPlayTwo];
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                self.energyView.hidden = NO;
                self.hungerImageView.hidden = YES;
                self.finishFoodImage.hidden = NO;
                self.finishFoodImage.image = [UIImage imageNamed:@"1-旋转飞起"];
                self.imageView.image = [UIImage imageNamed:@"喂养02_00024"];
            });
            dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
                self.backImageView.image = [UIImage imageNamed:@"2-背景"];
                self.bigImageView.image = [UIImage imageNamed:@"2-熊"];
                self.imageView.hidden = YES;
                self.energyView.hidden = YES;
                self.hungerImageView.hidden = NO;
                self.eatBtn.hidden = NO;
                self.locationView.hidden = NO;
                self.RefrigeratorView.hidden = NO;
                self.finishFoodImage.hidden = YES;
            });
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"2"]) { //喂完蓝莓蛋糕
            self.toastView.hidden = YES;
            [user setObject:[NSString stringWithFormat:@"%ld",percentNum + 500] forKey:@"percentNum"];
            [user setObject:@"3" forKey:@"petprogress"];
            [user setObject:[NSString stringWithFormat:@"%ld",strawberry_cake - 1] forKey:@"strawberry_cake"];
            [self gifPlayThree];
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                self.energyView.hidden = NO;
                self.hungerImageView.hidden = YES;
                self.finishFoodImage.hidden = NO;
                self.finishFoodImage.image = [UIImage imageNamed:@"2-旋转飞起"];
                self.imageView.image = [UIImage imageNamed:@"喂养03_00024"];
            });
            dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
                self.backImageView.image = [UIImage imageNamed:@"3-背景"];
                self.bigImageView.image = [UIImage imageNamed:@"3-熊"];
                self.imageView.hidden = YES;
                self.energyView.hidden = YES;
                self.hungerImageView.hidden = NO;
                self.eatBtn.hidden = NO;
                self.locationView.hidden = NO;
                self.RefrigeratorView.hidden = NO;
                self.finishFoodImage.hidden = YES;
            });
        } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"petprogress"] isEqualToString:@"3"]) { //喂完草莓蛋糕
            self.toastView.hidden = YES;
            [user setObject:[NSString stringWithFormat:@"%ld",percentNum + 500] forKey:@"percentNum"];
            [user setObject:@"4" forKey:@"petprogress"];
            [user setObject:[NSString stringWithFormat:@"%ld",motcha_roll - 1] forKey:@"motcha_roll"];
            [self gifPlayFour];
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                self.energyView.hidden = NO;
                self.hungerImageView.hidden = YES;
                self.finishFoodImage.hidden = NO;
                self.finishFoodImage.image = [UIImage imageNamed:@"3-旋转飞起"];
                self.imageView.image = [UIImage imageNamed:@"喂养04_00024"];
            });
            dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
                self.backImageView.image = [UIImage imageNamed:@"4-背景"];
                self.bigImageView.image = [UIImage imageNamed:@"4-熊"];
                self.imageView.hidden = YES;
                self.energyView.hidden = YES;
                self.hungerImageView.hidden = NO;
                self.hungerImageView.image = [UIImage imageNamed:@"完成提示气泡"];
                self.eatBtn.hidden = NO;
                self.locationView.hidden = NO;
                self.RefrigeratorView.hidden = NO;
                self.finishFoodImage.hidden = YES;
            });
        }

    }
}


- (IBAction)leftBtnAction:(UIButton *)sender {
     if ([UIImagePNGRepresentation(sender.currentBackgroundImage) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"返回icon"])]){
         [self.navigationController popViewControllerAnimated:YES];
     } else {
         [self XYSideOpenVC];
     }
}


- (IBAction)eatBtnAction:(UIButton *)sender {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger chocolate = [[user objectForKey:@"chocolate"] integerValue];
    NSInteger blueberry_cake = [[user objectForKey:@"blueberry_cake"] integerValue];
    NSInteger strawberry_cake = [[user objectForKey:@"strawberry_cake"] integerValue];
    NSInteger motcha_roll = [[user objectForKey:@"motcha_roll"] integerValue];
    
    
    if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"0-熊"])]){
        NSLog(@"0-熊");
        //冰箱中是否有巧克力
        if (chocolate > 0) {
            self.eatBtn.hidden = YES;
            self.locationView.hidden = YES;
            self.RefrigeratorView.hidden = YES;
            self.imageView.hidden = NO;
            self.imageView.image = [UIImage imageNamed:@"合成 1_00001"];
        } else {
            [self setUpNoFoodView:1];
        }
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"1-熊"])]) {
        if (blueberry_cake > 0) {
        
            self.eatBtn.hidden = YES;
            self.locationView.hidden = YES;
            self.RefrigeratorView.hidden = YES;
            self.imageView.hidden = NO;
            self.hungerImageView.hidden = YES;
            self.imageView.image = [UIImage imageNamed:@"喂养02_00001"];
        } else {
            [self setUpNoFoodView:2];
        }
        
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"2-熊"])]) {
        if (strawberry_cake > 0 ) {
        
            self.eatBtn.hidden = YES;
            self.locationView.hidden = YES;
            self.RefrigeratorView.hidden = YES;
            self.imageView.hidden = NO;
            self.hungerImageView.hidden = YES;
            self.imageView.image = [UIImage imageNamed:@"喂养03_00001"];
        } else {
            [self setUpNoFoodView:3];
        }
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"3-熊"])]) {
        if (motcha_roll > 0) {
        
            self.eatBtn.hidden = YES;
            self.locationView.hidden = YES;
            self.RefrigeratorView.hidden = YES;
            self.imageView.hidden = NO;
            self.hungerImageView.hidden = YES;
            self.imageView.image = [UIImage imageNamed:@"喂养04_00001"];
        } else {
            [self setUpNoFoodView:4];
        }
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"4-熊"])]) {
        
        
        
    }
    
}

- (void)setUpNoFoodView:(NSInteger)count {
    NSLog(@"没有食物");
    NoFoodViewController *noFoodVC = [[NoFoodViewController alloc]init];
    noFoodVC.delegate = self;
    if (count == 1) {
        [noFoodVC setUpUI:Chocolates];
    } else if (count == 2) {
        [noFoodVC setUpUI:Blueberry_Cake];
    } else if (count == 3) {
        [noFoodVC setUpUI:Strawberry_Cake];
    } else if (count == 4) {
        [noFoodVC setUpUI:Motcha_Roll];
    }
    
    noFoodVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.definesPresentationContext = YES;
    [self presentViewController:noFoodVC animated:NO completion:^ {
        noFoodVC.view.superview.backgroundColor = [UIColor clearColor];
    }];
}

- (void)NoFoodViewDelegate {
    RefrigeratorViewController *refrigeratorVC = [[RefrigeratorViewController alloc]init];
    [self.navigationController pushViewController:refrigeratorVC animated:YES];
}


@end
