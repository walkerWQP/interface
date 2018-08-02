//
//  TongZhiDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TongZhiDetailsViewController.h"
#import "TongZhiDetailsCell.h"
#import "TongZhiDetailsModel.h"
@interface TongZhiDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tongZhiDetailsTableView;
@property (nonatomic, strong) TongZhiDetailsModel * tongZhiDetailsModel;
@end

@implementation TongZhiDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通知详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNetWork];
    [self.view addSubview:self.tongZhiDetailsTableView];
    
    [self.tongZhiDetailsTableView registerNib:[UINib nibWithNibName:@"TongZhiDetailsCell" bundle:nil] forCellReuseIdentifier:@"TongZhiDetailsCellId"];
    
}

- (UITableView *)tongZhiDetailsTableView
{
    if (!_tongZhiDetailsTableView) {
        self.tongZhiDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.tongZhiDetailsTableView.delegate = self;
        self.tongZhiDetailsTableView.dataSource = self;
    }
    return _tongZhiDetailsTableView;
}

- (void)setNetWork
{
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary * dic = @{@"key":key, @"id":self.tongZhiId};
    [[HttpRequestManager sharedSingleton] POST:JIAOSHIJIAZHANGCHAKANXIANGQING parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        self.tongZhiDetailsModel = [TongZhiDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self.tongZhiDetailsTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
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
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TongZhiDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiDetailsCellId" forIndexPath:indexPath];
    cell.TongZhiDetailsTitleLabel.text = self.tongZhiDetailsModel.title;
    cell.TongZhiDetailsConnectLabel.text = self.tongZhiDetailsModel.content;
    cell.TongZhiDetailsTimeLabel.text = self.tongZhiDetailsModel.create_time;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
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
