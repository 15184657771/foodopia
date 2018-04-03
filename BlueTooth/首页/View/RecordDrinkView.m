//
//  RecordDrinkView.m
//  BlueTooth
//
//  Created by Qian on 2018/4/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "RecordDrinkView.h"
#import "UIColor+Hex.h"

@interface RecordDrinkView()

@property (nonatomic, strong)UILabel *textLabel;

@end

@implementation RecordDrinkView

- (instancetype)initWithFrame:(CGRect)frame andCount:(NSInteger)count
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        [self creatView:count];
    }
    return self;
}

- (void)creatView:(NSInteger)count {
    self.backgroundColor = [UIColor colorWithHex:@"f8f7f9"];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 20, self.frame.size.width - 80 * 2, 34)];
    backImageView.backgroundColor = [UIColor whiteColor];
    backImageView.image = [UIImage imageNamed:@""];
    [self addSubview:backImageView];
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, backImageView.frame.size.width, 34)];
    self.textLabel.text = @"今天已喝3杯，共750ml";
    self.textLabel.textColor = [UIColor colorWithHex:@"ad77cd"];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [backImageView addSubview:self.textLabel];
    
    //所有水杯的宽度     一个水杯宽度34      一个间隙 16
    CGFloat totalWidth = 34 * count + 16 * (count - 1);
    
    for (int i = 0; i < count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - totalWidth)/2 + (34 + 16) * i, CGRectGetMaxY(backImageView.frame) + 16, 34, 52)];
        image.image = [UIImage imageNamed:@"满水杯"];
        [self addSubview:image];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - totalWidth)/2 + (34 + 16) * i, CGRectGetMaxY(image.frame) + 10, 34, 13)];
        label.text = @"250ml";
        label.textColor = [UIColor colorWithHex:@"c1c1c3"];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
        
    }
    
   
}



@end
