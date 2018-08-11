//
//  HomeWorkViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeWorkViewController.h"
#import "TongZhiCell.h"
#import "HomeWorkModel.h"
#import "PublishJobViewController.h"
#import "WorkDetailsViewController.h"

@interface HomeWorkViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * homeWorkTableView;
@property (nonatomic, strong) NSMutableArray * homeWorkArr;
@property (nonatomic, strong) UIImageView *zanwushuju;
@property (nonatomic, assign) NSInteger   page;

@end

@implementation HomeWorkViewController

- (NSMutableArray *)homeWorkArr {
    if (!_homeWorkArr) {
        _homeWorkArr = [NSMutableArray array];
    }
    return _homeWorkArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    self.page = 1;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
  
    [self.view addSubview:self.homeWorkTableView];
    [self.homeWorkTableView registerClass:[TongZhiCell class] forCellReuseIdentifier:@"TongZhiCellId"];
    self.homeWorkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //下拉刷新
    self.homeWorkTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.homeWorkTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.homeWorkTableView.mj_header beginRefreshing];
    //上拉刷新
    self.homeWorkTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.self.homeWorkTableView addSubview:self.zanwushuju];
    
}

- (void)loadNewTopic {
    self.page = 1;
    [self.homeWorkArr removeAllObjects];
    [self getWorkHomeWorkListData:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self getWorkHomeWorkListData:self.page];
}

//删除作业
- (void)WorkDeleteHomeWorkData:(NSString *)workID {
    NSDictionary *dic = @{@"key":[UserManager key],@"id":workID};
    [[HttpRequestManager sharedSingleton] POST:workDeleteHomeWork parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            
            [self.homeWorkArr removeAllObjects];
            [self getWorkHomeWorkListData:1];
            
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)getWorkHomeWorkListData:(NSInteger)page {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":self.ID,@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:workHomeWorkList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.homeWorkTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.homeWorkTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            NSMutableArray *arr = [HomeWorkModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (HomeWorkModel *model in arr) {
                [self.homeWorkArr addObject:model];
            }
            if (self.homeWorkArr.count == 0) {
                self.zanwushuju.alpha = 1;
                [self.homeWorkTableView reloadData];
            } else {
                self.zanwushuju.alpha = 0;
                [self.homeWorkTableView reloadData];
            }
            
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (UITableView *)homeWorkTableView
{
    if (!_homeWorkTableView) {
        self.homeWorkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.homeWorkTableView.delegate = self;
        self.homeWorkTableView.dataSource = self;
    }
    return _homeWorkTableView;
}

//侧滑允许编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//执行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"删除删除删除删除删除删除删除删除删除");
    HomeWorkModel * model = [self.homeWorkArr objectAtIndex:indexPath.row];
    [self WorkDeleteHomeWorkData:model.ID];
    
}
//侧滑出现的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.homeWorkArr.count;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"TableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        } else {
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
    } else {
        TongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiCellId" forIndexPath:indexPath];
        HomeWorkModel * model = [self.homeWorkArr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headImgView.image = [UIImage imageNamed:@"通知图标"] ;
        cell.titleLabel.text = model.title;
        cell.subjectsLabel.text = model.course_name;
        cell.timeLabel.text = model.create_time;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 170;
    } else {
        return 80;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkDetailsViewController * workDetailsVC = [[WorkDetailsViewController alloc] init];
    HomeWorkModel *model = [self.homeWorkArr objectAtIndex:indexPath.row];
    workDetailsVC.workId = model.ID;
    [self.navigationController pushViewController:workDetailsVC animated:YES];
}

- (void)rightBtn:(UIButton *)sender {
    
    NSLog(@"点击发布通知");
    PublishJobViewController *publishJobVC = [[PublishJobViewController alloc] init];
    if (self.ID == nil) {
        [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
    } else {
        publishJobVC.classID = self.ID;
        [self.navigationController pushViewController:publishJobVC animated:YES];
    }
}

@end
