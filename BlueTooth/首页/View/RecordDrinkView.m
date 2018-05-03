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

@property (nonatomic, strong)UIImageView *backImageView;
@property (nonatomic, strong)UILabel *textLabel;

@property (nonatomic, strong)UIImageView *drinkImage;
@property (nonatomic, strong)UILabel *drinkLabel;
@property (nonatomic, strong)UIImageView *noDrinkimage;
@property (nonatomic, strong)UILabel *noDrinklabel;

@end

@implementation RecordDrinkView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        
        [self creatView];
    }
    return self;
}

- (void)setUpCount:(NSInteger )count {
    for (UIView *subview in [self subviews]) {
        if (subview.tag == 20 || subview.tag == 21) {
            
        } else {
            [subview removeFromSuperview];
        }
    }
    
    if (count > 8) {
        
    } else {
        if (count > 0) {
            self.textLabel.text = [NSString stringWithFormat:@"今天已喝%ld杯，共%ldml",count,count * 250];
            //所有水杯的宽度     一个水杯宽度34      一个间隙 16
            CGFloat totalWidth = 34 * count + 16 * (count - 1);
            for (int i = 0; i < count; i++) {
                self.drinkImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - totalWidth)/2 + (34 + 16) * i, CGRectGetMaxY(self.backImageView.frame) + 16, 34, 52)];
                self.drinkImage.image = [UIImage imageNamed:@"满水杯"];
                [self addSubview:self.drinkImage];
                
                self.drinkLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - totalWidth)/2 + (34 + 16) * i, CGRectGetMaxY(self.drinkImage.frame) + 10, 34, 13)];
                self.drinkLabel.text = @"250ml";
                self.drinkLabel.textColor = [UIColor colorWithHex:@"c1c1c3"];
                self.drinkLabel.font = [UIFont systemFontOfSize:11];
                self.drinkLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:self.drinkLabel];
            }
        } else {
            self.textLabel.text = @"今天你还没喝水";
            self.noDrinkimage = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 34)/2, CGRectGetMaxY(self.backImageView.frame) + 16, 34, 52)];
            self.noDrinkimage.image = [UIImage imageNamed:@"空水杯"];
            [self addSubview:self.noDrinkimage];
            
            self.noDrinklabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.noDrinkimage.frame) + 10, self.frame.size.width, 13)];
            self.noDrinklabel.text = @"去喝一杯吧";
            self.noDrinklabel.textColor = [UIColor colorWithHex:@"c1c1c3"];
            self.noDrinklabel.font = [UIFont systemFontOfSize:11];
            self.noDrinklabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.noDrinklabel];
        }
    }  
}

- (void)creatView {
    self.backgroundColor = [UIColor colorWithHex:@"f8f7f9"];
    self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 20, self.frame.size.width - 80 * 2, 34)];
    self.backImageView.backgroundColor = [UIColor whiteColor];
    self.backImageView.image = [UIImage imageNamed:@""];
    self.backImageView.tag = 20;
    [self addSubview:self.backImageView];
    
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.backImageView.frame.size.width, 34)];
    self.textLabel.textColor = [UIColor colorWithHex:@"ad77cd"];
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.tag = 21;
    [self.backImageView addSubview:self.textLabel];
    
    
    
}



@end
