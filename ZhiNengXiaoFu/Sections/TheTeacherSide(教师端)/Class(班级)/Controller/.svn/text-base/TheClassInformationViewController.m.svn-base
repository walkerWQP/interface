//
//  TheClassInformationViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TheClassInformationViewController.h"

@interface TheClassInformationViewController ()

@property (nonatomic, strong) UIImageView    *backImgView;
@property (nonatomic, strong) UIImageView    *headImgView;
@property (nonatomic, strong) UIView         *bgView;
//班主任
@property (nonatomic, strong) UILabel        *chargeLabel;
@property (nonatomic, strong) UILabel        *chargeNameLabel;
//课任教师
@property (nonatomic, strong) UILabel        *teachersLabel;
@property (nonatomic, strong) UILabel        *teachersNameLael;
//班委班干
@property (nonatomic, strong) UILabel       *dryLabel;
@property (nonatomic, strong) UILabel       *dryNameLabel;
//班级人数
@property (nonatomic, strong) UILabel       *numberLabel;
@property (nonatomic, strong) UILabel       *numberPeopleLabel;
//班级寄语
@property (nonatomic, strong) UILabel       *remarkLabel;
@property (nonatomic, strong) UILabel       *remarksLabel;

@end

@implementation TheClassInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"班级信息";
    [self makeTheClassInformationViewControllerUI];
}

- (void)makeTheClassInformationViewControllerUI {
    self.backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.backImgView.image = [UIImage imageNamed:@"背景图"];
    [self.view addSubview:self.backImgView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, APP_WIDTH - 40, APP_HEIGHT * 0.15)];
    self.headImgView.image = [UIImage imageNamed:@"班级信息"];
    [self.backImgView addSubview:self.headImgView];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(40, self.headImgView.frame.size.height + 40, APP_WIDTH - 80, APP_HEIGHT * 0.65)];
    self.bgView.backgroundColor = whiteTMColor;
    [self.backImgView addSubview:self.bgView];
    
    self.chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 80, 30)];
    self.chargeLabel.text = @"班级主任:";
    self.chargeLabel.textColor = [UIColor blackColor];
    self.chargeLabel.font = titleFont;
    [self.bgView addSubview:self.chargeLabel];
    
    self.chargeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.chargeLabel.frame.size.width + 30, 20, 100, 30)];
    self.chargeNameLabel.text = @"上官欧阳";
    self.chargeNameLabel.textColor = titlColor;
    self.chargeNameLabel.font = titleFont;
    self.chargeNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.chargeNameLabel];
    
    self.teachersLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.chargeLabel.frame.size.height + 20, self.chargeLabel.frame.size.width, 30)];
    self.teachersLabel.text = @"科任老师:";
    self.teachersLabel.textColor = [UIColor blackColor];
    self.teachersLabel.font = titleFont;
    [self.bgView addSubview:self.teachersLabel];
    
    self.teachersNameLael = [[UILabel alloc] initWithFrame:CGRectMake(self.teachersLabel.frame.size.width + 30, self.chargeLabel.frame.size.height + 20, 200, 30)];
    self.teachersNameLael.text = @"上官欧阳(语文)";
    self.teachersNameLael.textColor = titlColor;
    self.teachersNameLael.font = titleFont;
    self.teachersNameLael.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.teachersNameLael];
    
    self.dryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.chargeLabel.frame.size.height + self.teachersLabel.frame.size.height + 20, self.chargeLabel.frame.size.width, 30)];
    self.dryLabel.text = @"班委班干:";
    self.dryLabel.textColor = [UIColor blackColor];
    self.dryLabel.font = titleFont;
    [self.bgView addSubview:self.dryLabel];
    
    self.dryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.dryLabel.frame.size.width + 30, self.chargeLabel.frame.size.height + self.teachersLabel.frame.size.height + 20, self.teachersNameLael.frame.size.width, 30)];
    self.dryNameLabel.text = @"上官云飞";
    self.dryNameLabel.textColor = titlColor;
    self.dryNameLabel.font = titleFont;
    [self.bgView addSubview:self.dryNameLabel];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.chargeLabel.frame.size.height + self.teachersLabel.frame.size.height + self.dryLabel.frame.size.height + 20, self.chargeLabel.frame.size.width, 30)];
    self.numberLabel.text = @"班级人数:";
    self.numberLabel.textColor = [UIColor blackColor];
    self.numberLabel.font = titleFont;
    [self.bgView addSubview:self.numberLabel];
    
    self.numberPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.numberLabel.frame.size.width + 30, self.chargeLabel.frame.size.height + self.teachersLabel.frame.size.height + self.dryLabel.frame.size.height + 20, self.teachersNameLael.frame.size.width, 30)];
    self.numberPeopleLabel.text = @"36人";
    self.numberPeopleLabel.textColor = titlColor;
    self.numberPeopleLabel.font = titleFont;
    [self.bgView addSubview:self.numberPeopleLabel];
    
    self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.chargeLabel.frame.size.height + self.teachersLabel.frame.size.height + self.dryLabel.frame.size.height + self.numberLabel.frame.size.height + 20, self.chargeLabel.frame.size.width, 30)];
    self.remarkLabel.text = @"班级寄语:";
    self.remarkLabel.textColor = [UIColor blackColor];
    self.remarkLabel.font = titleFont;
    [self.bgView addSubview:self.remarkLabel];
    
    self.remarksLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.remarkLabel.frame.size.width + 30, self.chargeLabel.frame.size.height + self.teachersLabel.frame.size.height + self.dryLabel.frame.size.height + self.numberLabel.frame.size.height , self.bgView.frame.size.width - self.remarkLabel.frame.size.width - 50, 90)];
    self.remarksLabel.text = @"努力不一定有收获, 但是不努力一定没有收获。";
    self.remarksLabel.textColor = titlColor;
    self.remarksLabel.font = titleFont;
    self.remarksLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.remarksLabel.numberOfLines = 0;
    [self.bgView addSubview:self.remarksLabel];
    
    
}

@end
