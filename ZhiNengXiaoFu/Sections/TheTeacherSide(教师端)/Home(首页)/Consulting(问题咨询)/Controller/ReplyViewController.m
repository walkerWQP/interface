//
//  ReplyViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ReplyViewController.h"

@interface ReplyViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView        *bgView;
@property (nonatomic, strong) UIImageView   *headImgView;
@property (nonatomic, strong) UILabel       *problemLabel;
@property (nonatomic, strong) UILabel       *problemContentLabel;
@property (nonatomic, strong) UIView        *lineView;
@property (nonatomic, strong) UITextField   *replyTextField;
@property (nonatomic, strong) UIButton      *replyBtn;


@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表回复";
    [self makeReplyViewControllerUI];
    
}

- (void)makeReplyViewControllerUI {
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH - 20, APP_HEIGHT * 0.23)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
    self.headImgView.layer.masksToBounds = YES;
    self.headImgView.layer.cornerRadius = 30;
    self.headImgView.image = [UIImage imageNamed:@"user2"];
    [self.bgView addSubview:self.headImgView];
    
    self.problemLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.headImgView.frame.size.width, 10, self.bgView.frame.size.width - self.headImgView.frame.size.width - 30, 30)];
    self.problemLabel.textColor = titlColor;
    self.problemLabel.font = titFont;
    self.problemLabel.text = @"八一班黎明问:";
    [self.bgView addSubview:self.problemLabel];
    
    self.problemContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + self.headImgView.frame.size.height, self.bgView.frame.size.width - 20, 30)];
    self.problemContentLabel.textColor = titlColor;
    self.problemContentLabel.font = titFont;
    self.problemContentLabel.text = @"学校运动会是什么时候?";
    [self.bgView addSubview:self.problemContentLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10,self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + 20, self.bgView.frame.size.width - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.bgView addSubview:self.lineView];
    
    self.replyTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.headImgView.frame.size.height + self.problemContentLabel.frame.size.height + 30, self.bgView.frame.size.width - 20, 30)];
    self.replyTextField.backgroundColor = [UIColor whiteColor];
    self.replyTextField.layer.masksToBounds = YES;
    self.replyTextField.layer.cornerRadius = 5;
    self.replyTextField.layer.borderColor = fengeLineColor.CGColor;
    self.replyTextField.layer.borderWidth = 1.0f;
    self.replyTextField.font = contentFont;
    self.replyTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请回复" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.replyTextField.delegate = self;
    self.replyTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.bgView addSubview:self.replyTextField];
    
    self.replyBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.bgView.frame.size.height + 60, APP_WIDTH - 40, 40)];
    self.replyBtn.backgroundColor = THEMECOLOR;
    [self.replyBtn setTitle:@"提交回复" forState:UIControlStateNormal];
    self.replyBtn.layer.masksToBounds = YES;
    self.replyBtn.layer.cornerRadius = 5;
    self.replyBtn.layer.borderColor = fengeLineColor.CGColor;
    self.replyBtn.layer.borderWidth = 1.0f;
    self.replyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.replyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.replyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.replyBtn addTarget:self action:@selector(replyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.replyBtn];
    
}

- (void)replyBtn : (UIButton *)sender {
    NSLog(@"点击提交回复");  
    [self postDataForTeacherAnswerURL];
}

- (void)postDataForTeacherAnswerURL {
    if ([self.replyTextField.text isEqualToString:@""]) {
        [EasyShowTextView showImageText:@"回复不能为空" imageName:@"icon_sym_toast_failed_56_w100"];
        return;
    } else {
        NSDictionary * dic = @{@"key":[UserManager key], @"id":self.ID,@"answer":self.replyTextField.text};
        [[HttpRequestManager sharedSingleton] POST:teacherAnswerURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_succeed_56_w100"];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                    [UserManager logoOut];
                } else {
                    [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
