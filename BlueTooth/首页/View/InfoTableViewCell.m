//
//  InfoTableViewCell.m
//  BlueTooth
//
//  Created by Qian on 2018/4/6.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "InfoTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Hex.h"

@implementation InfoTableViewCell

- (UILabel *)bigLabel {
    if (!_bigLabel) {
        _bigLabel = [[UILabel alloc]init];
        _bigLabel.textColor = [UIColor colorWithHex:@"999999"];
        _bigLabel.font = [UIFont systemFontOfSize:20];
    }
    return _bigLabel;
    
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textColor = [UIColor colorWithHex:@"d9d9d9"];
        _dateLabel.font = [UIFont systemFontOfSize:15];
    }
    return _dateLabel;
    
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor colorWithHex:@"ad77cd"];
        _timeLabel.font = [UIFont systemFontOfSize:26];
    }
    return _timeLabel;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.bigLabel];
    [self.bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(30);
        make.top.equalTo(self).with.offset(26);
        make.height.mas_equalTo(@20);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(30);
        make.top.equalTo(self.bigLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(@16);
    }];
    
    [self addSubview:self.timeLabel];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-30);
        make.top.equalTo(self).with.offset(0);
        make.bottom.equalTo(self).with.offset(0);
    }];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHex:@"f3f1f4"];
    [self addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(30);
        make.right.equalTo(self).with.offset(-30);
        make.bottom.equalTo(self).with.offset(0);
        make.height.equalTo(@1);
    }];
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
