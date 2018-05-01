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

@end

@implementation PetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    //如果是原始形态
    if (self.bigImageView.image == [UIImage imageNamed:@"原始形态"]) {
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
    
}



@end
