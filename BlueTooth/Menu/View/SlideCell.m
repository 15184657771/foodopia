//
//  SlideCell.m
//  BlueTooth
//
//  Created by Chen on 2018/3/8.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "SlideCell.h"

@interface SlideCell()

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SlideCell

- (UIImageView *)titleImage {
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc]init];
    }
    return _titleImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setFont:[UIFont systemFontOfSize:20]];
    }
    return _titleLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)createView {
    WS(ws);
    [self.contentView addSubview:self.titleImage];
    [self.contentView addSubview:self.titleLabel];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView.mas_centerY);
        make.left.equalTo(ws.contentView.mas_left).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(20 , 20));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.titleImage.mas_right).with.offset(15);
        make.centerY.equalTo(ws.titleImage.mas_centerY);
    }];
}

- (void)setValueWithModel:(SlideModel *)model {
    [self.titleImage setImage:[UIImage imageNamed:model.imageName]];
    [self.titleLabel setText:model.titleStr];
}

@end

