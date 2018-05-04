//
//  GetToolViewController.m
//  BlueTooth
//
//  Created by Qian on 2018/4/24.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "GetToolViewController.h"
#import "UIColor+Hex.h"
@interface GetToolViewController ()

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *smallLabel;
@property (nonatomic, strong)UIButton *leftBtn;
@property (nonatomic, strong)UIButton *rightBtn;

@end

@implementation GetToolViewController

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.layer.cornerRadius = 15;
        _backView.clipsToBounds = YES;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHex:@"333333"];
        _titleLabel.font = [UIFont systemFontOfSize:30];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)smallLabel {
    if (!_smallLabel) {
        _smallLabel = [[UILabel alloc]init];
        _smallLabel.text = @"一定数量的食材可以合成小蛋糕哦\n快去地图探索吧！";
        _smallLabel.textColor = [UIColor colorWithHex:@"b2b2b2"];
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
        [_leftBtn setTitle:@"查看冰箱" forState:UIControlStateNormal];
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
        [_rightBtn setTitle:@"继续探索" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightBtn.backgroundColor = [UIColor colorWithHex:@"a96acc"];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return _rightBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)setUpUI:(ToolType)toolType {
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
        make.size.mas_equalTo(CGSizeMake(287 * WidthNum, 327 * HeightNum));
    }];
    
    [self.backView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(38));
        make.centerX.equalTo(ws.backView);
        make.size.mas_equalTo(CGSizeMake(164 * WidthNum, 104 * HeightNum));
    }];
    
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.imageView.mas_bottom).with.offset(30);
        make.left.equalTo(ws.backView.mas_left).with.offset(0);
        make.right.equalTo(ws.backView.mas_right).with.offset(0);
        make.height.equalTo(@30);
    }];
    [self.backView addSubview:self.smallLabel];
    [self.smallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.titleLabel.mas_bottom).with.offset(16);
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
    if (toolType == 0) {
        self.imageView.image = [UIImage imageNamed:@"草莓"];
        self.titleLabel.text = @"获得新草莓啦！";
        
    } else if (toolType == 1) {
        self.imageView.image = [UIImage imageNamed:@"鸡蛋"];
        self.titleLabel.text = @"获得新鸡蛋啦！";
    } else if (toolType == 2) {
        self.imageView.image = [UIImage imageNamed:@"蓝莓"];
        self.titleLabel.text = @"获得新蓝莓啦！";
    } else if (toolType == 3) {
        self.imageView.image = [UIImage imageNamed:@"面粉"];
        self.titleLabel.text = @"获得新面粉啦！";
    } else if (toolType == 4) {
        self.imageView.image = [UIImage imageNamed:@"巧克力"];
        self.titleLabel.text = @"获得新巧克力啦！";
    } else if (toolType == 5) {
        self.imageView.image = [UIImage imageNamed:@"芝士"];
        self.titleLabel.text = @"获得新芝士啦！";
    } else if (toolType == 6) {
        self.imageView.image = [UIImage imageNamed:@"motchax"];
        self.titleLabel.text = @"获得新抹茶粉啦！";
    } else {
        self.titleLabel.text = @"获得新壁纸啦！";
    }
}

#pragma mark -- UITapGestureRecognizer methods
- (void)dismisView {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)leftBtnAction:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"goRefri" object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)rightBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
