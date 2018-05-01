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

@property (strong, nonatomic) NSMutableDictionary *userDic;

@end

@implementation LoginViewController

- (NSMutableDictionary *)userDic {
    if (!_userDic) {
        _userDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return _userDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)loginBtnAction:(UIButton *)sender {
    
    if (self.nameField.text.length == 0) {
        //请填写姓名
        return;
    }
    
    if (self.weightField.text.length == 0) {
        //请填写
         return;
    }
    
    if (self.drinkField.text.length == 0) {
        //请填写
         return;
    }
    
    if (self.sleepField.text.length == 0) {
        //请填写
         return;
    }
    
    [self.userDic setObject:self.nameField.text forKey:@"name"];
    [self.userDic setObject:self.weightField.text forKey:@"weight"];
    [self.userDic setObject:self.drinkField.text forKey:@"drink"];
    [self.userDic setObject:self.sleepField.text forKey:@"sleep"];
    [self.userDic setObject:self.headImage.image forKey:@"headImage"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults]setObject:self.userDic forKey:@"userDic"];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}



@end
