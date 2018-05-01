//
//  PetViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "PetViewController.h"
#import "RefrigeratorViewController.h"

@interface PetViewController ()
//背景
@property (strong, nonatomic) IBOutlet UIImageView *backImageView;
//提示文字
@property (strong, nonatomic) IBOutlet UIImageView *toastView;
//熊
@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
 
//地图
@property (strong, nonatomic) IBOutlet UIView *locationView;
//冰箱
@property (strong, nonatomic) IBOutlet UIView *RefrigeratorView;
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

    self.backImageView.userInteractionEnabled = YES;
    self.bigImageView.userInteractionEnabled = YES;
    
    self.eatView.hidden = YES;
    
    
    UITapGestureRecognizer *bigImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigImageTap)];
    [self.bigImageView addGestureRecognizer:bigImageTap];
    
    UITapGestureRecognizer *locationViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationViewTap)];
    [self.locationView addGestureRecognizer:locationViewTap];
    
    UITapGestureRecognizer *RefrigeratorViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RefrigeratorViewTap)];
    [self.RefrigeratorView addGestureRecognizer:RefrigeratorViewTap];

    
    
    
    
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
    }

}

- (void)locationViewTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)RefrigeratorViewTap {
    RefrigeratorViewController *refrigeratorVC = [[RefrigeratorViewController alloc]init];
    [self.navigationController pushViewController:refrigeratorVC animated:YES];
}

- (IBAction)leftBtnAction:(UIButton *)sender {
    
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    
}

- (IBAction)eatBtnAction:(UIButton *)sender {
    
    if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"0-熊"])]){
        NSLog(@"0-熊");
        //冰箱中是否有巧克力
//        您还未获得食物
        
        self.eatView.hidden = NO;
        self.eatBtn.hidden = YES;
        self.locationView.hidden = YES;
        self.RefrigeratorView.hidden = YES;
       
        
        
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"0-熊"])]) {
        
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"0-熊"])]) {
        
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"0-熊"])]) {
        
    } else if ([UIImagePNGRepresentation(self.bigImageView.image) isEqual:UIImagePNGRepresentation([UIImage imageNamed:@"0-熊"])]) {
        
    }
    
}



@end
