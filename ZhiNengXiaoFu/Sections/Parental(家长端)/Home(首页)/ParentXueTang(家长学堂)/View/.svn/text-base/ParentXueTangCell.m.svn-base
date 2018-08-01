//
//  ParentXueTangCell.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ParentXueTangCell.h"

@implementation ParentXueTangCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    self.ShiPinListImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 111, 92)];
    self.ShiPinListImg.image = [UIImage imageNamed:@"视频列表"];
    [self addSubview:self.ShiPinListImg];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ShiPinListImg.frame.origin.x + self.ShiPinListImg.frame.size.width + 10, 20, 200, 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = COLOR(147, 147, 147, 1);
    [self addSubview:self.titleLabel];
    
    self.biaoQianOneImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 50, 21)];
    [self addSubview:self.biaoQianOneImg];
    
    self.biaoQianTwoImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.biaoQianOneImg.frame.origin.x + self.biaoQianOneImg.frame.size.width + 5, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 50, 21)];
    [self addSubview:self.biaoQianTwoImg];
    
    self.biaoQianThreeImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.biaoQianTwoImg.frame.origin.x + self.biaoQianTwoImg.frame.size.width + 5, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 50, 21)];
    [self addSubview:self.biaoQianThreeImg];
    
    //标签3个
    self.biaoQianOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 50, 21)];
    self.biaoQianOneLabel.textAlignment = NSTextAlignmentCenter;
    self.biaoQianOneLabel.textColor = [UIColor whiteColor];
    self.biaoQianOneLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.biaoQianOneLabel];
    
    self.biaoQianTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.biaoQianOneImg.frame.origin.x + self.biaoQianOneImg.frame.size.width + 5, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 50, 21)];
    self.biaoQianTwoLabel.textColor = [UIColor whiteColor];
    self.biaoQianTwoLabel.textAlignment = NSTextAlignmentCenter;
    self.biaoQianTwoLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.biaoQianTwoLabel];
    
    self.biaoQianThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.biaoQianTwoImg.frame.origin.x + self.biaoQianTwoImg.frame.size.width + 5, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, 50, 21)];
    self.biaoQianThreeLabel.font = [UIFont systemFontOfSize:12];
    self.biaoQianThreeLabel.textAlignment = NSTextAlignmentCenter;
    self.biaoQianThreeLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.biaoQianThreeLabel];
    
    
    self.liulanImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.biaoQianOneImg.frame.origin.x , self.biaoQianOneImg.frame.origin.y + self.biaoQianOneImg.frame.size.height + 10, 19, 12)];
    self.liulanImg.image = [UIImage imageNamed:@"眼睛"];
    [self addSubview:self.liulanImg];

    self.liulanLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.liulanImg.frame.origin.x + self.liulanImg.frame.size.width + 5 , self.liulanImg.frame.origin.y, 70, 12)];
    self.liulanLabel.font = [UIFont systemFontOfSize:12];
    self.liulanLabel.textColor = COLOR(167, 167, 167, 1);
    [self addSubview:self.liulanLabel];
    
    
    self.JiShuImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.liulanLabel.frame.origin.x + self.liulanLabel.frame.size.width + 5, self.liulanImg.frame.origin.y - 1, 15, 14)];
    self.JiShuImg.image = [UIImage imageNamed:@"播放"];
    [self addSubview:self.JiShuImg];
    
    self.jiShuLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.JiShuImg.frame.origin.x + self.JiShuImg.frame.size.width + 5 , self.JiShuImg.frame.origin.y, 40, 12)];
    self.jiShuLabel.font = [UIFont systemFontOfSize:12];
    self.jiShuLabel.textColor = COLOR(167, 167, 167, 1);
    [self addSubview:self.jiShuLabel];
    
    
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
