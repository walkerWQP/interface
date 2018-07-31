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
@interface TeacherTongZhiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * teacherTongZhiTableView;
@property (nonatomic, strong) NSMutableArray * teacherTongZhiAry;

@end

@implementation TeacherTongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"老师通知";
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        [self.teacherTongZhiAry addObject:dic];
    }
    
    [self.view addSubview:self.teacherTongZhiTableView];
    [self.teacherTongZhiTableView registerClass:[TongZhiCell class] forCellReuseIdentifier:@"TongZhiCellId"];
    self.teacherTongZhiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

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
    return 3;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiCellId" forIndexPath:indexPath];
    NSDictionary * dic = [self.teacherTongZhiAry objectAtIndex:indexPath.row];
    
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
