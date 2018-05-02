//
//  RefrigeratorViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/5/1.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "RefrigeratorViewController.h"
#import "UIButton+Badge.h"

@interface RefrigeratorViewController ()

@end

@implementation RefrigeratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)RGB(128, 98, 156).CGColor,(__bridge id)RGB(103, 68, 137).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view.layer addSublayer:gradientLayer];
    
    
    WS(ws);
    UILabel *engTextLabel = [[UILabel alloc]init];
    engTextLabel.textColor = [UIColor whiteColor];
    engTextLabel.font = [UIFont boldSystemFontOfSize:22];
    engTextLabel.textAlignment = NSTextAlignmentRight;
    engTextLabel.text = @"Refrigerator";
    [self.view addSubview:engTextLabel];
    [engTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(ws.view.mas_safeAreaLayoutGuideTop).with.offset(26);
        } else {
            make.top.equalTo(@26);
        }
        make.height.equalTo(@30);
    }];
    UILabel *chiTextLabel = [[UILabel alloc]init];
    chiTextLabel.textColor = [UIColor whiteColor];
    chiTextLabel.font = [UIFont boldSystemFontOfSize:20];
    chiTextLabel.textAlignment = NSTextAlignmentRight;
    chiTextLabel.text = @"储物冰箱";
    [self.view addSubview:chiTextLabel];
    [chiTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.top.equalTo(engTextLabel.mas_bottom).with.offset(5);
    }];

    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fridge"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(330 * WidthNum, 450 * WidthNum));
        make.top.equalTo(chiTextLabel.mas_bottom).with.offset(20);
        make.centerX.equalTo(ws.view.mas_centerX);
    }];
    
    UIButton *cheeseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cheeseBtn setFrame:CGRectMake(222 * WidthNum, 94 * WidthNum, 57 * WidthNum, 40 * WidthNum)];
    [cheeseBtn setImage:[UIImage imageNamed:@"cheese"] forState:UIControlStateNormal];
    cheeseBtn.shouldHideBadgeAtZero = YES;
    cheeseBtn.badgeValue = @"1";
    [imageView addSubview:cheeseBtn];
    UIButton *flourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [flourBtn setFrame:CGRectMake(125 * WidthNum, 60 * WidthNum, 84 * WidthNum, 74 * WidthNum)];
    [flourBtn setImage:[UIImage imageNamed:@"flour"] forState:UIControlStateNormal];
    flourBtn.shouldHideBadgeAtZero = YES;
    flourBtn.badgeValue = @"1";
    [imageView addSubview:flourBtn];
    UIButton *eggBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [eggBtn setFrame:CGRectMake(60 * WidthNum, 100 * WidthNum, 53 * WidthNum, 33 * WidthNum)];
    [eggBtn setImage:[UIImage imageNamed:@"egg"] forState:UIControlStateNormal];
    eggBtn.shouldHideBadgeAtZero = YES;
    eggBtn.badgeValue = @"1";
    [imageView addSubview:eggBtn];
    
    UIButton *motchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [motchaBtn setFrame:CGRectMake(247 * WidthNum, 198 * WidthNum, 45 * WidthNum, 64 * WidthNum)];
    [motchaBtn setImage:[UIImage imageNamed:@"motcha"] forState:UIControlStateNormal];
    motchaBtn.shouldHideBadgeAtZero = YES;
    motchaBtn.badgeValue = @"1";
    [imageView addSubview:motchaBtn];
    UIButton *strawberryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [strawberryBtn setFrame:CGRectMake(156 * WidthNum, 192 * WidthNum, 74 * WidthNum, 69 * WidthNum)];
    [strawberryBtn setImage:[UIImage imageNamed:@"strawberry"] forState:UIControlStateNormal];
    strawberryBtn.shouldHideBadgeAtZero = YES;
    strawberryBtn.badgeValue = @"1";
    [imageView addSubview:strawberryBtn];
    UIButton *blueberryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blueberryBtn setFrame:CGRectMake(102 * WidthNum, 227 * WidthNum, 49 * WidthNum, 35 * WidthNum)];
    [blueberryBtn setImage:[UIImage imageNamed:@"blueberry"] forState:UIControlStateNormal];
    blueberryBtn.shouldHideBadgeAtZero = YES;
    blueberryBtn.badgeValue = @"1";
    [imageView addSubview:blueberryBtn];
    UIButton *chocolateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chocolateBtn setFrame:CGRectMake(37 * WidthNum, 182 * WidthNum, 53 * WidthNum, 72 * WidthNum)];
    [chocolateBtn setImage:[UIImage imageNamed:@"chocolate"] forState:UIControlStateNormal];
    chocolateBtn.shouldHideBadgeAtZero = YES;
    chocolateBtn.badgeValue = @"1";
    [imageView addSubview:chocolateBtn];
    
    
    UIButton *strawberry_cakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [strawberry_cakeBtn setFrame:CGRectMake(248 * WidthNum, 341 * WidthNum, 64 * WidthNum, 54 * WidthNum)];
    [strawberry_cakeBtn setImage:[UIImage imageNamed:@"strawberry_cake"] forState:UIControlStateNormal];
    strawberry_cakeBtn.shouldHideBadgeAtZero = YES;
    strawberry_cakeBtn.badgeValue = @"1";
    [imageView addSubview:strawberry_cakeBtn];
    UIButton *motcha_rollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [motcha_rollBtn setFrame:CGRectMake(167 * WidthNum, 339 * WidthNum, 74 * WidthNum, 56 * WidthNum)];
    [motcha_rollBtn setImage:[UIImage imageNamed:@"motcha_roll"] forState:UIControlStateNormal];
    motcha_rollBtn.shouldHideBadgeAtZero = YES;
    motcha_rollBtn.badgeValue = @"1";
    [imageView addSubview:motcha_rollBtn];
    UIButton *blueberry_cakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blueberry_cakeBtn setFrame:CGRectMake(84 * WidthNum, 343 * WidthNum, 77 * WidthNum, 52 * WidthNum)];
    [blueberry_cakeBtn setImage:[UIImage imageNamed:@"blueberry_cake"] forState:UIControlStateNormal];
    blueberry_cakeBtn.shouldHideBadgeAtZero = YES;
    blueberry_cakeBtn.badgeValue = @"1";
    [imageView addSubview:blueberry_cakeBtn];
    UIButton *cupcakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cupcakeBtn setFrame:CGRectMake(25 * WidthNum, 339 * WidthNum, 50 * WidthNum, 56 * WidthNum)];
    [cupcakeBtn setImage:[UIImage imageNamed:@"cupcake"] forState:UIControlStateNormal];
    cupcakeBtn.shouldHideBadgeAtZero = YES;
    cupcakeBtn.badgeValue = @"1";
    [imageView addSubview:cupcakeBtn];
    
    eggBtn.tag = EGG;
    [eggBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    flourBtn.tag = FLOUR;
    [flourBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    cheeseBtn.tag = CHEESE;
    [cheeseBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    chocolateBtn.tag = CHOCOLATE;
    [chocolateBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    blueberryBtn.tag = BLUEBERRY;
    [blueberryBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    strawberryBtn.tag = STRAWBERRY;
    [strawberryBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    motchaBtn.tag = MOTCHA;
    [motchaBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    cupcakeBtn.tag = CUPCAKE;
    [cupcakeBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    blueberry_cakeBtn.tag = BLUEBERRY_CAKE;
    [blueberry_cakeBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    motcha_rollBtn.tag = MOTCHA_ROLL;
    [motcha_rollBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    strawberry_cakeBtn.tag = STRAWBERRY_CAKE;
    [strawberry_cakeBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
=======
    self.view.backgroundColor = [UIColor whiteColor];
>>>>>>> master
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)chooseAction:(UIButton *)btn {
    switch (btn.tag) {
        case EGG:
            break;
        case FLOUR:
            break;
        case CHEESE:
            break;
        case CHOCOLATE:
            break;
        case BLUEBERRY:
            break;
        case STRAWBERRY:
            break;
        case MOTCHA:
            break;
        case CUPCAKE:
            break;
        case BLUEBERRY_CAKE:
            break;
        case MOTCHA_ROLL:
            break;
        case STRAWBERRY_CAKE:
            break;
            
        default:
            break;
    }
}

@end
