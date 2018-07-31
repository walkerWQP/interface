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

@end

@implementation SignClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"九年级二班";
    [self makeSignClassViewControllerUI];
}

- (void)makeSignClassViewControllerUI {
    NSArray *titleArray = [NSArray arrayWithObjects:@"总数20",@"已到19",@"未到1",@"请假1",nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
}

- (NSArray <UIViewController *>*)setChildVC{
    //总数
    TotalNumberViewController *totalNumberVC = [[TotalNumberViewController alloc]init];
    //已到
    HasBeenViewController *hasBeenVC = [[HasBeenViewController alloc]init];
    //未到
    NotToViewController *notToVC = [[NotToViewController alloc]init];
    //请假
    AskLeaveViewController *askLeaveVC = [[AskLeaveViewController alloc]init];
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
