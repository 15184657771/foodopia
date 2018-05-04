//
//  NoFoodViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/5/4.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "NoFoodViewController.h"
#import "UIColor+Hex.h"

@interface NoFoodViewController ()

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *smallLabel;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong)UIImageView *imageView;


@end

@implementation NoFoodViewController

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.layer.cornerRadius = 15;
        _backView.clipsToBounds = YES;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHex:@"333333"];
        _titleLabel.text = @"还没获得这个食材";
        _titleLabel.font = [UIFont systemFontOfSize:30];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)smallLabel {
    if (!_smallLabel) {
        _smallLabel = [[UILabel alloc]init];
//        _smallLabel.text = @"一定数量的食材可以合成小蛋糕哦\n快去地图探索吧！";
//        _smallLabel.textColor = [UIColor colorWithHex:@"b2b2b2"];
        _smallLabel.font = [UIFont systemFontOfSize:12];
        _smallLabel.textAlignment = NSTextAlignmentCenter;
        _smallLabel.numberOfLines = 0;
        [_smallLabel sizeToFit];
    }
    return _smallLabel;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftBtn.backgroundColor = [UIColor colorWithHex:@"bf8cdb"];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    [_leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"去冰箱" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightBtn.backgroundColor = [UIColor colorWithHex:@"a96acc"];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _rightBtn;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"0-无蛋糕"];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUpUI:(FoodType)toolType {
    self.view.backgroundColor = [UIColor colorWithHex:@"28313D" alpha:0.7f];
    
    UIView *cancelBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    cancelBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cancelBackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisView)];
    [cancelBackView addGestureRecognizer:tap];
    
    WS(ws);
    [self.view addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(45 * WidthNum));
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(285 * WidthNum, 212 * HeightNum));
    }];
    
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.backView.mas_top).with.offset(45);
        make.left.equalTo(ws.backView.mas_left).with.offset(0);
        make.right.equalTo(ws.backView.mas_right).with.offset(0);
        make.height.equalTo(@30);
    }];
    [self.backView addSubview:self.smallLabel];
    [self.smallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.titleLabel.mas_bottom).with.offset(25);
        make.left.equalTo(ws.backView.mas_left).with.offset(50);
        make.right.equalTo(ws.backView.mas_right).with.offset(-50);
    }];
    
    [self.backView addSubview:self.leftBtn];
    [self.backView addSubview:self.rightBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(ws.rightBtn.mas_left).with.offset(0);
        make.width.equalTo(ws.rightBtn.mas_width);
        make.height.equalTo(@50);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.left.equalTo(ws.leftBtn.mas_right).with.offset(0);
        make.width.equalTo(ws.leftBtn.mas_width);
        make.height.equalTo(@50);
    }];
    
    [cancelBackView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cancelBackView.mas_bottom).with.offset(-40);
        make.centerX.equalTo(cancelBackView.mas_centerX);
    }];
    
    NSMutableAttributedString * headPart = [[NSMutableAttributedString alloc] initWithString:@"需要先获得食材:"];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHex:@"b2b2b2"],};
    [headPart setAttributes:firstAttributes range:NSMakeRange(0,headPart.length)];
    NSMutableAttributedString * lastPart = [[NSMutableAttributedString alloc] initWithString:@" \n快去冰箱里合成它，再来喂养吧"];
    NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHex:@"b2b2b2"],};
    [lastPart setAttributes:secondAttributes range:NSMakeRange(0,lastPart.length)];
   
    
    
    
    if (toolType == 0) {
        self.imageView.image = [UIImage imageNamed:@"0-无蛋糕"];
        NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:@"巧克力纸杯蛋糕"];
        NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHex:@"a96acc"],};
        [firstPart setAttributes:firstAttributes range:NSMakeRange(0,firstPart.length)];
        [headPart appendAttributedString:firstPart];
        
        
    } else if (toolType == 1) {
        self.imageView.image = [UIImage imageNamed:@"1-无蛋糕"];
        NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:@"蓝莓慕斯"];
        NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHex:@"a96acc"],};
        [secondPart setAttributes:firstAttributes range:NSMakeRange(0,secondPart.length)];
        [headPart appendAttributedString:secondPart];
    } else if (toolType == 2) {
        self.imageView.image = [UIImage imageNamed:@"2-无蛋糕"];
        NSMutableAttributedString * thirdPart = [[NSMutableAttributedString alloc] initWithString:@"草莓芝士"];
        NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHex:@"a96acc"],};
        [thirdPart setAttributes:firstAttributes range:NSMakeRange(0,thirdPart.length)];
        [headPart appendAttributedString:thirdPart];
        
    } else if (toolType == 3) {
        self.imageView.image = [UIImage imageNamed:@"3-无蛋糕"];
        NSMutableAttributedString * forthPart = [[NSMutableAttributedString alloc] initWithString:@"抹茶卷"];
        NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithHex:@"a96acc"],};
        [forthPart setAttributes:firstAttributes range:NSMakeRange(0,forthPart.length)];
        [headPart appendAttributedString:forthPart];
    }
    [headPart appendAttributedString:lastPart];
    self.smallLabel.attributedText = headPart;
}

#pragma mark -- UITapGestureRecognizer methods
- (void)dismisView {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)leftBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)rightBtnAction:(UIButton *)sender {
    [self.delegate NoFoodViewDelegate];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
