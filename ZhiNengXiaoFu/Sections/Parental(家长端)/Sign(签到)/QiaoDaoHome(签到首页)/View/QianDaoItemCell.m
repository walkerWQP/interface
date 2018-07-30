//
//  QianDaoItemCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "QianDaoItemCell.h"

@implementation QianDaoItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.shuxianLabel];
        [self addSubview:self.stateLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.detailsTimeLabel];

    }
    return self;
}

- (UILabel *)shuxianLabel
{
    if (!_shuxianLabel) {
        self.shuxianLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 4, 60)];
        self.shuxianLabel.backgroundColor = [UIColor colorWithRed:175 / 255.0 green:227 / 255.0 blue:207 / 255.0 alpha:1];
    }
    return _shuxianLabel;
}


- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 50, 50)];
        self.stateLabel.textColor = [UIColor whiteColor];
        self.stateLabel.layer.cornerRadius = 25;
        self.stateLabel.layer.masksToBounds = YES;
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        self.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    }
    return _stateLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.stateLabel.frame.size.width + self.stateLabel.frame.origin.x + 12, self.stateLabel.frame.origin.y + 5, 70, 20)];
        self.timeLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _timeLabel;
}

- (UILabel *)detailsTimeLabel
{
    if (!_detailsTimeLabel) {
        self.detailsTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake( self.timeLabel.frame.origin.x, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height, 100, 20)];
        self.detailsTimeLabel.textColor = [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1];
        self.detailsTimeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _detailsTimeLabel;
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
