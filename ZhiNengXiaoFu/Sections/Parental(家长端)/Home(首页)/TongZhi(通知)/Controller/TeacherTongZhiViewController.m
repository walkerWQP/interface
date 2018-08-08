//
//  TeacherTongZhiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherTongZhiViewController.h"
#import "TeacherTongZhiCell.h"
#import "TongZhiCell.h"
#import "TongZhiDetailsViewController.h"
#import "TongZhiModel.h"
#import "CommonStatus.h"
@interface TeacherTongZhiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * teacherTongZhiTableView;
@property (nonatomic, strong) NSMutableArray * teacherTongZhiAry;
@property (nonatomic, strong) UIImageView * zanwushuju;
@property (nonatomic, assign) NSInteger     page;

@end

@implementation TeacherTongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.teacherTongZhiTableView];
    [self.teacherTongZhiTableView registerClass:[TongZhiCell class] forCellReuseIdentifier:@"TongZhiCellId"];
    self.teacherTongZhiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    //下拉刷新
    self.teacherTongZhiTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.teacherTongZhiTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.teacherTongZhiTableView.mj_header beginRefreshing];
    //上拉刷新
    self.teacherTongZhiTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.teacherTongZhiAry removeAllObjects];
    [self getNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getNetWork:self.page];
}

- (void)getNetWork:(NSInteger)page
{
    
    NSDictionary * dic = @{@"key":[UserManager key], @"is_school":@0,@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:JIAZHANGCHAKANTONGZHILIEBIAO parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        //结束头部刷新
        [self.teacherTongZhiTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.teacherTongZhiTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [TongZhiModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (TongZhiModel *model in arr) {
                [self.teacherTongZhiAry addObject:model];
            }
            if (self.teacherTongZhiAry.count == 0) {
                self.zanwushuju.alpha = 1;
                
            } else {
                self.zanwushuju.alpha = 0;
                [self.teacherTongZhiTableView reloadData];
            }
            [self.teacherTongZhiTableView reloadData];
        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_failed_56_w100"];

            }
        }
        
       
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSMutableArray *)teacherTongZhiAry
{
    if (!_teacherTongZhiAry) {
        self.teacherTongZhiAry = [@[]mutableCopy];
    }
    return _teacherTongZhiAry;
}

- (UITableView *)teacherTongZhiTableView
{
    if (!_teacherTongZhiTableView) {
        self.teacherTongZhiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.teacherTongZhiTableView.delegate = self;
        self.teacherTongZhiTableView.dataSource = self;
    }
    return _teacherTongZhiTableView;
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
    return self.teacherTongZhiAry.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiCellId" forIndexPath:indexPath];
    TongZhiModel * model = [self.teacherTongZhiAry objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.headImgView.image = [UIImage imageNamed:@"通知图标"];
    cell.titleLabel.text = model.title;
    cell.subjectsLabel.text = model.abstract;
    cell.timeLabel.text = model.create_time;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 80;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TongZhiDetailsViewController * tongZhiDetails  = [[TongZhiDetailsViewController alloc] init];
    TongZhiModel * model = [self.teacherTongZhiAry objectAtIndex:indexPath.row];
    tongZhiDetails.tongZhiId = model.ID;
    [self.navigationController pushViewController:tongZhiDetails animated:YES];
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
