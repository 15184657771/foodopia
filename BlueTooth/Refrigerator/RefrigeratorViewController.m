//
//  RefrigeratorViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/5/1.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "RefrigeratorViewController.h"
#import "UIButton+Badge.h"
#import "FoodShowViewController.h"
#import "KitchenViewController.h"
@interface RefrigeratorViewController ()

@property (nonatomic, strong) UIButton *backBtn;

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)RGB(128, 98, 156).CGColor,(__bridge id)RGB(103, 68, 137).CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view.layer addSublayer:gradientLayer];
    [self createView];
    [self setValue];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(composed:) name:@"composed" object:nil];


    // Do any additional setup after loading the view.

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"composed" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)composed:(NSNotification *)sender {
    NSNumber *number = sender.object;
    KitchenViewController *kitchenViewController = [[KitchenViewController alloc]init];
    kitchenViewController.foodType = [number integerValue];
    [self.navigationController pushViewController:kitchenViewController animated:NO];
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
    
    UIButton *cheeseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cheeseBtn setFrame:CGRectMake(222 * WidthNum, 94 * WidthNum, 57 * WidthNum, 40 * WidthNum)];
    cheeseBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:cheeseBtn];
    UIButton *flourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [flourBtn setFrame:CGRectMake(125 * WidthNum, 60 * WidthNum, 84 * WidthNum, 74 * WidthNum)];
    flourBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:flourBtn];
    UIButton *eggBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [eggBtn setFrame:CGRectMake(60 * WidthNum, 100 * WidthNum, 53 * WidthNum, 33 * WidthNum)];
    eggBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:eggBtn];
    
    UIButton *motchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [motchaBtn setFrame:CGRectMake(247 * WidthNum, 198 * WidthNum, 45 * WidthNum, 64 * WidthNum)];
    motchaBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:motchaBtn];
    UIButton *strawberryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [strawberryBtn setFrame:CGRectMake(156 * WidthNum, 192 * WidthNum, 74 * WidthNum, 69 * WidthNum)];
    strawberryBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:strawberryBtn];
    UIButton *blueberryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blueberryBtn setFrame:CGRectMake(102 * WidthNum, 227 * WidthNum, 49 * WidthNum, 35 * WidthNum)];
    blueberryBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:blueberryBtn];
    UIButton *chocolateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chocolateBtn setFrame:CGRectMake(37 * WidthNum, 182 * WidthNum, 53 * WidthNum, 72 * WidthNum)];
    chocolateBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:chocolateBtn];
    
    
    UIButton *strawberry_cakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [strawberry_cakeBtn setFrame:CGRectMake(248 * WidthNum, 341 * WidthNum, 64 * WidthNum, 54 * WidthNum)];
    strawberry_cakeBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:strawberry_cakeBtn];
    UIButton *motcha_rollBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [motcha_rollBtn setFrame:CGRectMake(167 * WidthNum, 339 * WidthNum, 74 * WidthNum, 56 * WidthNum)];
    motcha_rollBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:motcha_rollBtn];
    UIButton *blueberry_cakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blueberry_cakeBtn setFrame:CGRectMake(84 * WidthNum, 343 * WidthNum, 77 * WidthNum, 52 * WidthNum)];
    blueberry_cakeBtn.shouldHideBadgeAtZero = YES;
    [imageView addSubview:blueberry_cakeBtn];
    UIButton *cupcakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cupcakeBtn setFrame:CGRectMake(25 * WidthNum, 339 * WidthNum, 50 * WidthNum, 56 * WidthNum)];
    cupcakeBtn.shouldHideBadgeAtZero = YES;
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
}

- (void)setValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UIImageView *imagView = [self.view viewWithTag:200];
    UIButton *cheeseBtn = [imagView viewWithTag:CHEESE];
    UIButton *flourBtn = [imagView viewWithTag:FLOUR];
    UIButton *eggBtn = [imagView viewWithTag:EGG];
    UIButton *motchaBtn = [imagView viewWithTag:MOTCHA];
    UIButton *strawberryBtn = [imagView viewWithTag:STRAWBERRY];
    UIButton *blueberryBtn = [imagView viewWithTag:BLUEBERRY];
    UIButton *chocolateBtn = [imagView viewWithTag:CHOCOLATE];
    UIButton *strawberry_cakeBtn = [imagView viewWithTag:STRAWBERRY_CAKE];
    UIButton *motcha_rollBtn = [imagView viewWithTag:MOTCHA_ROLL];
    UIButton *blueberry_cakeBtn = [imagView viewWithTag:BLUEBERRY_CAKE];
    UIButton *cupcakeBtn = [imagView viewWithTag:CUPCAKE];

    
    cheeseBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"cheese"] integerValue]];
    flourBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"flour"] integerValue]];
    eggBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"egg"] integerValue]];
    motchaBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"motcha"] integerValue]];
    strawberryBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"strawberry"] integerValue]];
    blueberryBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"blueberry"] integerValue]];
    chocolateBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"chocolate"] integerValue]];
    strawberry_cakeBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"strawberry_cake"] integerValue]];
    motcha_rollBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"motcha_roll"] integerValue]];
    blueberry_cakeBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"blueberry_cake"] integerValue]];
    cupcakeBtn.badgeValue = [NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"cupcake"] integerValue]];
    
    [cheeseBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"cheese"] integerValue] > 0?@"cheese":@"cheese_none"] forState:UIControlStateNormal];
    [flourBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"flour"] integerValue] > 0?@"flour":@"flour_none"] forState:UIControlStateNormal];
    [eggBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"egg"] integerValue] > 0?@"egg":@"egg_none"] forState:UIControlStateNormal];
    [motchaBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"motcha"] integerValue] > 0?@"motcha":@"motcha_none"] forState:UIControlStateNormal];
    [strawberryBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"strawberry"] integerValue] > 0?@"strawberry":@"strawberry_none"] forState:UIControlStateNormal];
    [blueberryBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"blueberry"] integerValue] > 0?@"blueberry":@"blueberry_none"] forState:UIControlStateNormal];
    [chocolateBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"chocolate"] integerValue] > 0?@"chocolate":@"chocolate_none"] forState:UIControlStateNormal];
    [strawberry_cakeBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"strawberry_cake"] integerValue] > 0?@"strawberry_cake":@"strawberry_cake_none"] forState:UIControlStateNormal];
    [motcha_rollBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"motcha_roll"] integerValue] > 0?@"motcha_roll":@"motcha_roll_none"] forState:UIControlStateNormal];
    [blueberry_cakeBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"blueberry_cake"] integerValue] > 0?@"blueberry_cake":@"blueberry_cake_none"] forState:UIControlStateNormal];
    [cupcakeBtn setImage:[UIImage imageNamed:[[defaults objectForKey:@"cupcake"] integerValue] > 0?@"cupcake":@"cupcake_none"] forState:UIControlStateNormal];

    
}


- (void)backAction:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)chooseAction:(UIButton *)btn {
    FoodShowViewController *foodShowViewController = [[FoodShowViewController alloc]init];
    foodShowViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    foodShowViewController.foodType = btn.tag;
    self.definesPresentationContext = YES;
    [self presentViewController:foodShowViewController animated:NO completion:nil];

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
