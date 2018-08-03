//
//  WenTiZiXunViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WenTiZiXunViewController.h"
#import "WenTiZiXunListCell.h"
#import "MyZiXunViewController.h"
@interface WenTiZiXunViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * WenTiZiXunTableView;

@end

@implementation WenTiZiXunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的咨询";
    
    self.WenTiZiXunTableView.delegate = self;
    self.WenTiZiXunTableView.dataSource = self;
    
    [self.view addSubview:self.WenTiZiXunTableView];
    self.WenTiZiXunTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.WenTiZiXunTableView registerClass:[WenTiZiXunListCell class] forCellReuseIdentifier:@"WenTiZiXunListCellId"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"咨询" style:UIBarButtonItemStyleDone target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (UITableView *)WenTiZiXunTableView
{
    if (!_WenTiZiXunTableView) {
        self.WenTiZiXunTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.WenTiZiXunTableView.delegate = self;
        self.WenTiZiXunTableView.dataSource = self;
    }
    return _WenTiZiXunTableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WenTiZiXunListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WenTiZiXunListCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.userIcon.image = [UIImage imageNamed:@"头像"];
        cell.userName.text = @"八一班李萌问:";
        cell.questionLabel.text = @"咱们这次运动会是什么时候啊?";
    }else
    {
        cell.userIcon.image = [UIImage imageNamed:@"头像"];
        cell.userName.text = @"八一班体育老师回复:";
        cell.questionLabel.text = @"2017.8.21 - 2018.8.23 共3天时间";
    }
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
    
}

- (void)rightButton:(UIBarButtonItem *)sender
{
    MyZiXunViewController * myZiXunVC = [[MyZiXunViewController alloc] init];
    [self.navigationController pushViewController:myZiXunVC animated:YES];
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
