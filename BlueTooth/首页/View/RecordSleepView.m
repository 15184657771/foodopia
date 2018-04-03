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
    
    
    
}

@end
