//
//  TeacherListNCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherListNCell.h"

@implementation TeacherListNCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.TeacherListNImg.layer.cornerRadius = 4;
    self.TeacherListNImg.layer.masksToBounds = YES;
    self.lineView.backgroundColor = backColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
