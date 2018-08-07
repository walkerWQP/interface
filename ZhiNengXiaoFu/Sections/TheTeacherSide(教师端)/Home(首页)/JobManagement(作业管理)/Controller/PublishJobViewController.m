//
//  PublishJobViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PublishJobViewController.h"
#import "PublishJobModel.h"

@interface PublishJobViewController ()<UITextFieldDelegate,HQPickerViewDelegate>

//科目
@property (nonatomic, strong) UILabel      *subjectsLabel;
@property (nonatomic, strong) UIButton     *subjectsBtn;
@property (nonatomic, strong) NSString     *subjectsStr;
//作业名称
@property (nonatomic, strong) UILabel      *jobNameLabel;
@property (nonatomic, strong) UITextField  *jobNameTextField;
//作业内容
@property (nonatomic, strong) UILabel      *jobContentLabel;
@property (nonatomic, strong) WTextView   *jobContentTextView;
//上传图片内容
@property (nonatomic, strong) UILabel      *uploadPicturesLabel;
@property (nonatomic, strong) UIButton     *uploadPicturesBtn;

@property (nonatomic, strong) NSMutableArray *publishJobArr;
@property (nonatomic, strong) NSString       *courseID;

@end

@implementation PublishJobViewController

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布作业";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self makePublishJobViewControllerUI];
    
}

- (void)makePublishJobViewControllerUI {
    
    self.subjectsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, APP_WIDTH, 30)];
    self.subjectsLabel.text = @"科目";
    self.subjectsLabel.textColor =titlColor;
    self.subjectsLabel.font = titFont;
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
    self.jobNameLabel.font = titFont;
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
    self.jobContentLabel.font = titFont;
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
    self.uploadPicturesLabel.font = titFont;
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
    [self getUserGetCourse];
    
    
}

- (void)rightBtn : (UIButton *)sender {
    
    NSLog(@"点击发布");
    [self PostWorkPusblishData];
    
}

- (void)PostWorkPusblishData {
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSLog(@"%@",self.subjectsBtn.titleLabel.text);
    if ([self.subjectsBtn.titleLabel.text isEqualToString:@"请选择科目类型"]) {
        [EasyShowTextView showImageText:@"请选择科目类型" imageName:@"icon_sym_toast_succeed_56_w100"];
        
        return;
    }
    
    if ([self.jobNameTextField.text isEqualToString:@""]) {
        [EasyShowTextView showImageText:@"请输入作业名称" imageName:@"icon_sym_toast_succeed_56_w100"];
        
        return;
    }
    
    if ([self.jobContentTextView.text isEqualToString:@""]) {
        [EasyShowTextView showImageText:@"请输入作业内容" imageName:@"icon_sym_toast_succeed_56_w100"];
        
        return;
    }
    
    NSDictionary *dic = @{@"key":key,@"class_id":self.classID,@"title":self.jobNameTextField.text,@"content":self.jobContentTextView.text,@"course_id":self.courseID,@"img":@""};
    [[HttpRequestManager sharedSingleton] POST:workPusblish parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (void)getUserGetCourse {
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary *dic = @{@"key":key};
    [[HttpRequestManager sharedSingleton] POST:userGetCourse parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            
            HQPickerView *picker = [[HQPickerView alloc]initWithFrame:self.view.bounds];
            picker.delegate = self ;
            picker.customArr = ary;
            [self.view addSubview:picker];
            
            if (self.publishJobArr.count == 0) {
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_failed_56_w100"];
            } else {
                
                
            }
            
            
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

- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text  index:(NSInteger)index{
    [self.subjectsBtn setTitle:text forState:UIControlStateNormal];
    PublishJobModel *model = [self.publishJobArr objectAtIndex:index];
    self.subjectsStr = model.ID;
    NSLog(@"%@",model.ID);
    NSLog(@"%@",self.subjectsStr);
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
