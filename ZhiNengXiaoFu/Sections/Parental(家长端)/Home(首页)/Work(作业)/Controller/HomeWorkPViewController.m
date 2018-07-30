//
//  HomeWorkPViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeWorkPViewController.h"
#import "JohnTopTitleView.h"
#import "TodayWorkViewController.h"
#import "HistoryWorkViewController.h"
@interface HomeWorkPViewController ()
@property (nonatomic,strong) JohnTopTitleView *titleView;

@end

@implementation HomeWorkPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245/255 green:245/255 blue:245/255 alpha:1.f];
    self.title = @"家庭作业";
    [self createUI];
}

- (void)createUI{
    NSArray *titleArray = [NSArray arrayWithObjects:@"今日作业",@"历史记录", nil];
    self.titleView.title = titleArray;
    [self.titleView setupViewControllerWithFatherVC:self childVC:[self setChildVC]];
    [self.view addSubview:self.titleView];
}

- (NSArray <UIViewController *>*)setChildVC{
    TodayWorkViewController * vc1 = [[TodayWorkViewController alloc]init];
    HistoryWorkViewController *vc2 = [[HistoryWorkViewController alloc]init];
    NSArray *childVC = [NSArray arrayWithObjects:vc1,vc2, nil];
    return childVC;
}

#pragma mark - getter
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
