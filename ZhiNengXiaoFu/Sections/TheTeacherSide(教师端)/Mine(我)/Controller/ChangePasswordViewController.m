//
//  ChangePasswordViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView   *oldPasswordImgView;
@property (nonatomic, strong) UITextField   *oldPasswordText;
@property (nonatomic, strong) UIImageView   *ImgView;
@property (nonatomic, strong) UITextField   *passwordText;
@property (nonatomic, strong) UIImageView   *ImgView1;
@property (nonatomic, strong) UITextField   *againText;

@property (nonatomic, strong) UIButton      *submitBtn;

@property (nonatomic, strong) UIView        *lineView;
@property (nonatomic, strong) UIView        *lineView1;
@property (nonatomic, strong) UIView        *lineView2;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self makeChangePasswordViewControllerUI];
}

- (void)makeChangePasswordViewControllerUI {
    
    self.oldPasswordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 105, 20, 20)];
    self.oldPasswordImgView.image = [UIImage imageNamed:@"密码"];
    [self.view addSubview:self.oldPasswordImgView];
    
    self.oldPasswordText = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, APP_WIDTH - 60, 30)];
    self.oldPasswordText.font = titFont;
    self.oldPasswordText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入旧密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.oldPasswordText.delegate = self;
    self.oldPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.oldPasswordText];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + 105, APP_WIDTH - 40, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.view addSubview:self.lineView];
    
    self.ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + 125, 20, 20)];
    self.ImgView.image = [UIImage imageNamed:@"密码"];
    [self.view addSubview:self.ImgView];
    
    self.passwordText = [[UITextField alloc] initWithFrame:CGRectMake(50, self.oldPasswordText.frame.size.height + 120, self.oldPasswordText.frame.size.width, 30)];
    self.passwordText.font = titFont;
    self.passwordText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入新密码(6-18位字符)" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.passwordText.delegate = self;
    self.passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordText];
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + 125, APP_WIDTH - 40, 1)];
    self.lineView1.backgroundColor = fengeLineColor;
    [self.view addSubview:self.lineView1];
    
    self.ImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + 145, 20, 20)];
    self.ImgView1.image = [UIImage imageNamed:@"密码"];
    [self.view addSubview:self.ImgView1];
    
    self.againText = [[UITextField alloc] initWithFrame:CGRectMake(50, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + 140, APP_WIDTH - 60, 30)];
    self.againText.font = titFont;
    self.againText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"确认新密码(6-18位字符)" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.againText.delegate = self;
    self.againText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.againText];
    
    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + self.againText.frame.size.height + 145, APP_WIDTH - 40, 1)];
    self.lineView2.backgroundColor = fengeLineColor;
    [self.view addSubview:self.lineView2];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, self.oldPasswordText.frame.size.height + self.passwordText.frame.size.height + self.againText.frame.size.height + 185, APP_WIDTH - 80, 40)];
    self.submitBtn.backgroundColor = THEMECOLOR;
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.layer.borderColor = fengeLineColor.CGColor;
    self.submitBtn.layer.borderWidth = 1.0f;
    self.submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.submitBtn addTarget:self action:@selector(submitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];

}

- (void)submitBtn : (UIButton *)sender {
    NSLog(@"提交");
}

@end
