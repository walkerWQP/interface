//
//  SchoolTongZhiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolTongZhiViewController.h"
#import "TeacherTongZhiCell.h"
#import "TongZhiCell.h"
#import "TongZhiDetailsViewController.h"
@interface SchoolTongZhiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * schoolTongZhiAry;
@property (nonatomic, strong) UITableView * schoolTongZhiTableView;

@end

@implementation SchoolTongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学校通知";
    
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"通知图标",@"通知图标",@"通知图标",@"通知图标", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"七年级通知",@"九年级通知",@"六年级通知",@"四年级八班通知", nil];
    NSMutableArray *contentArr = [NSMutableArray arrayWithObjects:@"英语作业通知",@"英语",@"数学成绩查询",@"春游计划通知", nil];
    NSMutableArray *timeArr       = [NSMutableArray arrayWithObjects:@"2018-09-01",@"2018-09-02",@"2018-09-03",@"2018-09-04", nil];
    for (int i = 0; i < imgArr.count; i++) {
        NSString *img     = [imgArr objectAtIndex:i];
        NSString *title   = [titleArr objectAtIndex:i];
        NSString *content = [contentArr objectAtIndex:i];
        NSString *time    = [timeArr objectAtIndex:i];
        NSDictionary *dic = @{@"img":img,@"title":title,@"content":content,@"time":time};
        [self.schoolTongZhiAry addObject:dic];
    }
    
    [self.view addSubview:self.schoolTongZhiTableView];
    [self.schoolTongZhiTableView registerClass:[TongZhiCell class] forCellReuseIdentifier:@"TongZhiCellId"];
    self.schoolTongZhiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)schoolTongZhiAry
{
    if (!_schoolTongZhiAry) {
        self.schoolTongZhiAry = [@[]mutableCopy];
    }
    return _schoolTongZhiAry;
}



- (UITableView *)schoolTongZhiTableView
{
    if (!_schoolTongZhiTableView) {
        self.schoolTongZhiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.schoolTongZhiTableView.delegate = self;
        self.schoolTongZhiTableView.dataSource = self;
    }
    return _schoolTongZhiTableView;
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
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiCellId" forIndexPath:indexPath];
    NSDictionary * dic = [self.schoolTongZhiAry objectAtIndex:indexPath.row];
  
    cell.headImgView.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    cell.subjectsLabel.text = [dic objectForKey:@"content"];
    cell.timeLabel.text = [dic objectForKey:@"time"];
    
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TongZhiDetailsViewController * tongZhiDetails  = [[TongZhiDetailsViewController alloc] init];
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
