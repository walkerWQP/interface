//
//  HaveToReplyCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HaveToReplyCell.h"

@implementation HaveToReplyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeHaveToReplyCellUI];
    }
    return self;
}

- (void)makeHaveToReplyCellUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius = 30;
    [self.contentView addSubview:self.headImgView];
    
    self.problemLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, 10, self.contentView.frame.size.width - self.headImgView.frame.size.width - 30, 30)];
    self.problemLabel.textColor = titlColor;
    self.problemLabel.font = titleFont;
    [self.contentView addSubview:self.problemLabel];
    
    self.problemContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + self.headImgView.frame.size.height, self.contentView.frame.size.width - 20, 30)];
    self.problemContentLabel.textColor = titlColor;
    self.problemContentLabel.font = titleFont;
    [self.contentView addSubview:self.problemContentLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10,self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + 20, self.contentView.frame.size.width - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.contentView addSubview:self.lineView];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + self.lineView.frame.size.height + 25, 60, 60)];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 30;
    [self.contentView addSubview:self.headImageView];
    
    self.replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.frame.size.width + 20, self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + self.lineView.frame.size.height + 30, self.contentView.frame.size.width - self.headImageView.frame.size.width - 30, 30)];
    self.replyLabel.textColor = titlColor;
    self.replyLabel.font = titleFont;
    [self.contentView addSubview:self.replyLabel];
    
    self.replyContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + self.lineView.frame.size.height + self.headImageView.frame.size.height + 30, self.contentView.frame.size.width - 20, 30)];
    self.replyContentLabel.textColor = titlColor;
    self.replyContentLabel.font = titleFont;
    [self.contentView addSubview:self.replyContentLabel];
    
}

@end
