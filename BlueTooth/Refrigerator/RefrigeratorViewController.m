//
//  RefrigeratorViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/5/1.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "RefrigeratorViewController.h"
#import "UIButton+Badge.h"
#import "FoodShowView.h"
#import "KitchenViewController.h"
@interface RefrigeratorViewController ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic) BOOL needRefresh;
@property (nonatomic, strong) UIButton *cheeseBtn;
@property (nonatomic, strong) UIButton *flourBtn;
@property (nonatomic, strong) UIButton *eggBtn;
@property (nonatomic, strong) UIButton *motchaBtn;
@property (nonatomic, strong) UIButton *strawberryBtn;
@property (nonatomic, strong) UIButton *blueberryBtn;
@property (nonatomic, strong) UIButton *chocolateBtn;
@property (nonatomic, strong) UIButton *strawberry_cakeBtn;
@property (nonatomic, strong) UIButton *motcha_rollBtn;
@property (nonatomic, strong) UIButton *blueberry_cakeBtn;
@property (nonatomic, strong) UIButton *cupcakeBtn;

@end

@implementation RefrigeratorViewController

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.backgroundColor = [UIColor whiteColor];
        [_backBtn setImage:[UIImage imageNamed:@"goLeft"] forState:UIControlStateNormal];
        [_backBtn.layer setCornerRadius:20.0f];
        [_backBtn.layer setMasksToBounds:YES];
    }
    [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    return _backBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needRefresh = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)RGB(128, 98, 156).CGColor,(__bridge id)RGB(103, 68, 137).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view.layer addSublayer:gradientLayer];
    [self createView];
    [self setValue];
    

    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)createView {
    WS(ws);
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20));
        make.top.equalTo(@(20));
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
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
    imageView.userInteractionEnabled = YES;
    imageView.tag = 200;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(330 * WidthNum, 450 * WidthNum));
        make.top.equalTo(chiTextLabel.mas_bottom).with.offset(20);
        make.centerX.equalTo(ws.view.mas_centerX);
    }];
    
    self.cheeseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cheeseBtn setFrame:CGRectMake(222 * WidthNum, 94 * WidthNum, 57 * WidthNum, 40 * WidthNum)];
    self.cheeseBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.cheeseBtn];
    self.flourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.flourBtn setFrame:CGRectMake(125 * WidthNum, 60 * WidthNum, 84 * WidthNum, 74 * WidthNum)];
    self.flourBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.flourBtn];
    self.eggBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.eggBtn setFrame:CGRectMake(60 * WidthNum, 100 * WidthNum, 53 * WidthNum, 33 * WidthNum)];
    self.eggBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.eggBtn];
    
    self.motchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.motchaBtn setFrame:CGRectMake(247 * WidthNum, 198 * WidthNum, 45 * WidthNum, 64 * WidthNum)];
    self.motchaBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.motchaBtn];
    self.strawberryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.strawberryBtn setFrame:CGRectMake(156 * WidthNum, 192 * WidthNum, 74 * WidthNum, 69 * WidthNum)];
    self.strawberryBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.strawberryBtn];
    self.blueberryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.blueberryBtn setFrame:CGRectMake(102 * WidthNum, 227 * WidthNum, 49 * WidthNum, 35 * WidthNum)];
    self.blueberryBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.blueberryBtn];
    self.chocolateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chocolateBtn setFrame:CGRectMake(37 * WidthNum, 182 * WidthNum, 53 * WidthNum, 72 * WidthNum)];
    self.chocolateBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.chocolateBtn];
    
    
    self.strawberry_cakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.strawberry_cakeBtn setFrame:CGRectMake(248 * WidthNum, 341 * WidthNum, 64 * WidthNum, 54 * WidthNum)];
    self.strawberry_cakeBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.strawberry_cakeBtn];
    self.motcha_rollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.motcha_rollBtn setFrame:CGRectMake(167 * WidthNum, 339 * WidthNum, 74 * WidthNum, 56 * WidthNum)];
    self.motcha_rollBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.motcha_rollBtn];
    self.blueberry_cakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.blueberry_cakeBtn setFrame:CGRectMake(84 * WidthNum, 343 * WidthNum, 77 * WidthNum, 52 * WidthNum)];
    self.blueberry_cakeBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.blueberry_cakeBtn];
    self.cupcakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cupcakeBtn setFrame:CGRectMake(25 * WidthNum, 339 * WidthNum, 50 * WidthNum, 56 * WidthNum)];
    self.cupcakeBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:self.cupcakeBtn];
    
    
    
    self.eggBtn.tag = EGG;
    [self.eggBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.flourBtn.tag = FLOUR;
    [self.flourBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cheeseBtn.tag = CHEESE;
    [self.cheeseBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.chocolateBtn.tag = CHOCOLATE;
    [self.chocolateBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.blueberryBtn.tag = BLUEBERRY;
    [self.blueberryBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.strawberryBtn.tag = STRAWBERRY;
    [self.strawberryBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.motchaBtn.tag = MOTCHA;
    [self.motchaBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.cupcakeBtn.tag = CUPCAKE;
    [self.cupcakeBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.blueberry_cakeBtn.tag = BLUEBERRY_CAKE;
    [self.blueberry_cakeBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.motcha_rollBtn.tag = MOTCHA_ROLL;
    [self.motcha_rollBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    self.strawberry_cakeBtn.tag = STRAWBERRY_CAKE;
    [self.strawberry_cakeBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.cheeseBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"cheese"] integerValue]];
    self.flourBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"flour"] integerValue]];
    self.eggBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"egg"] integerValue]];
    self.motchaBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"motcha"] integerValue]];
    self.strawberryBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"strawberry"] integerValue]];
    self.blueberryBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"blueberry"] integerValue]];
    self.chocolateBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"chocolate"] integerValue]];
    self.strawberry_cakeBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"strawberry_cake"] integerValue]];
    self.motcha_rollBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"motcha_roll"] integerValue]];
    self.blueberry_cakeBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"blueberry_cake"] integerValue]];
    self.cupcakeBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"cupcake"] integerValue]];
    
    [self.cheeseBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"cheese_show"] integerValue] > 0?@"cheese":@"cheese_none"] forState:UIControlStateNormal];
    [self.flourBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"flour_show"] integerValue] > 0?@"flour":@"flour_none"] forState:UIControlStateNormal];
    [self.eggBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"egg_show"] integerValue] > 0?@"egg":@"egg_none"] forState:UIControlStateNormal];
    [self.motchaBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"motcha_show"] integerValue] > 0?@"motcha":@"motcha_none"] forState:UIControlStateNormal];
    [self.strawberryBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"strawberry_show"] integerValue] > 0?@"strawberry":@"strawberry_none"] forState:UIControlStateNormal];
    [self.blueberryBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"blueberry_show"] integerValue] > 0?@"blueberry":@"blueberry_none"] forState:UIControlStateNormal];
    [self.chocolateBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"chocolate_show"] integerValue] > 0?@"chocolate":@"chocolate_none"] forState:UIControlStateNormal];
    [self.strawberry_cakeBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"strawberry_cake_show"] integerValue] > 0?@"strawberry_cake":@"strawberry_cake_none"] forState:UIControlStateNormal];
    [self.motcha_rollBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"motcha_roll_show"] integerValue] > 0?@"motcha_roll":@"motcha_roll_none"] forState:UIControlStateNormal];
    [self.blueberry_cakeBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"blueberry_cake_show"] integerValue] > 0?@"blueberry_cake":@"blueberry_cake_none"] forState:UIControlStateNormal];
    [self.cupcakeBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"cupcake_show"] integerValue] > 0?@"cupcake":@"cupcake_none"] forState:UIControlStateNormal];

    
}


- (void)backAction:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)chooseAction:(UIButton *)btn {
    WS(ws);
    FoodShowView *foodView = [[FoodShowView alloc]init];
    foodView.foodType = btn.tag;
    [foodView createView];
    [self.view addSubview:foodView];
    [foodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
    if (self.needRefresh == YES) {
        [self setValue];
    } else {
        self.needRefresh = YES;
    }
}

@end
