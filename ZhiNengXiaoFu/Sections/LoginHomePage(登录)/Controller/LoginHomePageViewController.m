//
//  LoginHomePageViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LoginHomePageViewController.h"
#import "PrefixHeader.pch"
#import "TotalTabBarController.h"
#import "PersonInformationModel.h"

@interface LoginHomePageViewController ()

//记住登录选择图片
@property (nonatomic, strong) UIButton * chooseBtn;
//教师选择图片
@property (nonatomic, strong) UIButton * teacherChooseBtn;
//家长选择图片
@property (nonatomic, strong) UIButton * parentChooseBtn;
//教师选中状态
@property (nonatomic, assign) NSInteger teacherChooseState;
//家长选中状态
@property (nonatomic, assign) NSInteger parentChooseState;
//记住登录状态
@property (nonatomic, assign) NSInteger jizhuLoginChooseState;
//用户名
@property (nonatomic, strong) UITextField * zhangHaoTextField;
//密码
@property (nonatomic, strong) UITextField * miMaTextfield;

@property (nonatomic, strong) PersonInformationModel * personInfoModel;
//游客登录
@property (nonatomic, strong) UIButton * youkeLogin;

@end

@implementation LoginHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";

    UIImageView * backImg  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    backImg.image = [UIImage imageNamed:@"背景"];
    [self.view addSubview:backImg];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(20, 40, APP_WIDTH - 40, 420)];
    backView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:255 / 255.0 blue:255 / 255.0 alpha:0.8];
    backView.layer.cornerRadius = 8;
    backView.layer.masksToBounds = YES;
    [self.view addSubview:backView];
    
    self.parentChooseState = 0;
    self.teacherChooseState = 1;
    
    
    //logo
    UIImageView * logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 43, backView.frame.origin.y + 20, 86, 63)];
    logoImg.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImg];
    
    //用户名的背景view
    UIView * userName = [[UIView alloc] initWithFrame:CGRectMake(40, logoImg.frame.origin.y + logoImg.frame.size.height + 50, self.view.frame.size.width - 80, 50)];
    userName.backgroundColor = [UIColor clearColor];
    userName.layer.cornerRadius = 2;
    userName.layer.masksToBounds = YES;
    userName.layer.borderColor = [UIColor colorWithRed:190 / 255.0 green:190  / 255.0 blue:190 / 255.0 alpha:1].CGColor;
    userName.layer.borderWidth = 1;
    [self.view addSubview:userName];

    //用户名输入框
    self.zhangHaoTextField = [[UITextField alloc] initWithFrame:CGRectMake(35, 0, backView.frame.size.width - 45, 50)];
    self.zhangHaoTextField.placeholder = @"用户名";
    [self.zhangHaoTextField setValue:COLOR(51, 51, 51, 0.8) forKeyPath:@"_placeholderLabel.textColor"];
    [self.zhangHaoTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [userName addSubview:self.zhangHaoTextField];
    
    //用户名图片
    UIImageView * userImg  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 15, 16)];
    userImg.image = [UIImage imageNamed:@"用户名"];
    [userName addSubview:userImg];
    
    //密码背景图
    UIView * passWordView = [[UIView alloc] initWithFrame:CGRectMake(40, userName.frame.origin.y + userName.frame.size.height + 25, self.view.frame.size.width - 80, 50)];
    passWordView.backgroundColor = [UIColor clearColor];
    passWordView.layer.cornerRadius = 2;
    passWordView.layer.masksToBounds = YES;
    passWordView.layer.borderColor = [UIColor colorWithRed:190 / 255.0 green:190  / 255.0 blue:190 / 255.0 alpha:1].CGColor;
    passWordView.layer.borderWidth = 1;
    [self.view addSubview:passWordView];
    
    //密码输入框
    self.miMaTextfield = [[UITextField alloc] initWithFrame:CGRectMake(35, 0, passWordView.frame.size.width - 45, 50)];
    self.miMaTextfield.placeholder = @"密码";
    [self.miMaTextfield setValue:COLOR(51, 51, 51, 0.8) forKeyPath:@"_placeholderLabel.textColor"];
    [self.miMaTextfield setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    [passWordView addSubview:self.miMaTextfield];
    
    //密码图片
    UIImageView * mimaImg  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 16, 15, 16)];
    mimaImg.image = [UIImage imageNamed:@"密码"];
    [passWordView addSubview:mimaImg];
    
    //记住登录选择图片
    self.chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, passWordView.frame.origin.y + passWordView.frame.size.height + 15, 15, 15)];
    [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [self.chooseBtn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchDown];
    self.chooseBtn.userInteractionEnabled = YES;
    [self.view addSubview:self.chooseBtn];
    
    //记住登录状态
    UILabel * jiZhuLoginState = [[UILabel alloc] initWithFrame:CGRectMake(self.chooseBtn.frame.size.width + self.chooseBtn.frame.origin.x + 5, self.chooseBtn.frame.origin.y, 80, 15)];
    jiZhuLoginState.text = @"记住登录状态";
    jiZhuLoginState.textColor = COLOR(51, 51, 51, 0.6);
    jiZhuLoginState.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:jiZhuLoginState];
    
    //家长
    UILabel * parentLabel = [[UILabel alloc] initWithFrame:CGRectMake(passWordView.frame.origin.x + passWordView.frame.size.width  - 28, self.chooseBtn.frame.origin.y, 28, 15)];
    parentLabel.textColor =  COLOR(40, 182, 22, 1);
    parentLabel.text = @"家长";
    parentLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:parentLabel];
    
    //家长选择
    self.parentChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(parentLabel.frame.origin.x - 20, self.chooseBtn.frame.origin.y, 15, 15)];
    [self.parentChooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    [self.parentChooseBtn addTarget:self action:@selector(parentChooseBtn:) forControlEvents:UIControlEventTouchDown];
    self.parentChooseBtn.userInteractionEnabled = YES;
    [self.view addSubview:self.parentChooseBtn];
    
    //教师
    UILabel * teacherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.parentChooseBtn.frame.origin.x - 28 - 15, self.chooseBtn.frame.origin.y, 28, 15)];
    teacherLabel.textColor =  COLOR(40, 182, 22, 1);
    teacherLabel.text = @"教师";
    teacherLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:teacherLabel];
    
    //教师选择
    self.teacherChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(teacherLabel.frame.origin.x - 20, self.chooseBtn.frame.origin.y, 15, 15)];
    [self.teacherChooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    [self.teacherChooseBtn addTarget:self action:@selector(teacherChooseBtn:) forControlEvents:UIControlEventTouchDown];
    self.teacherChooseBtn.userInteractionEnabled = YES;
    [self.view addSubview:self.teacherChooseBtn];
    
    //登录
    UIButton * loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, passWordView.frame.origin.y + passWordView.frame.size.height + 60, APP_WIDTH - 80, 50)];
    loginBtn.backgroundColor = COLOR(40, 182, 22, 1);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius  = 5;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    loginBtn.userInteractionEnabled = YES;
    [self.view addSubview:loginBtn];
    
    self.youkeLogin = [[UIButton alloc] initWithFrame:CGRectMake(APP_WIDTH  - 60 - 40, loginBtn.frame.origin.y + loginBtn.frame.size.height + 15, 60, 20)];
    [self.youkeLogin setTitle:@"游客登录" forState:UIControlStateNormal];
    self.youkeLogin.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.youkeLogin addTarget:self action:@selector(youkeLogin:) forControlEvents:UIControlEventTouchDown];
    
    [self.youkeLogin setTitleColor:COLOR(51, 51, 51, 0.6) forState:UIControlStateNormal];
    self.youkeLogin.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.youkeLogin];
    
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"shifouJizhuLogin"] isEqualToString:@"1"]) {
        
        self.zhangHaoTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserName"];
        self.miMaTextfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserMiMa"];
        self.jizhuLoginChooseState = 1;
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    }else
    {
        self.jizhuLoginChooseState = 0;
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    }
    
    
    NSLog(@"JPUSHServiceIsRegistrationID%@", [JPUSHService registrationID]);
}

//游客登录
- (void)youkeLogin:(UIButton *)sender
{
    if (self.teacherChooseState == 1 || self.parentChooseState == 1) {
        
        NSString * chooseLoginState = [[NSString alloc] init];
        
        if (self.teacherChooseState == 1) {
            chooseLoginState = @"2";
        }else if (self.parentChooseState == 1)
        {
            chooseLoginState = @"1";
        }
        
        
        NSDictionary * dic = @{@"identity":chooseLoginState};
        [WProgressHUD showHUDShowText:@"加载中..."];
        
        [[HttpRequestManager sharedSingleton] POST:indexVisitorLogin parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            [WProgressHUD hideAllHUDAnimated:YES];
            
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                
                 [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"youkeState"];
//                if (self.jizhuLoginChooseState == 1) {
                
//                    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"shifouJizhuLogin"];
//                    if (self.teacherChooseState == 1) {
//                        [[NSUserDefaults standardUserDefaults] setObject:self.zhangHaoTextField.text forKey:@"TeacherUserName"];
//                        [[NSUserDefaults standardUserDefaults] setObject:self.miMaTextfield.text forKey:@"TeacherUserMiMa"];
//                    }else if (self.parentChooseState == 1)
//                    {
//                        [[NSUserDefaults standardUserDefaults] setObject:self.zhangHaoTextField.text forKey:@"ParentUserName"];
//                        [[NSUserDefaults standardUserDefaults] setObject:self.miMaTextfield.text forKey:@"ParentUserMiMa"];
//                    }
                    
                    
                    
                    
//                }else
//                {
//
//                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"shifouJizhuLogin"];
//                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TeacherUserName"];
//                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TeacherUserMiMa"];
//                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ParentUserName"];
//                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ParentUserMiMa"];
//                }
                
                
                if (self.teacherChooseState == 1) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"chooseLoginState"];
                }else if (self.parentChooseState == 1)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"chooseLoginState"];
                }
                
                self.personInfoModel = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
                
                //存储学生和家长信息
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.personInfoModel];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:data forKey:@"personInfo"];
                //同步到本地
                [user synchronize];
                
              
                [[NSUserDefaults standardUserDefaults] setObject:self.personInfoModel.key forKey:@"key"];
                
                
                [SingletonHelper manager].personInfoModel = self.personInfoModel;
                TotalTabBarController * totalTabBarVC = [[TotalTabBarController alloc] init];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                //把自定义标签视图控制器totalTabBarVC 作为window的rootViewController(根视图控制器)
                
                [window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                
                window.rootViewController = totalTabBarVC;
                
                [self.zhangHaoTextField resignFirstResponder];
                [self.miMaTextfield resignFirstResponder];
                
                
                //                    [self pushJiGuangId];
                
                
            }else
            {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
            [WProgressHUD hideAllHUDAnimated:YES];
        }];
    }
    
}

//家长选择
- (void)parentChooseBtn:(UIButton *)sender
{
    self.parentChooseState = 1;
    self.teacherChooseState = 0;
    [self.parentChooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    [self.teacherChooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ParentUserName"] == nil) {
        self.zhangHaoTextField.text = @"";
        self.miMaTextfield.text = @"";
    }else
    {
         self.zhangHaoTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ParentUserName"];
        self.miMaTextfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ParentUserMiMa"];
    }

}

//教师选择
- (void)teacherChooseBtn:(UIButton *)sender
{
    self.teacherChooseState = 1;
    self.parentChooseState = 0;
    [self.teacherChooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
    [self.parentChooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserName"] == nil) {
        self.zhangHaoTextField.text = @"";
        self.miMaTextfield.text = @"";
    }else
    {
        self.zhangHaoTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserName"];
        self.miMaTextfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"TeacherUserMiMa"];
    }
}

- (void)chooseBtn:(UIButton *)sender
{
    if (self.jizhuLoginChooseState == 0)
    {
        
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
        self.jizhuLoginChooseState = 1;
      
    }else
    {
        [self.chooseBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形"] forState:UIControlStateNormal];
        self.jizhuLoginChooseState = 0;
        
    }
}

//登录
- (void)login:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (self.teacherChooseState == 1 || self.parentChooseState == 1) {
        
        NSString * chooseLoginState = [[NSString alloc] init];
        
        if (self.teacherChooseState == 1) {
            chooseLoginState = @"2";
        }else if (self.parentChooseState == 1)
        {
            chooseLoginState = @"1";
        }
        
        if ([self.zhangHaoTextField.text isEqualToString:@""] ) {
            [WProgressHUD showErrorAnimatedText:@"请输入用户名"];

        }else if ([self.miMaTextfield.text isEqualToString:@""])
        {
            [WProgressHUD showErrorAnimatedText:@"请输入密码"];

        }else
        {
        
            NSString * newstr = [Encryption MD5ForLower32Bate:@"iosduxiu2018"];
            NSString * passwordStr = [Encryption MD5ForLower32Bate:self.miMaTextfield.text];
            NSString * system = [[SingletonHelper manager] encode:@"ios"];

            NSDictionary * dic = @{@"usernum":self.zhangHaoTextField.text, @"password":passwordStr, @"identity":chooseLoginState, @"system":system, @"sign":newstr};
            [WProgressHUD showHUDShowText:@"加载中..."];

            [[HttpRequestManager sharedSingleton] POST:LOGIN parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                [WProgressHUD hideAllHUDAnimated:YES];

                if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"youkeState"];
                    if (self.jizhuLoginChooseState == 1) {
                     
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"shifouJizhuLogin"];
                        if (self.teacherChooseState == 1) {
                            [[NSUserDefaults standardUserDefaults] setObject:self.zhangHaoTextField.text forKey:@"TeacherUserName"];
                            [[NSUserDefaults standardUserDefaults] setObject:self.miMaTextfield.text forKey:@"TeacherUserMiMa"];
                        }else if (self.parentChooseState == 1)
                        {
                            [[NSUserDefaults standardUserDefaults] setObject:self.zhangHaoTextField.text forKey:@"ParentUserName"];
                            [[NSUserDefaults standardUserDefaults] setObject:self.miMaTextfield.text forKey:@"ParentUserMiMa"];
                        }
                        
                       
                      
                        
                    }else
                    {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"shifouJizhuLogin"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TeacherUserName"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TeacherUserMiMa"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ParentUserName"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ParentUserMiMa"];
                    }
                    
                    
                    if (self.teacherChooseState == 1) {
                        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"chooseLoginState"];
                    }else if (self.parentChooseState == 1)
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"chooseLoginState"];
                    }
                    
                    self.personInfoModel = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
                    
                    //存储学生和家长信息
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.personInfoModel];
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    [user setObject:data forKey:@"personInfo"];
                    //同步到本地
                    [user synchronize];
                    
                    NSString * keyDic = [NSString stringWithFormat:@"%ld:%@:%@:%@", self.personInfoModel.school_id, self.personInfoModel.ID, chooseLoginState, self.personInfoModel.token];
                    NSString * key = [[SingletonHelper manager] encode:keyDic];
                    [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"key"];
                  
                    
                    [SingletonHelper manager].personInfoModel = self.personInfoModel;
                    TotalTabBarController * totalTabBarVC = [[TotalTabBarController alloc] init];
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    //把自定义标签视图控制器totalTabBarVC 作为window的rootViewController(根视图控制器)
                    
                    [window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

                    
                    window.rootViewController = totalTabBarVC;
                    
                    [self.zhangHaoTextField resignFirstResponder];
                    [self.miMaTextfield resignFirstResponder];
                    
                    
//                    [self pushJiGuangId];


                }else
                {
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];

                }
               
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@", error);
                [WProgressHUD hideAllHUDAnimated:YES];
            }];
     }
        
        
       
    }
}

//- (void)pushJiGuangId
//{
//    if ([JPUSHService registrationID] == nil) {
//
//    }else
//    {
//
//        NSDictionary * dic = @{@"push_id":[JPUSHService registrationID], @"system":@"ios"};
//
//        [[HttpRequestManager sharedSingleton] POST:UserSavePushId parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@", responseObject);
//
//            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
//            }else
//            {
//                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
//                    [UserManager logoOut];
//                }else
//                {
//
//                }
//                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
//
//            }
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@", error);
//        }];
//    }
//
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

- (void)backItem:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
