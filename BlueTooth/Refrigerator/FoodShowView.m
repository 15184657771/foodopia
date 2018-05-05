//
//  FoodShowViewController.m
//  BlueTooth
//
//  Created by Chen on 2018/5/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "FoodShowView.h"
#import "KitchenViewController.h"
#import "PetViewController.h"
@interface FoodShowView ()

@property (nonatomic, strong) UIButton *composedBtn;
@property (nonatomic, strong) UIView *composedView;
@property (nonatomic, strong) UILabel *numberFirstLabel;
@property (nonatomic, strong) UILabel *numberSecondLabel;
@property (nonatomic, strong) UILabel *numberThirdLabel;
@property (nonatomic) BOOL petEatType;
@end

@implementation FoodShowView
- (UILabel *)numberFirstLabel {
    if (!_numberFirstLabel) {
        _numberFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(90 * WidthNum, 396 * WidthNum, 16 * WidthNum, 16 * WidthNum)];
        [_numberFirstLabel setBackgroundColor:RGB(237, 60, 60)];
        [_numberFirstLabel setTextColor:[UIColor whiteColor]];
        [_numberFirstLabel setTextAlignment:NSTextAlignmentCenter];
        [_numberFirstLabel setFont:[UIFont systemFontOfSize:12]];
        [_numberFirstLabel.layer setMasksToBounds:YES];
        [_numberFirstLabel.layer setCornerRadius:8 * WidthNum];
        _numberFirstLabel.hidden = YES;
    }
    return _numberFirstLabel;
}
- (UILabel *)numberSecondLabel {
    if (!_numberSecondLabel) {
        _numberSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(172 * WidthNum, 396 * WidthNum, 16 * WidthNum, 16 * WidthNum)];
        [_numberSecondLabel setBackgroundColor:RGB(237, 60, 60)];
        [_numberSecondLabel setTextColor:[UIColor whiteColor]];
        [_numberSecondLabel setTextAlignment:NSTextAlignmentCenter];
        [_numberSecondLabel setFont:[UIFont systemFontOfSize:12]];
        [_numberSecondLabel.layer setMasksToBounds:YES];
        [_numberSecondLabel.layer setCornerRadius:8 * WidthNum];
        _numberSecondLabel.hidden = YES;
    }
    return _numberSecondLabel;
}

- (UILabel *)numberThirdLabel {
    if (!_numberThirdLabel) {
        _numberThirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(255 * WidthNum, 396 * WidthNum, 16 * WidthNum, 16 * WidthNum)];
        [_numberThirdLabel setBackgroundColor:RGB(237, 60, 60)];
        [_numberThirdLabel setTextColor:[UIColor whiteColor]];
        [_numberThirdLabel setTextAlignment:NSTextAlignmentCenter];
        [_numberThirdLabel setFont:[UIFont systemFontOfSize:12]];
        [_numberThirdLabel.layer setMasksToBounds:YES];
        [_numberThirdLabel.layer setCornerRadius:8 * WidthNum];
        _numberThirdLabel.hidden = YES;
    }
    return _numberThirdLabel;
}


- (UIView *)composedView {
    if (!_composedView) {
        _composedView = [[UIView alloc]init];
        _composedView.hidden = YES;
        CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.colors = @[(__bridge id)RGB(222, 222, 222).CGColor,(__bridge id)RGB(184, 184, 184).CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.frame = CGRectMake(0, 0, 180, 40);
        [_composedView.layer setMasksToBounds:YES];
        [_composedView.layer setCornerRadius:20];
        [_composedView.layer addSublayer:gradientLayer];
    }
    return _composedView;
}

- (UIButton *)composedBtn {
    if (!_composedBtn) {
        _composedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _composedBtn.userInteractionEnabled = NO;
        [_composedBtn setTitle:@"去合成" forState:UIControlStateNormal];
        [_composedBtn setBackgroundColor:[UIColor clearColor]];
        [_composedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_composedBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_composedBtn addTarget:self action:@selector(composedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _composedBtn;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:RGBA(0, 0, 0, 0.65)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisView)];
        [self addGestureRecognizer:tap];    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:RGBA(0, 0, 0, 0.65)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisView)];
        [self addGestureRecognizer:tap];    }
    return self;
}

- (void)createView {

    WS(ws);
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.mas_centerX);
        make.centerY.equalTo(ws.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(317 * WidthNum, 504 * WidthNum));
    }];
    [imageView addSubview:self.numberFirstLabel];
    [imageView addSubview:self.numberSecondLabel];
    [imageView addSubview:self.numberThirdLabel];

    
    [self addSubview:self.composedView];
    [self.composedView addSubview:self.composedBtn];
    [self.composedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.mas_centerX);
        make.centerY.equalTo(imageView.mas_bottom).with.offset(-14 * WidthNum);
        make.size.mas_equalTo(CGSizeMake(180, 40));
    }];
    [self.composedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.mas_centerX);
        make.centerY.equalTo(imageView.mas_bottom).with.offset(-14 * WidthNum);
        make.size.mas_equalTo(CGSizeMake(180, 40));
    }];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.petEatType = NO;
    switch (self.foodType) {
        case EGG:
            [imageView setImage:[UIImage imageNamed:@"鸡蛋-食材详情"]];
            break;
        case FLOUR:
            [imageView setImage:[UIImage imageNamed:@"面粉-食材详情"]];
            break;
        case CHEESE:
            [imageView setImage:[UIImage imageNamed:@"芝士-食材详情"]];
            break;
        case CHOCOLATE:
            [imageView setImage:[UIImage imageNamed:@"巧克力-食材详情"]];
            break;
        case BLUEBERRY:
            [imageView setImage:[UIImage imageNamed:@"蓝莓-食材详情"]];
            break;
        case STRAWBERRY:
            [imageView setImage:[UIImage imageNamed:@"草莓-食材详情"]];
            break;
        case MOTCHA:
            [imageView setImage:[UIImage imageNamed:@"抹茶粉-食材详情"]];
            break;
        case CUPCAKE:
            [imageView setImage:[UIImage imageNamed:@"巧克力纸杯蛋糕-食材详情"]];
            self.composedView.hidden = NO;
            [self.numberFirstLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"flour"] integerValue]]];
            [self.numberSecondLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"egg"] integerValue]]];
            [self.numberThirdLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"chocolate"] integerValue]]];
            self.numberFirstLabel.hidden = [[defaults objectForKey:@"flour"] integerValue]>0?NO:YES;
            self.numberSecondLabel.hidden = [[defaults objectForKey:@"egg"] integerValue]>0?NO:YES;
            self.numberThirdLabel.hidden = [[defaults objectForKey:@"chocolate"] integerValue]>0?NO:YES;
            self.petEatType = [[defaults objectForKey:@"cupcake"] integerValue]>0?YES:NO;
            break;
        case BLUEBERRY_CAKE:
            [imageView setImage:[UIImage imageNamed:@"蓝莓慕斯-食材详情"]];
            self.composedView.hidden = NO;
            [self.numberFirstLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"cheese"] integerValue]]];
            [self.numberSecondLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"egg"] integerValue]]];
            [self.numberThirdLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"blueberry"] integerValue]]];
            self.numberFirstLabel.hidden = [[defaults objectForKey:@"cheese"] integerValue]>0?NO:YES;
            self.numberSecondLabel.hidden = [[defaults objectForKey:@"egg"] integerValue]>0?NO:YES;
            self.numberThirdLabel.hidden = [[defaults objectForKey:@"blueberry"] integerValue]>0?NO:YES;
            self.petEatType = [[defaults objectForKey:@"blueberry_cake"] integerValue]>0?YES:NO;
            break;
        case MOTCHA_ROLL:
            [imageView setImage:[UIImage imageNamed:@"抹茶蛋糕卷-食材详情"]];
            self.composedView.hidden = NO;
            [self.numberFirstLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"flour"] integerValue]]];
            [self.numberSecondLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"egg"] integerValue]]];
            [self.numberThirdLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"motcha"] integerValue]]];
            self.numberFirstLabel.hidden = [[defaults objectForKey:@"flour"] integerValue]>0?NO:YES;
            self.numberSecondLabel.hidden = [[defaults objectForKey:@"egg"] integerValue]>0?NO:YES;
            self.numberThirdLabel.hidden = [[defaults objectForKey:@"motcha"] integerValue]>0?NO:YES;
            self.petEatType = [[defaults objectForKey:@"motcha_roll"] integerValue]>0?YES:NO;
            break;
        case STRAWBERRY_CAKE:
            [imageView setImage:[UIImage imageNamed:@"草莓芝士蛋糕-食材详情"]];
            self.composedView.hidden = NO;
            [self.numberFirstLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"flour"] integerValue]]];
            [self.numberSecondLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"cheese"] integerValue]]];
            [self.numberThirdLabel setText:[NSString stringWithFormat:@"%ld",[[defaults objectForKey:@"strawberry"] integerValue]]];
            self.numberFirstLabel.hidden = [[defaults objectForKey:@"flour"] integerValue]>0?NO:YES;
            self.numberSecondLabel.hidden = [[defaults objectForKey:@"cheese"] integerValue]>0?NO:YES;
            self.numberThirdLabel.hidden = [[defaults objectForKey:@"strawberry"] integerValue]>0?NO:YES;
            self.petEatType = [[defaults objectForKey:@"strawberry_cake"] integerValue]>0?YES:NO;
            break;
        default:
            break;
    }
    if (self.petEatType == YES) {
        [self.composedBtn setTitle:@"去喂养" forState:UIControlStateNormal];
        self.composedBtn.userInteractionEnabled = YES;
        CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
        gradientLayer.colors = @[(__bridge id)RGB(211, 162, 233).CGColor,(__bridge id)RGB(172, 118, 205).CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.frame = CGRectMake(0, 0, 180, 40);
        [_composedView.layer setMasksToBounds:YES];
        [_composedView.layer setCornerRadius:20];
        [_composedView.layer addSublayer:gradientLayer];
        [_composedView bringSubviewToFront:self.composedBtn];
    } else {
        if (self.numberFirstLabel.hidden == NO && self.numberSecondLabel.hidden == NO &&self.numberThirdLabel.hidden == NO) {
            self.composedBtn.userInteractionEnabled = YES;
            CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
            gradientLayer.colors = @[(__bridge id)RGB(211, 162, 233).CGColor,(__bridge id)RGB(172, 118, 205).CGColor];
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
            gradientLayer.frame = CGRectMake(0, 0, 180, 40);
            [_composedView.layer setMasksToBounds:YES];
            [_composedView.layer setCornerRadius:20];
            [_composedView.layer addSublayer:gradientLayer];
            [_composedView bringSubviewToFront:self.composedBtn];
        } else {
            self.composedBtn.userInteractionEnabled = NO;
            CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
            gradientLayer.colors = @[(__bridge id)RGB(222, 222, 222).CGColor,(__bridge id)RGB(184, 184, 184).CGColor];
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
            gradientLayer.frame = CGRectMake(0, 0, 180, 40);
            [_composedView.layer setMasksToBounds:YES];
            [_composedView.layer setCornerRadius:20];
            [_composedView.layer addSublayer:gradientLayer];
            [_composedView bringSubviewToFront:self.composedBtn];
        }
    }
    
    
}


- (void)dismisView {
    [self removeFromSuperview];
}
- (void)composedAction:(UIButton *)btn {

    if (self.petEatType == YES) {
        PetViewController *petVC = [[PetViewController alloc]init];
        [[self getFartherController].navigationController pushViewController:petVC animated:YES];
    } else {
        KitchenViewController *kitchenViewController = [[KitchenViewController alloc]init];
        kitchenViewController.foodType = self.foodType;
        [[self getFartherController].navigationController pushViewController:kitchenViewController animated:YES];
    }
    
    [self removeFromSuperview];
}

- (UIViewController *)getFartherController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
