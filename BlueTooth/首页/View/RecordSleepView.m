//
//  RecordSleepView.m
//  BlueTooth
//
//  Created by Qian on 2018/4/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "RecordSleepView.h"
#import "UIColor+Hex.h"

@interface RecordSleepView()

@property (nonatomic, strong)UIImageView *backImageView;
@property (nonatomic, strong)UILabel *timeLabel;
@end

@implementation RecordSleepView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        [self creatView];
    }
    return self;
}

- (void)creatView {
    self.backgroundColor = [UIColor colorWithHex:@"f8f7f9"];
    
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 20, self.frame.size.width - 80 * 2, 34)];
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.image = [UIImage imageNamed:@""];
    [self addSubview:self.backImageView];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(20);
        make.height.equalTo(@(34));
        make.left.equalTo(self.mas_left).with.offset(80);
        make.right.equalTo(self.mas_right).with.offset(-80);
        
    }];
    
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.text = @"今天你已经睡了";
    textLabel.textColor = [UIColor colorWithHex:@"ad77cd"];
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self.backImageView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_top).with.offset(0);
        make.bottom.equalTo(self.backImageView.mas_bottom).with.offset(0);
        make.left.equalTo(self.backImageView.mas_left).with.offset(15);
        make.right.equalTo(self.backImageView.mas_right).with.offset(-15);
       
    }];
    self.timeLabel = [[UILabel alloc]init];
    
    self.timeLabel.textColor = [UIColor colorWithHex:@"ad77cd"];
    self.timeLabel.font = [UIFont systemFontOfSize:35];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_bottom).with.offset(20);
        make.bottom.equalTo(self.mas_bottom).with.offset(-30);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        
    }];
    
}
- (void)setText:(NSString *)str {
    self.timeLabel.text = str;
}

@end
