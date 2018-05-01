//
//  LoginViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "LoginViewController.h"
#import "Toast.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UITextField *nameField;

@property (strong, nonatomic) IBOutlet UITextField *weightField;


@property (strong, nonatomic) IBOutlet UITextField *drinkField;
@property (strong, nonatomic) IBOutlet UITextField *sleepField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)loginBtnAction:(UIButton *)sender {
    
//    if (self.nameField.text.length == 0) {
//        //请填写姓名
//    }
//    
//    if (self.weightField.text.length == 0) {
//        //请填写
//    }
//    
//    if (self.drinkField.text.length == 0) {
//        //请填写
//    }
//    
//    if (self.sleepField.text.length == 0) {
//        //请填写
//    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}



@end
