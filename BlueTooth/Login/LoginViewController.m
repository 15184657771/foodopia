//
//  LoginViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "LoginViewController.h"
#import "Toast.h"
#import "BlueTooth-Swift.h"

@interface LoginViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *ShowView;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *weightField;
@property (strong, nonatomic) IBOutlet UITextField *drinkField;
@property (strong, nonatomic) IBOutlet UITextField *sleepField;

@property (strong, nonatomic) NSMutableDictionary *userDic;

@property (strong, nonatomic) Toast *toast;
@property (copy, nonatomic) NSString *picAddress;

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
    [self.view setBackgroundColor:RGBA(255, 255, 255, 0.4)];
    self.picAddress = @"";
    self.nameField.returnKeyType = UIReturnKeyDone;
    self.nameField.delegate = (id)self;
    self.weightField.returnKeyType = UIReturnKeyDone;
    self.weightField.delegate = (id)self;
    self.drinkField.returnKeyType = UIReturnKeyDone;
    self.drinkField.delegate = (id)self;
    self.sleepField.returnKeyType = UIReturnKeyDone;
    self.sleepField.delegate = (id)self;
    
    self.nameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"给自己想个昵称？" attributes:@{NSForegroundColorAttributeName: RGB(222, 222, 222)}];
    self.weightField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"你想成为多重？" attributes:@{NSForegroundColorAttributeName: RGB(222, 222, 222)}];
    self.drinkField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"你想每天喝多少？" attributes:@{NSForegroundColorAttributeName: RGB(222, 222, 222)}];
    self.sleepField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"你想每天睡多久？" attributes:@{NSForegroundColorAttributeName: RGB(222, 222, 222)}];

    
    self.nameField.leftViewMode = UITextFieldViewModeAlways;
    self.weightField.leftViewMode = UITextFieldViewModeAlways;
    self.drinkField.leftViewMode = UITextFieldViewModeAlways;
    self.sleepField.leftViewMode = UITextFieldViewModeAlways;

    UIView *lv1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    UIView *lv2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    UIView *lv3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    UIView *lv4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];

    self.nameField.leftView = lv1;
    self.weightField.leftView = lv2;
    self.sleepField.leftView = lv3;
    self.drinkField.leftView = lv4;

    self.headImage.userInteractionEnabled = YES;
    [self.headImage.layer setCornerRadius:49];
    [self.headImage.layer setMasksToBounds:YES];
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upPic)];
    [self.headImage addGestureRecognizer:tap];
    
}
- (IBAction)loginBtnAction:(UIButton *)sender {
    if (self.picAddress.length == 0)
    {
        //请填写照片
        [DSToast show:@"请填写照片"];
        return;
    }
    
    if (self.nameField.text.length == 0) {
        //请填写姓名
        [DSToast show:@"请填写姓名"];
        return;
    }
    
    if (self.weightField.text.length == 0) {
        //请填写
        [DSToast show:@"请填写体重目标"];
        return;
    }
    
    if (self.drinkField.text.length == 0) {
        //请填写
        [DSToast show:@"请填写喝水目标"];
        return;
    }
    
    if (self.sleepField.text.length == 0) {
        //请填写
        [DSToast show:@"请填写睡眠目标"];
         return;
    }
    
    [self.userDic setObject:self.nameField.text forKey:@"name"];
    [self.userDic setObject:self.weightField.text forKey:@"weight"];
    [self.userDic setObject:self.drinkField.text forKey:@"drink"];
    [self.userDic setObject:self.sleepField.text forKey:@"sleep"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults]setObject:self.userDic forKey:@"userDic"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"userInfo" object:nil];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

#pragma mark - 取消第一响应者
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameField resignFirstResponder];
    [self.weightField resignFirstResponder];
    [self.drinkField resignFirstResponder];
    [self.sleepField resignFirstResponder];

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGFloat offset = self.view.bounds.size.height - (self.ShowView.frame.origin.y + textField.frame.origin.y + 15 + 235 + 150);
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y =offset;
            self.view.frame = frame;
        }];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
}

- (void)upPic {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction  actionWithTitle:@"使用照相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }]];
    
    [alert addAction:[UIAlertAction  actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }]];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
    
}

#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImage:image withName:@"userPic.png"];
    [self.headImage setImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.3);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    self.picAddress = fullPath;
    
}


@end
