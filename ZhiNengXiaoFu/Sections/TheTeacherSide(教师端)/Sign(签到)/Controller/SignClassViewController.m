//
//  SignClassViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SignClassViewController.h"
#import "AskLeaveViewController.h"
#import "NotToViewController.h"
#import "HasBeenViewController.h"
#import "TotalNumberViewController.h"

@interface SignClassViewController ()

@property (nonatomic,strong) JohnTopTitleView *titleView;
@property (nonatomic, strong) NSString        *allStr;
@property (nonatomic, strong) NSString        *signStr;
@property (nonatomic, strong) NSString        *no_signStr;
@property (nonatomic, strong) NSString        *leaveStr;

@end

@implementation SignClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"到校情况";
    [self getClassConditionURLData:@"1"];
}

- (void)getClassConditionURLData:(NSString *)type {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.ID,@"type":type};
    [[HttpRequestManager sharedSingleton] POST:classConditionURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.allStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"all"]];
            self.signStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"sign"]];
            self.no_signStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"no_sign"]];
            self.leaveStr = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"leave"]];
            [self makeSignClassViewControllerUI];
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)makeSignClassViewControllerUI {
    NSString  *str1 = [NSString stringWithFormat:@"%@%@",@"总数",self.allStr];
    NSString  *str2 = [NSString stringWithFormat:@"%@%@",@"已到",self.signStr];
    NSString  *str3 = [NSString stringWithFormat:@"%@%@",@"未到",self.no_signStr];
    NSString  *str4 = [NSString stringWithFormat:@"%@%@",@"请假",self.leaveStr];
    NSArray *titleArray = [NSArray arrayWithObjects:str1,str2,str3,str4,nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
}

- (NSArray <UIViewController *>*)setChildVC{
    //总数
    TotalNumberViewController *totalNumberVC = [[TotalNumberViewController alloc]init];
    totalNumberVC.ID = self.ID;
    //已到
    HasBeenViewController *hasBeenVC = [[HasBeenViewController alloc]init];
    hasBeenVC.ID = self.ID;
    //未到
    NotToViewController *notToVC = [[NotToViewController alloc]init];
    notToVC.ID = self.ID;
    //请假
    AskLeaveViewController *askLeaveVC = [[AskLeaveViewController alloc]init];
    askLeaveVC.ID = self.ID;
    NSArray *childVC = [NSArray arrayWithObjects:totalNumberVC,hasBeenVC,notToVC,askLeaveVC, nil];
    return childVC;
}

- (JohnTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _titleView;
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
