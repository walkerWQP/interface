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

@property (nonatomic, assign) int page;
@end

@implementation HomeWorkPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"作业";
    
    [self setNetWork];
//    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"通知图标",@"通知图标",@"通知图标",@"通知图标", nil];
//    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"七年级通知",@"九年级通知",@"六年级通知",@"四年级八班通知", nil];
//    NSMutableArray *contentArr = [NSMutableArray arrayWithObjects:@"英语作业通知",@"英语",@"数学成绩查询",@"春游计划通知", nil];
//    NSMutableArray *timeArr       = [NSMutableArray arrayWithObjects:@"2018-09-01",@"2018-09-02",@"2018-09-03",@"2018-09-04", nil];
//    for (int i = 0; i < imgArr.count; i++) {
//        NSString *img     = [imgArr objectAtIndex:i];
//        NSString *title   = [titleArr objectAtIndex:i];
//        NSString *content = [contentArr objectAtIndex:i];
//        NSString *time    = [timeArr objectAtIndex:i];
//        NSDictionary *dic = @{@"img":img,@"title":title,@"content":content,@"time":time};
//        [self.HomeWorkPAry addObject:dic];
//    }
    
    [self.view addSubview:self.HomeWorkPTableView];
    [self.HomeWorkPTableView registerClass:[TongZhiCell class] forCellReuseIdentifier:@"TongZhiCellId"];
    self.HomeWorkPTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setNetWork
{
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary * dic = @{@"key":key};
    [[HttpRequestManager sharedSingleton] POST:workGetHomeWork parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.HomeWorkPAry = [WorkModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            [self.HomeWorkPTableView reloadData];
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
        self.HomeWorkPTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.HomeWorkPTableView.delegate = self;
        self.HomeWorkPTableView.dataSource = self;
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
        UIImageView * imgs = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
        imgs.image = [UIImage imageNamed:@"banner"];
        [cell addSubview:imgs];
        return cell;
    }else
    {
        TongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiCellId" forIndexPath:indexPath];
        WorkModel * model = [self.HomeWorkPAry objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.headImgView.image = [UIImage imageNamed:@"通知图标"] ;
        cell.titleLabel.text = model.title;
        cell.subjectsLabel.text = model.course_name;
        cell.timeLabel.text = model.create_time;
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
    WorkDetailsViewController * workDetailsVC = [[WorkDetailsViewController alloc] init];
    WorkModel * model = [self.HomeWorkPAry objectAtIndex:indexPath.row];
    workDetailsVC.workId = model.ID;
    [self.navigationController pushViewController:workDetailsVC animated:YES];
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
