//
//  WeiHuiFuViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "WeiHuiFuViewController.h"
#import "WeiHuiFuCell.h"
#import "ConsultListModel.h"
@interface WeiHuiFuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * WeiHuiFuTableView;
@property (nonatomic, strong) ConsultListModel * consultListModel;
@property (nonatomic, strong) NSMutableArray * WeiHuiFuAry;
@property (nonatomic, assign) NSInteger     page;

@end

@implementation WeiHuiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.WeiHuiFuTableView.delegate = self;
    self.WeiHuiFuTableView.dataSource = self;
    
    [self.view addSubview:self.WeiHuiFuTableView];
    self.WeiHuiFuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.WeiHuiFuTableView registerNib:[UINib nibWithNibName:@"WeiHuiFuCell" bundle:nil] forCellReuseIdentifier:@"WeiHuiFuCellId"];
    
    //下拉刷新
    self.WeiHuiFuTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.WeiHuiFuTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.WeiHuiFuTableView.mj_header beginRefreshing];
    //上拉刷新
    self.WeiHuiFuTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.WeiHuiFuAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}

- (NSMutableArray *)WeiHuiFuAry
{
    if (!_WeiHuiFuAry) {
        self.WeiHuiFuAry = [@[]mutableCopy];
    }
    return _WeiHuiFuAry;
}

- (void)setNetWork:(NSInteger)page
{
    NSDictionary * dic = @{@"key":[UserManager key], @"status":@0,@"page":[NSString stringWithFormat:@"%ld",page]};
    
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        //结束头部刷新
        [self.WeiHuiFuTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.WeiHuiFuTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (ConsultListModel *model in arr) {
                [self.WeiHuiFuAry addObject:model];
            }
            [self.WeiHuiFuTableView reloadData];
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
        NSLog(@"%@", error);
    }];
}

- (UITableView *)WeiHuiFuTableView
{
    if (!_WeiHuiFuTableView) {
        self.WeiHuiFuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.WeiHuiFuTableView.delegate = self;
        self.WeiHuiFuTableView.dataSource = self;
    }
    return _WeiHuiFuTableView;
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
    return self.WeiHuiFuAry.count;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiHuiFuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WeiHuiFuCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ConsultListModel * model = [self.WeiHuiFuAry objectAtIndex:indexPath.row];
    [cell.WeiHuiFuUserIconImg sd_setImageWithURL:[NSURL URLWithString:model.s_headimg] placeholderImage:nil];
    cell.WeiHuiFuNameLabel.text = [NSString stringWithFormat:@"%@%@问:", model.class_name ,model.student_name];
    cell.WeiHuiFuQuestionLabel.text = model.question;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
    
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
