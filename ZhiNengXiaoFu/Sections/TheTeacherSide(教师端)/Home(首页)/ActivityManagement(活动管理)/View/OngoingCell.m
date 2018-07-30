//
//  OngoingCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "OngoingCell.h"

@implementation OngoingCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeOngoingCellUI];
    }
    return self;
}

- (void)makeOngoingCellUI {
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT * 0.3)];
    [self.contentView addSubview:self.imgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.imgView.frame.size.width, 40)];
    self.titleLabel.backgroundColor = touMColor;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.imgView addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgView.frame.size.height - 30, self.imgView.frame.size.width * 0.7, 30)];
    self.timeLabel.backgroundColor = touMColor;
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font = contentFont;
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    [self.imgView addSubview:self.timeLabel];
    
    self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imgView.frame.size.width * 0.7, self.imgView.frame.size.height - 30, self.imgView.frame.size.width * 0.3, 30)];
    self.detailsLabel.backgroundColor = touMColor;
    self.detailsLabel.textColor = [UIColor whiteColor];
    self.detailsLabel.font = contentFont;
    self.detailsLabel.text = @"查看详情";
    self.detailsLabel.textAlignment = NSTextAlignmentCenter;
    [self.imgView addSubview:self.detailsLabel];
    
    
}

@end
