//
//  AdviceFeedbackViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "AdviceFeedbackViewController.h"

@interface AdviceFeedbackViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField   *themeTextField;
@property (nonatomic, strong) WTextView     *contentTextView;
@property (nonatomic, strong) UIButton    *submitBtn;

@end

@implementation AdviceFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"建议与反馈";
    [self makeAdviceFeedbackViewControllerUI];
}

- (void)makeAdviceFeedbackViewControllerUI {
    
    self.themeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, APP_WIDTH - 40, 40)];
    self.themeTextField.backgroundColor = [UIColor whiteColor];
    self.themeTextField.font = contentFont;
    self.themeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"主题" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.themeTextField.delegate = self;
    self.themeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.themeTextField];
    
    self.contentTextView = [[WTextView alloc] initWithFrame:CGRectMake(20, self.themeTextField.frame.size.height + 40, APP_WIDTH - 40, APP_HEIGHT * 0.3)];
    self.contentTextView.backgroundColor = [UIColor whiteColor];
//    self.contentTextView.layer.masksToBounds = YES;
//    self.contentTextView.layer.cornerRadius = 5;
//    self.contentTextView.layer.borderColor = fengeLineColor.CGColor;
//    self.contentTextView.layer.borderWidth = 1.0f;
    self.contentTextView.font = contentFont;
    self.contentTextView.placeholder = @"请输入活动内容...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.contentTextView];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, self.themeTextField.frame.size.height + self.contentTextView.frame.size.height + 80, APP_WIDTH - 80, 40)];
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
    NSLog(@"点击提交");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
