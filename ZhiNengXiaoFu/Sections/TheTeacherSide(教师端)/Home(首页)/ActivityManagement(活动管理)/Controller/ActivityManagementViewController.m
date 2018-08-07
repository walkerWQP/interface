//
//  ActivityManagementViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ActivityManagementViewController.h"
#import "OngoingViewController.h"
#import "IsAboutToBeginViewController.h"
#import "TomorrowViewController.h"
#import "LaunchEventViewController.h"

@interface ActivityManagementViewController ()

@property (nonatomic,strong) JohnTopTitleView *titleView;

@end

@implementation ActivityManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动管理";
    [self makeActivityManagementViewControllerUI];
}

- (void)makeActivityManagementViewControllerUI {
    NSArray *titleArray = [NSArray arrayWithObjects:@"进行中",@"未开始", @"已结束",nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (NSArray <UIViewController *>*)setChildVC{
    //正在进行
    OngoingViewController *ongoingVC = [[OngoingViewController alloc]init];
    //即将开始
    IsAboutToBeginViewController *isAboutToBeginVC = [[IsAboutToBeginViewController alloc]init];
    //明日预告
    TomorrowViewController *tomorrowVC = [[TomorrowViewController alloc]init];
    
    NSArray *childVC = [NSArray arrayWithObjects:ongoingVC,isAboutToBeginVC,tomorrowVC, nil];
    return childVC;
}

- (JohnTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[JohnTopTitleView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _titleView;
}

- (void) rightBtn : (UIButton *)sender {
    
    NSLog(@"点击发布");
    LaunchEventViewController *launchEventVC = [[LaunchEventViewController alloc] init];
    [self.navigationController pushViewController:launchEventVC animated:YES];
}


@end
