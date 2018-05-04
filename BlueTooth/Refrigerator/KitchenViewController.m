//
//  KitchenViewController.m
//  BlueTooth
//
//  Created by Chen on 2018/5/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "KitchenViewController.h"

@interface KitchenViewController ()
@property (nonatomic, strong) UIButton *composedBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *foodImageView;
@end

@implementation KitchenViewController

- (UIButton *)composedBtn {
    if (!_composedBtn) {
        _composedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_composedBtn setTitle:@"确认合成" forState:UIControlStateNormal];
        [_composedBtn setBackgroundColor:RGB(191, 140, 219)];
        [_composedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_composedBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_composedBtn.layer setMasksToBounds:YES];
        [_composedBtn.layer setCornerRadius:20];
        [_composedBtn addTarget:self action:@selector(goComposed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _composedBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    WS(ws);
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"厨房背景"]];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(ws.view);
    }];
    
    self.foodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(47.5 * WidthNum, 95 * WidthNum, 280 * WidthNum, 280 * WidthNum)];
    [self.view addSubview:self.foodImageView];

    [self.view addSubview:self.composedBtn];
    [self.composedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view.mas_centerX);
        make.top.equalTo(self.foodImageView.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(180, 40));
    }];
    switch (self.foodType) {
        case CUPCAKE:
            [self.foodImageView setImage:[UIImage imageNamed:@"巧克力纸杯-合成提示"]];
            break;
        case BLUEBERRY_CAKE:
            [self.foodImageView setImage:[UIImage imageNamed:@"蓝莓慕斯-合成提示"]];
            break;
        case MOTCHA_ROLL:
            [self.foodImageView setImage:[UIImage imageNamed:@"抹茶蛋糕卷-合成提示"]];
            break;
        case STRAWBERRY_CAKE:
            [self.foodImageView setImage:[UIImage imageNamed:@"草莓芝士-合成提示"]];
            break;
            
        default:
            break;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goComposed:(UIButton *)btn {
    self.foodImageView.hidden = YES;
    self.composedBtn.hidden = YES;
    switch (self.foodType) {
        case CUPCAKE:
            [self.imageView setImage:[UIImage imageNamed:@"合成成功-巧克力纸杯蛋糕"]];
            break;
        case BLUEBERRY_CAKE:
            [self.imageView setImage:[UIImage imageNamed:@"合成成功-蓝莓慕斯"]];
            break;
        case MOTCHA_ROLL:
            [self.imageView setImage:[UIImage imageNamed:@"合成成功-抹茶蛋糕卷"]];
            break;
        case STRAWBERRY_CAKE:
            [self.imageView setImage:[UIImage imageNamed:@"合成成功-草莓芝士蛋糕"]];
            break;
            
        default:
            break;
    }
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackaction)]];
}
- (void)tapBackaction {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (self.foodType) {
        case CUPCAKE:
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"cupcake"] intValue] + 1] forKey:@"cupcake"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"flour"] intValue] - 1] forKey:@"flour"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"egg"] intValue] - 1] forKey:@"egg"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"chocolate"] intValue] - 1] forKey:@"chocolate"];
            break;
        case BLUEBERRY_CAKE:
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"blueberry_cake"] intValue] + 1] forKey:@"blueberry_cake"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"cheese"] intValue] - 1] forKey:@"cheese"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"egg"] intValue] - 1] forKey:@"egg"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"blueberry"] intValue] - 1] forKey:@"blueberry"];
            break;
        case MOTCHA_ROLL:
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"motcha_roll"] intValue] + 1] forKey:@"motcha_roll"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"flour"] intValue] - 1] forKey:@"flour"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"egg"] intValue] - 1] forKey:@"egg"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"motcha"] intValue] - 1] forKey:@"motcha"];
            break;
        case STRAWBERRY_CAKE:
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"strawberry_cake"] intValue] + 1] forKey:@"strawberry_cake"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"flour"] intValue] - 1] forKey:@"flour"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"cheese"] intValue] - 1] forKey:@"cheese"];
            [defaults setValue:[NSNumber numberWithInt:[[defaults objectForKey:@"strawberry"] intValue] - 1] forKey:@"strawberry"];
            break;
            
        default:
            break;
    }
    [defaults synchronize];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
