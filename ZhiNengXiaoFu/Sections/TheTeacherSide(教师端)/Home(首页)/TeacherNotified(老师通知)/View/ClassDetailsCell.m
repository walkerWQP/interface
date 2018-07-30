//
//  ClassDetailsCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassDetailsCell.h"

@implementation ClassDetailsCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeClassDetailsCellCellUI];
    }
    return self;
}

- (void)makeClassDetailsCellCellUI {
    self.backgroundColor = [UIColor whiteColor];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    self.headImgView.layer.cornerRadius = self.headImgView.frame.size.width/2.0;
    self.headImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, 5, APP_WIDTH * 0.6, 30)];
    self.titleLabel.font = titleFont;
    self.titleLabel.textColor = titlColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, self.titleLabel.frame.size.height + 5, APP_WIDTH * 0.6, 30)];
    self.subjectsLabel.font = contentFont;
    self.subjectsLabel.textColor = contentColor;
    [self.contentView addSubview:self.subjectsLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 90, self.titleLabel.frame.size.height + 5, 80, 30)];
    self.timeLabel.textColor = contentColor;
    self.timeLabel.font = contentFont;
    [self.contentView addSubview:self.timeLabel];
    
}

@end
