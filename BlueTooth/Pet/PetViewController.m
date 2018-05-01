//
//  PetViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "PetViewController.h"

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


}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}
- (IBAction)leftBtnAction:(UIButton *)sender {
    
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    
}

- (IBAction)eatBtnAction:(UIButton *)sender {
    
}



@end
