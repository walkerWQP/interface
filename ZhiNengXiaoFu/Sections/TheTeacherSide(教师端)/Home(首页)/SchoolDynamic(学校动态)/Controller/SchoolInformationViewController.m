//
//  SchoolInformationViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolInformationViewController.h"

@interface SchoolInformationViewController ()

@property (nonatomic, strong) UIImageView *noDataImgView;

@end

@implementation SchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"学校动态详情";
    
    self.noDataImgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_WIDTH / 2 - 105 / 2, 200, 105, 111)];
    self.noDataImgView.image = [UIImage imageNamed:@"暂无数据家长端"];
//    self.noDataImgView.alpha = 0;

    [self.view addSubview:self.noDataImgView];
    
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
