//
//  LeaveDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveDetailsViewController.h"
#import "LeaveDetailsHeaderCell.h"
#import "LeaveDetailsDownCell.h"
@interface LeaveDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * leaveDetailsTableView;
@end

@implementation LeaveDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"请假详情";
    self.view.backgroundColor = COLOR(246, 246, 246, 1);
    self.leaveDetailsTableView.dataSource = self;
    self.leaveDetailsTableView.delegate = self;
    
   
    self.leaveDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.leaveDetailsTableView];
    [self.leaveDetailsTableView registerClass:[LeaveDetailsHeaderCell class] forCellReuseIdentifier:@"LeaveDetailsHeaderCellId"];
    [self.leaveDetailsTableView registerNib:[UINib nibWithNibName:@"LeaveDetailsDownCell" bundle:nil] forCellReuseIdentifier:@"LeaveDetailsDownCellId"];
}

- (UITableView *)leaveDetailsTableView
{
    if (!_leaveDetailsTableView) {
        self.leaveDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.leaveDetailsTableView.dataSource = self;
        self.leaveDetailsTableView.delegate = self;
    }
    return _leaveDetailsTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LeaveDetailsHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveDetailsHeaderCellId" forIndexPath:indexPath];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.StartLabel.text = @"2018-07-23";
        cell.EndLabel.text = @"2018-07-25";

        return cell;
    }else
    {
        LeaveDetailsDownCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveDetailsDownCellId" forIndexPath:indexPath];
        return cell;
    }
}

-(void)viewWillAippear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //去除导航栏下方的横线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                  forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 210;
    }else
    {
        return 410;
    }
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
