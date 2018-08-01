//
//  TongZhiCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TongZhiCell.h"

@implementation TongZhiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeSchoolDynamicCellCellUI];
        
    }
    return self;
}

- (void)makeSchoolDynamicCellCellUI {
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreenWidth, 10)];
    self.lineView.backgroundColor = dividerColor;
    [self.contentView addSubview:self.lineView];
    self.backgroundColor = [UIColor whiteColor];
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.lineView.frame.origin.y + self.lineView.frame.size.height + 15, 40, 40)];
    self.headImgView.layer.cornerRadius = self.headImgView.frame.size.width/2.0;
    self.headImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width,self.lineView.frame.origin.y + self.lineView.frame.size.height + 11, APP_WIDTH * 0.6, 20)];
    self.titleLabel.font = titleFont;
    self.titleLabel.textColor = titlColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, self.titleLabel.frame.size.height+ self.titleLabel.frame.origin.y + 5, APP_WIDTH * 0.6, 20)];
    self.subjectsLabel.font = contentFont;
    self.subjectsLabel.textColor = contentColor;
    [self.contentView addSubview:self.subjectsLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 90, self.subjectsLabel.frame.origin.y, 80, 30)];
    self.timeLabel.textColor = contentColor;
    self.timeLabel.font = contentFont;
    [self.contentView addSubview:self.timeLabel];
    
   

    
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
