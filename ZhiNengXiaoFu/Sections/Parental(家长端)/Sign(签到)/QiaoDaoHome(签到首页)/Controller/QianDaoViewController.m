//
//  QianDaoViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "QianDaoViewController.h"
#import "QianDaoPsersonCell.h"
#import "QianDaoItemCell.h"
@interface QianDaoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * QianDaoTableView;
@property (nonatomic, strong) NSMutableArray * QianDaoAry;
@end

@implementation QianDaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"进出安全";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:173/ 255.0 green:228 / 255.0 blue: 211 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"进校",@"出校",@"进校",@"出校",@"未知", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"星期四",@"星期四",@"星期四",@"星期四",@"星期四", nil];
    NSMutableArray * TimeAry = [NSMutableArray arrayWithObjects:@"2015-05-23",@"2015-05-23",@"2015-05-23",@"2015-05-23",@"2015-05-23", nil];

    
    for (int i = 0; i < imgAry.count; i++) {
        NSString * img  = [imgAry objectAtIndex:i];
        NSString * title = [TitleAry objectAtIndex:i];
        NSString * time = [TimeAry objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title, @"time":time};
        [self.QianDaoAry addObject:dic];
    }
    
    [self.view addSubview:self.QianDaoTableView];
    
    
    
    [self.QianDaoTableView registerClass:[QianDaoPsersonCell class] forCellReuseIdentifier:@"QianDaoPsersonCellId"];
    [self.QianDaoTableView registerClass:[QianDaoItemCell class] forCellReuseIdentifier:@"QianDaoItemCellId"];

    self.QianDaoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)QianDaoAry
{
    if (!_QianDaoAry) {
        self.QianDaoAry = [@[]mutableCopy];
    }
    return _QianDaoAry;
}


- (UITableView *)QianDaoTableView
{
    if (!_QianDaoTableView) {
        self.QianDaoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.QianDaoTableView.delegate = self;
        self.QianDaoTableView.dataSource = self;
    }
    return _QianDaoTableView;
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
        return self.QianDaoAry.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        QianDaoPsersonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QianDaoPsersonCellId" forIndexPath:indexPath];
        cell.itemLabel.text = @"小明";
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        QianDaoItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QianDaoItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary * dic = [self.QianDaoAry objectAtIndex:indexPath.row];
        cell.stateLabel.text = [dic objectForKey:@"img"];
        cell.timeLabel.text = [dic objectForKey:@"title"];
        cell.detailsTimeLabel.text = [dic objectForKey:@"time"];

        if ([[dic objectForKey:@"img"] isEqualToString:@"进校"]) {
            cell.stateLabel.backgroundColor = [UIColor colorWithRed:131 / 255.0 green:203 / 255.0 blue:176 / 255.0 alpha:1];
        }else if ([[dic objectForKey:@"img"] isEqualToString:@"出校"])
        {
            cell.stateLabel.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:214 / 255.0 blue:210 / 255.0 alpha:1];

        }else if ([[dic objectForKey:@"img"] isEqualToString:@"未知"])
        {
            cell.stateLabel.backgroundColor = [UIColor colorWithRed:37 / 255.0 green:147 / 255.0 blue:252 / 255.0 alpha:1];

        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 128;
    }else
    {
        return 60;
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
