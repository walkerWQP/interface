//
//  HomeWorkPViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeWorkPViewController.h"
#import "TongZhiCell.h"
#import "WorkModel.h"
#import "WorkDetailsViewController.h"
@interface HomeWorkPViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * HomeWorkPTableView;
@property (nonatomic, strong) NSMutableArray * HomeWorkPAry;

@property (nonatomic, assign) NSInteger     page;
@property (nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) UIImageView *zanwushuju;


@end

@implementation HomeWorkPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"作业";
    self.page = 1;
    [self.view addSubview:self.HomeWorkPTableView];
    [self.HomeWorkPTableView registerClass:[TongZhiCell class] forCellReuseIdentifier:@"TongZhiCellId"];
    self.HomeWorkPTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //下拉刷新
    self.HomeWorkPTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.HomeWorkPTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.HomeWorkPTableView.mj_header beginRefreshing];
    //上拉刷新
    self.HomeWorkPTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.HomeWorkPTableView addSubview:self.zanwushuju];
    
    [self getBannersURLData];

}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"4"};
    NSLog(@"%@",[UserManager key]);
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
           
            [self.HomeWorkPTableView reloadData];

            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];

        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.HomeWorkPAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}

- (void)setNetWork:(NSInteger)page
{
    
    NSDictionary * dic = @{@"key":[UserManager key],@"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:workGetHomeWork parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.HomeWorkPTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.HomeWorkPTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [WorkModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            
            for (WorkModel *model in arr) {
                [self.HomeWorkPAry addObject:model];
            }
            
            if (self.HomeWorkPAry.count == 0) {
                self.zanwushuju.alpha = 1;
            } else {
                self.zanwushuju.alpha = 0;
            }
            [self.HomeWorkPTableView reloadData];

        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];

        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (NSMutableArray *)HomeWorkPAry
{
    if (!_HomeWorkPAry) {
        self.HomeWorkPAry = [@[]mutableCopy];
    }
    return _HomeWorkPAry;
}

- (UITableView *)HomeWorkPTableView
{
    if (!_HomeWorkPTableView) {
        self.HomeWorkPTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_TABH - 18) style:UITableViewStylePlain];
        self.HomeWorkPTableView.backgroundColor =backColor;

        self.HomeWorkPTableView.delegate = self;
        self.HomeWorkPTableView.dataSource = self;
        _HomeWorkPTableView.estimatedRowHeight = 0;
        _HomeWorkPTableView.estimatedSectionHeaderHeight = 0;
        _HomeWorkPTableView.estimatedSectionFooterHeight = 0;
    }
    return _HomeWorkPTableView;
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
    if (section == 0) {
        return 1;
    }else
    {
        return self.HomeWorkPAry.count;
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
        UIImageView * imgs = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 170)];
//        imgs.image = [UIImage imageNamed:@"banner"];
        
        if (self.bannerArr.count == 0) {
//            imgs.image = [UIImage imageNamed:@"教师端活动管理banner"];
        } else {
            BannerModel * model = [self.bannerArr objectAtIndex:0];
            [imgs sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"教师端活动管理banner"]];
        }
        [cell addSubview:imgs];
        return cell;
    }else
    {
        TongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiCellId" forIndexPath:indexPath];
        if (self.HomeWorkPAry.count != 0) {
            WorkModel * model = [self.HomeWorkPAry objectAtIndex:indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.headImgView.image = [UIImage imageNamed:@"通知图标"] ;
            cell.titleLabel.text = model.title;
            cell.subjectsLabel.text = model.course_name;
            cell.timeLabel.text = model.create_time;
        }
       
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }else
    {
         return 80;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        WorkDetailsViewController * workDetailsVC = [[WorkDetailsViewController alloc] init];
        if (self.HomeWorkPAry.count != 0) {
            WorkModel * model = [self.HomeWorkPAry objectAtIndex:indexPath.row];
            workDetailsVC.workId = model.ID;
        }
        [self.navigationController pushViewController:workDetailsVC animated:YES];
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
