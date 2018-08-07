//
//  ClassNoticeViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/3.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassNoticeViewController.h"

@interface ClassNoticeViewController ()<UITextFieldDelegate>

//通知名称
@property (nonatomic, strong) UILabel      *noticeNameLabel;
@property (nonatomic, strong) UITextField  *noticeNameTextField;
//通知内容内容
@property (nonatomic, strong) UILabel      *noticeContentLabel;
@property (nonatomic, strong) WTextView   *noticeContentTextView;
//上传图片内容
@property (nonatomic, strong) UILabel      *uploadPicturesLabel;
@property (nonatomic, strong) UIButton     *uploadPicturesBtn;

@end

@implementation ClassNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布通知";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self makeClassNoticeViewControllerUI];
}

- (void)makeClassNoticeViewControllerUI {
    self.noticeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH, 30)];
    self.noticeNameLabel.text = @"通知名称";
    self.noticeNameLabel.textColor =titlColor;
    self.noticeNameLabel.font = titFont;
    [self.view addSubview:self.noticeNameLabel];
    
    self.noticeNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + 10, APP_WIDTH - 20, 40)];
    self.noticeNameTextField.backgroundColor = [UIColor whiteColor];
    self.noticeNameTextField.layer.masksToBounds = YES;
    self.noticeNameTextField.layer.cornerRadius = 5;
    self.noticeNameTextField.layer.borderColor = fengeLineColor.CGColor;
    self.noticeNameTextField.layer.borderWidth = 1.0f;
    self.noticeNameTextField.font = contentFont;
    self.noticeNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入通知分类" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.noticeNameTextField.delegate = self;
    self.noticeNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.noticeNameTextField];

    
    self.noticeContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + self.noticeNameTextField.frame.size.height + 30, APP_WIDTH - 20, 30)];
    self.noticeContentLabel.text = @"通知内容";
    self.noticeContentLabel.textColor = titlColor;
    self.noticeContentLabel.font = titFont;
    [self.view addSubview:self.noticeContentLabel];
    
    self.noticeContentTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + self.noticeNameTextField.frame.size.height + self.noticeContentLabel.frame.size.height + 30, APP_WIDTH - 20, APP_HEIGHT * 0.3)];
    self.noticeContentTextView.backgroundColor = [UIColor whiteColor];
    self.noticeContentTextView.layer.masksToBounds = YES;
    self.noticeContentTextView.layer.cornerRadius = 5;
    self.noticeContentTextView.layer.borderColor = fengeLineColor.CGColor;
    self.noticeContentTextView.layer.borderWidth = 1.0f;
    self.noticeContentTextView.font = contentFont;
    self.noticeContentTextView.placeholder = @"请输入通知内容...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.noticeContentTextView];
    
    self.uploadPicturesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + self.noticeNameTextField.frame.size.height + self.noticeContentLabel.frame.size.height + self.noticeContentTextView.frame.size.height + 40, APP_WIDTH - 20, 30)];
    self.uploadPicturesLabel.text = @"上传图片内容(最多只能上传三张)";
    self.uploadPicturesLabel.textColor = titlColor;
    self.uploadPicturesLabel.font = titFont;
    [self.view addSubview:self.uploadPicturesLabel];
    
    self.uploadPicturesBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.noticeNameLabel.frame.size.height + self.noticeNameTextField.frame.size.height + self.noticeContentLabel.frame.size.height + self.noticeContentTextView.frame.size.height + self.uploadPicturesLabel.frame.size.height + 40, 80, 80)];
    [self.uploadPicturesBtn setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
    [self.uploadPicturesBtn addTarget:self action:@selector(uploadPicturesBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadPicturesBtn];
}

- (void)rightBtn : (UIButton *)sender {
    NSLog(@"发送通知");
    NSLog(@"%@",self.classID);
    NSLog(@"a    %@",self.noticeNameTextField.text);
    NSLog(@"b    %@",self.noticeContentTextView.text);
    
    if ([self.noticeNameTextField.text isEqualToString:@""]) {
        NSLog(@"请输入通知分类");
        [EasyShowTextView showImageText:@"通知分类不能为空" imageName:@"icon_sym_toast_failed_56_w100"];
        return;
    }
    
    if ([self.noticeContentTextView.text isEqualToString:@""]) {
        NSLog(@"请输入通知内容");
        [EasyShowTextView showImageText:@"通知内容不能为空" imageName:@"icon_sym_toast_failed_56_w100"];
        return;
    } else {
        NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
        NSDictionary *dic = @{@"key":key,@"class_id":self.classID,@"title":self.noticeNameTextField.text,@"content":self.noticeContentTextView.text,@"img":@""};
        [[HttpRequestManager sharedSingleton] POST:publishURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_succeed_56_w100"];
                
            } else {
                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                    [UserManager logoOut];
                } else {
                    [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_failed_56_w100"];
                    
                }
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }

}

- (void)uploadPicturesBtn : (UIButton *)sender {
    NSLog(@"点击添加图片");
}

@end
