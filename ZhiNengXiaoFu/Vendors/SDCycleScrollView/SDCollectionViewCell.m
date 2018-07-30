//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/**
 
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到gsdios@126.com 或者 到                       *
 * https://github.com/gsdios?tab=repositories 提交问题     *
 *                                                      *
 *******************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"
#import "Masonry.h"
@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
        [self setupBackGroundImageView];
        [self setupBiaoqianLabel];
        [self bringSubviewToFront:_titleLabel];
        [self bringSubviewToFront:_biaoqianLabel];
    }
    
    return self;
}

//- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
//{
//    _titleLabelBackgroundColor = titleLabelBackgroundColor;
//    _titleLabel.backgroundColor = titleLabelBackgroundColor;
//}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17.0f];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self addSubview:titleLabel];
}

- (void)setupBiaoqianLabel
{
    UILabel * biaoqianlabel = [[UILabel alloc] init];
    
//    [biaoqianlabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.greaterThanOrEqualTo(@40);
//        make.top.equalTo(_titleLabel).offset(30);
//    }];
    
    _biaoqianLabel = biaoqianlabel;
    biaoqianlabel.layer.masksToBounds = YES;
    biaoqianlabel.layer.cornerRadius = 4;
    biaoqianlabel.font = [UIFont systemFontOfSize:11];
    biaoqianlabel.textColor = [UIColor whiteColor];
    
    _biaoqianLabel.textAlignment = NSTextAlignmentCenter;;
    biaoqianlabel.backgroundColor = [UIColor redColor];
    [self addSubview:biaoqianlabel];
}

- (void)setupBackGroundImageView
{
    UIImageView * BackGroundimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 100, self.bounds.size.width, 100)];
    BackGroundimageView.image = [UIImage imageNamed:@"cover"];
    _backGroudView = BackGroundimageView;
    [self addSubview:BackGroundimageView];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = [NSString stringWithFormat:@"%@", title];
    _titleLabel.frame = CGRectMake(10, 1, 1, 1);
}

- (void)setBiaoqiantitle:(NSString *)biaoqiantitle
{
    _biaoqiantitle = [biaoqiantitle copy];
    _biaoqianLabel.text = [NSString stringWithFormat:@"%@", biaoqiantitle];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    
    
    CGSize biaoQianSize = CGSizeZero;
    if (_biaoqianLabel.text.length >0)
    {
    
         NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:10]};
         biaoQianSize = [_biaoqianLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), 30) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    
    
    CGFloat titleLabelW = kScreenWidth - (biaoQianSize.width>0?biaoQianSize.width+10 +10:10);
    CGFloat titleLabelH = _titleLabelHeight;
    CGFloat titleLabelX = biaoQianSize.width>0?(biaoQianSize.width+17 +10):10;
    CGFloat titleLabelY = self.sd_height - titleLabelH;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
//    _titleLabel.backgroundColor = [UIColor blueColor];
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17.0f];

    _biaoqianLabel.frame = CGRectMake(10, titleLabelY + (titleLabelH-20)/2, biaoQianSize.width>0?biaoQianSize.width +12:0, 20);
    _titleLabel.hidden = !_titleLabel.text;
    

}

@end
