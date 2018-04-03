//
//  RecordWeightView.m
//  BlueTooth
//
//  Created by Qian on 2018/4/3.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "RecordWeightView.h"
#import "UIColor+Hex.h"

@implementation RecordWeightView

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
}

@end
