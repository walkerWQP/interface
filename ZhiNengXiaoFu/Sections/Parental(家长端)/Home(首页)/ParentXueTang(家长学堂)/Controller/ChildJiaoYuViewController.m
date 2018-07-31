//
//  ChildJiaoYuViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ChildJiaoYuViewController.h"
#import "ParentXueTangCell.h"
@interface ChildJiaoYuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * ChildJiaoYuTableView;


@end

@implementation ChildJiaoYuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ChildJiaoYuTableView.delegate = self;
    self.ChildJiaoYuTableView.dataSource = self;
    
    [self.view addSubview:self.ChildJiaoYuTableView];
    self.ChildJiaoYuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.ChildJiaoYuTableView registerClass:[ParentXueTangCell class] forCellReuseIdentifier:@"ParentXueTangCellId"];
}

- (UITableView *)ChildJiaoYuTableView
{
    if (!_ChildJiaoYuTableView) {
        self.ChildJiaoYuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.ChildJiaoYuTableView.delegate = self;
        self.ChildJiaoYuTableView.dataSource = self;
    }
    return _ChildJiaoYuTableView;
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
    return 2;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ParentXueTangCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ParentXueTangCellId" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = @"万有引力(物理一轮复习)";
    cell.liulanLabel.text = @"520人已看";
    cell.jiShuLabel.text = @"第一集";
    cell.biaoQianOneImg.image = [UIImage imageNamed:@"长的"];
    cell.biaoQianTwoImg.image = [UIImage imageNamed:@"长的"];

    cell.biaoQianOneLabel.text = @"方程式";
    cell.biaoQianTwoLabel.text = @"方程式";

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
    
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
