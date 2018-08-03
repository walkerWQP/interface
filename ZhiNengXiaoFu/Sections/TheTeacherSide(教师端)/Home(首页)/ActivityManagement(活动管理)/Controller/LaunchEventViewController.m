//
//  LaunchEventViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LaunchEventViewController.h"

@interface LaunchEventViewController ()<UITextFieldDelegate>

//活动标题
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UITextField *titleTextField;
//时间
@property (nonatomic, strong) UILabel     *timeLabel;
@property (nonatomic, strong) UIView      *timeView;
@property (nonatomic, strong) UILabel     *changeLabel;
@property (nonatomic, strong) UIButton    *beginTimeBtn;
@property (nonatomic, strong) UIButton    *endTimeBtn;
//班级
@property (nonatomic, strong) UILabel     *classLabel;
@property (nonatomic, strong) UIButton    *classBtn;
//活动简介
@property (nonatomic, strong) UILabel     *introductionLabel;
@property (nonatomic, strong) WTextView  *introductionTextView;
//上传图片
@property (nonatomic, strong) UILabel     *uploadLabel;
@property (nonatomic, strong) UIButton    *uploadBtn;
//发送班级活动
@property (nonatomic, strong) UIButton    *releaseBtn;

@end

@implementation LaunchEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布活动";
    [self makeLaunchEventViewControllerUI];
}

- (void)makeLaunchEventViewControllerUI {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH - 20, 30)];
    self.titleLabel.textColor = titlColor;
    self.titleLabel.font = titFont;
    self.titleLabel.text = @"活动标题";
    [self.view addSubview:self.titleLabel];
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + 10, APP_WIDTH - 20, 40)];
    self.titleTextField.backgroundColor = [UIColor whiteColor];
    self.titleTextField.layer.masksToBounds = YES;
    self.titleTextField.layer.cornerRadius = 5;
    self.titleTextField.layer.borderColor = fengeLineColor.CGColor;
    self.titleTextField.layer.borderWidth = 1.0f;
    self.titleTextField.font = contentFont;
    self.titleTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入活动标题" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.titleTextField.delegate = self;
    self.titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.titleTextField];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + 20, APP_WIDTH - 20, 30)];
    self.timeLabel.textColor = titlColor;
    self.timeLabel.font = titFont;
    self.timeLabel.text = @"时间";
    [self.view addSubview:self.timeLabel];
    
    self.timeView = [[UIView alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + 20, APP_WIDTH - 20, 40)];
    self.timeView.backgroundColor = [UIColor whiteColor];
    self.timeView.layer.masksToBounds = YES;
    self.timeView.layer.cornerRadius = 5;
    self.timeView.layer.borderColor = fengeLineColor.CGColor;
    self.timeView.layer.borderWidth = 1.0f;
    [self.view addSubview:self.timeView];
    
    self.changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 40, 30)];
    self.changeLabel.text = @"请选择";
    self.changeLabel.textColor = backTitleColor;
    self.changeLabel.font = contentFont;
    [self.timeView addSubview:self.changeLabel];
    
    self.beginTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.changeLabel.frame.size.width + 15, 5, (self.timeView.frame.size.width - self.changeLabel.frame.size.width - 25) / 2, 30)];
    self.beginTimeBtn.layer.masksToBounds = YES;
    self.beginTimeBtn.layer.cornerRadius = 5;
    self.beginTimeBtn.layer.borderColor = fengeLineColor.CGColor;
    self.beginTimeBtn.layer.borderWidth = 1.0f;
    [self.beginTimeBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    self.beginTimeBtn.titleLabel.font = contentFont;
    [self.beginTimeBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
    [self.beginTimeBtn addTarget:self action:@selector(beginTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.timeView addSubview:self.beginTimeBtn];
    
    self.endTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.timeView.frame.size.width - self.beginTimeBtn.frame.size.width - 5, 5, self.beginTimeBtn.frame.size.width, 30)];
    self.endTimeBtn.layer.masksToBounds = YES;
    self.endTimeBtn.layer.cornerRadius = 5;
    self.endTimeBtn.layer.borderColor = fengeLineColor.CGColor;
    self.endTimeBtn.layer.borderWidth = 1.0f;
    [self.endTimeBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    self.endTimeBtn.titleLabel.font = contentFont;
    [self.endTimeBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
    [self.endTimeBtn addTarget:self action:@selector(endTimeBtnBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.timeView addSubview:self.endTimeBtn];
    
    self.classLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + 30, APP_WIDTH - 20, 30)];
    self.classLabel.text = @"班级";
    self.classLabel.textColor = titlColor;
    self.classLabel.font = contentFont;
    [self.view addSubview:self.classLabel];
    
    self.classBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + 30, APP_WIDTH - 20, 40)];
    self.classBtn.backgroundColor = [UIColor whiteColor];
    self.classBtn.layer.masksToBounds = YES;
    self.classBtn.layer.cornerRadius = 5;
    self.classBtn.layer.borderColor = fengeLineColor.CGColor;
    self.classBtn.layer.borderWidth = 1.0f;
    [self.classBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.classBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.classBtn.titleLabel.font = contentFont;
    [self.classBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
    [self.classBtn addTarget:self action:@selector(classBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.classBtn];
    
    self.introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + 40, APP_WIDTH - 20, 30)];
    self.introductionLabel.text = @"活动简介";
    self.introductionLabel.textColor = titlColor;
    self.introductionLabel.font = contentFont;
    [self.view addSubview:self.introductionLabel];
    
    self.introductionTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + self.introductionLabel.frame.size.height + 40, APP_WIDTH - 20, 100)];
    self.introductionTextView.backgroundColor = [UIColor whiteColor];
    self.introductionTextView.layer.masksToBounds = YES;
    self.introductionTextView.layer.cornerRadius = 5;
    self.introductionTextView.layer.borderColor = fengeLineColor.CGColor;
    self.introductionTextView.layer.borderWidth = 1.0f;
    self.introductionTextView.font = contentFont;
    self.introductionTextView.placeholder = @"请输入活动内容...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.introductionTextView];
    
    self.uploadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + self.introductionLabel.frame.size.height + self.introductionTextView.frame.size.height + 50, APP_WIDTH - 20, 30)];
    self.uploadLabel.text = @"上传活动宣传图";
    self.uploadLabel.textColor = titlColor;
    self.uploadLabel.font = contentFont;
    [self.view addSubview:self.uploadLabel];
    
    self.uploadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + self.introductionLabel.frame.size.height + self.introductionTextView.frame.size.height + self.uploadLabel.frame.size.height + 50, 80, 80)];
    [self.uploadBtn setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
    [self.uploadBtn addTarget:self action:@selector(uploadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadBtn];
    
    self.releaseBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.titleLabel.frame.size.height + self.titleTextField.frame.size.height + self.timeLabel.frame.size.height + self.timeView.frame.size.height + self.classLabel.frame.size.height + self.classBtn.frame.size.height + self.introductionLabel.frame.size.height + self.introductionTextView.frame.size.height + self.uploadLabel.frame.size.height + self.uploadBtn.frame.size.height + 70, APP_WIDTH - 40, 40)];
    self.releaseBtn.backgroundColor = THEMECOLOR;
    [self.releaseBtn setTitle:@"发布班级活动" forState:UIControlStateNormal];
    self.releaseBtn.layer.masksToBounds = YES;
    self.releaseBtn.layer.cornerRadius = 5;
    self.releaseBtn.layer.borderColor = fengeLineColor.CGColor;
    self.releaseBtn.layer.borderWidth = 1.0f;
    self.releaseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.releaseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.releaseBtn addTarget:self action:@selector(releaseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.releaseBtn];
    
}

- (void)releaseBtn : (UIButton *)sender {
    NSLog(@"点击发布");
}

- (void)uploadBtn : (UIButton *)sender {
    NSLog(@"点击上传图片");
}

- (void)classBtn : (UIButton *)sender {
    NSLog(@"请选择");
}

- (void)endTimeBtnBtn : (UIButton *)sender {
    NSLog(@"点击结束时间");
}

- (void)beginTimeBtn : (UIButton *)sender {
    NSLog(@"点击开始时间");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
