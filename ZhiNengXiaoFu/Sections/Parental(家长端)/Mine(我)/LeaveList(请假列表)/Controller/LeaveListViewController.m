//
//  LeaveListViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveListViewController.h"
#import "LeaveListItemCell.h"
#import "LeaveRequestViewController.h"
#import "LeaveDetailsViewController.h"
@interface LeaveListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * leaveListTableView;
@property (nonatomic, strong) NSMutableArray * leaveListAry;

@end

@implementation LeaveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"请假列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"请假" style:UIBarButtonItemStyleDone target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
   

    
    NSMutableArray * timeAry = [NSMutableArray arrayWithObjects:@"请假时间: 2018-07-24 至 2018-07-25",@"请假时间: 2018-06-02 至 2018-06-03", nil];
    NSMutableArray * seasonAry = [NSMutableArray arrayWithObjects:@"测试",@"因脚伤去医院治疗", nil];
    NSMutableArray * stateAry = [NSMutableArray arrayWithObjects:@"1",@"3", nil];

    for (int i = 0; i < timeAry.count; i++) {
        NSString * time  = [timeAry objectAtIndex:i];
        NSString * season = [seasonAry objectAtIndex:i];
        NSString * state = [stateAry objectAtIndex:i];
        NSDictionary* dic = @{@"season":season, @"time":time, @"state":state};
        [self.leaveListAry addObject:dic];
    }
    
    [self.view addSubview:self.leaveListTableView];
    [self.leaveListTableView registerClass:[LeaveListItemCell class] forCellReuseIdentifier:@"LeaveListItemCellId"];
    
}

- (UITableView *)leaveListTableView
{
    if (!_leaveListTableView) {
        self.leaveListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.leaveListTableView.dataSource = self;
        self.leaveListTableView.delegate = self;
    }
    return _leaveListTableView;
}


- (NSMutableArray *)leaveListAry
{
    if (!_leaveListAry) {
        self.leaveListAry = [@[]mutableCopy];
    }
    return _leaveListAry;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"TableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }else{
            //删除cell中的子对象,刷新覆盖问题。
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView * imgs = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
        imgs.image = [UIImage imageNamed:@"homepagelunbo2"];
        [cell addSubview:imgs];
        return cell;
    }else
    {
        LeaveListItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveListItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSDictionary * dic = [self.leaveListAry objectAtIndex:indexPath.row];
        cell.LeaveTimeLabel.text = [dic objectForKey:@"time"];
        cell.LeaveReasonLabel.text = [dic objectForKey:@"season"];
        if ([[dic objectForKey:@"state"] isEqualToString:@"1"]) {
            cell.stateLabel.text = @"审核中";
            cell.stateLabel.textColor = COLOR(252, 152, 152, 1);
        }else if ([[dic objectForKey:@"state"] isEqualToString:@"3"])
        {
            cell.stateLabel.text = @"已批准";
            cell.stateLabel.textColor = COLOR(102, 205, 131, 1);

        }
        return cell;
    }
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
        return 170;
    }else
    {
        return 100;
    }
}

- (void)rightButton:(UIBarButtonItem *)sender
{
    LeaveRequestViewController * leaveRequestVC = [[LeaveRequestViewController alloc] init];
    [self.navigationController pushViewController:leaveRequestVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeaveDetailsViewController * leaveDetailsVC = [[LeaveDetailsViewController alloc] init];
    [self.navigationController pushViewController:leaveDetailsVC animated:YES];
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
