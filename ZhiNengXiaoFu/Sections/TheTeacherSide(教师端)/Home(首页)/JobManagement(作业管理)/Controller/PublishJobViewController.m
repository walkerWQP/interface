//
//  PublishJobViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PublishJobViewController.h"

@interface PublishJobViewController ()<UITextFieldDelegate>

//科目
@property (nonatomic, strong) UILabel      *subjectsLabel;
@property (nonatomic, strong) UIButton     *subjectsBtn;
//作业名称
@property (nonatomic, strong) UILabel      *jobNameLabel;
@property (nonatomic, strong) UITextField  *jobNameTextField;
//作业内容
@property (nonatomic, strong) UILabel      *jobContentLabel;
@property (nonatomic, strong) WTextView   *jobContentTextView;
//上传图片内容
@property (nonatomic, strong) UILabel      *uploadPicturesLabel;
@property (nonatomic, strong) UIButton     *uploadPicturesBtn;

@end

@implementation PublishJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布作业";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self makePublishJobViewControllerUI];
    
}

- (void)makePublishJobViewControllerUI {
    
    self.subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH, 30)];
    self.subjectsLabel.text = @"科目";
    self.subjectsLabel.textColor =titlColor;
    self.subjectsLabel.font = titleFont;
    [self.view addSubview:self.subjectsLabel];
    
    self.subjectsBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + 10, APP_WIDTH - 20, 40)];
    self.subjectsBtn.backgroundColor = [UIColor whiteColor];
    [self.subjectsBtn setTitle:@"请选择科目类型" forState:UIControlStateNormal];
    self.subjectsBtn.layer.masksToBounds = YES;
    self.subjectsBtn.layer.cornerRadius = 5;
    self.subjectsBtn.layer.borderColor = fengeLineColor.CGColor;
    self.subjectsBtn.layer.borderWidth = 1.0f;
    self.subjectsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.subjectsBtn setTitleColor:backTitleColor forState:UIControlStateNormal];
    self.subjectsBtn.titleLabel.font = contentFont;
    [self.subjectsBtn addTarget:self action:@selector(subjectsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.subjectsBtn];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.subjectsBtn.frame.size.width - 30, 15, 10, 10)];
    imgView.image = [UIImage imageNamed:@"下拉"];
    [self.subjectsBtn addSubview:imgView];
    
    self.jobNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + 20, APP_WIDTH - 20, 30)];
    self.jobNameLabel.text = @"作业名称";
    self.jobNameLabel.textColor = titlColor;
    self.jobNameLabel.font = titleFont;
    [self.view addSubview:self.jobNameLabel];
    
    self.jobNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + 20, APP_WIDTH - 20, 40)];
    self.jobNameTextField.backgroundColor = [UIColor whiteColor];
    self.jobNameTextField.layer.masksToBounds = YES;
    self.jobNameTextField.layer.cornerRadius = 5;
    self.jobNameTextField.layer.borderColor = fengeLineColor.CGColor;
    self.jobNameTextField.layer.borderWidth = 1.0f;
    self.jobNameTextField.font = contentFont;
    self.jobNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入作业名称" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.jobNameTextField.delegate = self;
    self.jobNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.jobNameTextField];
    
    self.jobContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + self.jobNameTextField.frame.size.height + 30, APP_WIDTH - 20, 30)];
    self.jobContentLabel.text = @"作业内容";
    self.jobContentLabel.textColor = titlColor;
    self.jobContentLabel.font = titleFont;
    [self.view addSubview:self.jobContentLabel];
    
    self.jobContentTextView = [[WTextView alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + self.jobNameTextField.frame.size.height + self.jobContentLabel.frame.size.height + 30, APP_WIDTH - 20, APP_HEIGHT * 0.3)];
    self.jobContentTextView.backgroundColor = [UIColor whiteColor];
    self.jobContentTextView.layer.masksToBounds = YES;
    self.jobContentTextView.layer.cornerRadius = 5;
    self.jobContentTextView.layer.borderColor = fengeLineColor.CGColor;
    self.jobContentTextView.layer.borderWidth = 1.0f;
    self.jobContentTextView.font = contentFont;
    self.jobContentTextView.placeholder = @"请输入具体的作业...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.jobContentTextView];
    
    self.uploadPicturesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + self.jobNameTextField.frame.size.height + self.jobContentLabel.frame.size.height + self.jobContentTextView.frame.size.height + 40, APP_WIDTH - 20, 30)];
    self.uploadPicturesLabel.text = @"上传图片内容(最多只能上传三张)";
    self.uploadPicturesLabel.textColor = titlColor;
    self.uploadPicturesLabel.font = titleFont;
    [self.view addSubview:self.uploadPicturesLabel];
    
    self.uploadPicturesBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.subjectsLabel.frame.size.height + self.subjectsBtn.frame.size.height + self.jobNameLabel.frame.size.height + self.jobNameTextField.frame.size.height + self.jobContentLabel.frame.size.height + self.jobContentTextView.frame.size.height + self.uploadPicturesLabel.frame.size.height + 40, 80, 80)];
    [self.uploadPicturesBtn setImage:[UIImage imageNamed:@"添加图片"] forState:UIControlStateNormal];
    [self.uploadPicturesBtn addTarget:self action:@selector(uploadPicturesBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadPicturesBtn];
    
    
}

- (void)uploadPicturesBtn : (UIButton *)sender {
    NSLog(@"点击添加图片");
}

- (void)subjectsBtn : (UIButton *)sender {
    NSLog(@"点击科目类型");
}

- (void)rightBtn : (UIButton *)sender {
    
    NSLog(@"点击发布");
    
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
