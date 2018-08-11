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
#import "LeaveListModel.h"
@interface LeaveListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * leaveListTableView;
@property (nonatomic, strong) NSMutableArray * leaveListAry;
@property (nonatomic, assign) NSInteger     page;

@end

@implementation LeaveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"请假列表";
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"请假" style:UIBarButtonItemStyleDone target:self action:@selector(rightButton:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];

    [self.view addSubview:self.leaveListTableView];
    [self.leaveListTableView registerClass:[LeaveListItemCell class] forCellReuseIdentifier:@"LeaveListItemCellId"];
    //下拉刷新
    self.leaveListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.leaveListTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.leaveListTableView.mj_header beginRefreshing];
    //上拉刷新
    self.leaveListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.leaveListAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}


- (void)setNetWork:(NSInteger)page
{
    NSDictionary * dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    
    [[HttpRequestManager sharedSingleton] POST:leaveLeaveList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        //结束头部刷新
        [self.leaveListTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.leaveListTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [LeaveListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (LeaveListModel *model in arr) {
                [self.leaveListAry addObject:model];
            }
            [self.leaveListTableView reloadData];
        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (UITableView *)leaveListTableView
{
    if (!_leaveListTableView) {
        self.leaveListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
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
        return self.leaveListAry.count;
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
        imgs.image = [UIImage imageNamed:@"banner"];
        [cell addSubview:imgs];
        return cell;
    }else
    {
        LeaveListItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveListItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        LeaveListModel * model = [self.leaveListAry objectAtIndex:indexPath.row];
        cell.LeaveTimeLabel.text = [NSString stringWithFormat:@"请假时间: %@ 至 %@", model.start, model.end];
        cell.LeaveReasonLabel.text = model.reason;
        if (model.status == 1) {
            cell.stateLabel.text = @"已批准";
            cell.stateLabel.textColor = COLOR(102, 205, 131, 1);
          
        }else
        {
            cell.stateLabel.text = @"审核中";
            cell.stateLabel.textColor = COLOR(252, 152, 152, 1);

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
    LeaveListModel * model = [self.leaveListAry objectAtIndex:indexPath.row];
    leaveDetailsVC.leaveDetailsId = model.ID;
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
