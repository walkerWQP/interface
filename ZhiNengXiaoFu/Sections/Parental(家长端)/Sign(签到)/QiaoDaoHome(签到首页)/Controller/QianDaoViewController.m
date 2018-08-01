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
#import "DingWeiViewController.h"
@interface QianDaoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * QianDaoTableView;
@property (nonatomic, strong) NSMutableArray * QianDaoAry;
@property (nonatomic, strong) UIView * backView;
@end

@implementation QianDaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dingwei"] style:UIBarButtonItemStyleDone target:self action:@selector(dingweiClick:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"进出安全";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:173/ 255.0 green:228 / 255.0 blue: 211 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"进校",@"出校",@"进校",@"出校", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"星期四",@"星期四",@"星期四",@"星期四", nil];
    NSMutableArray * TimeAry = [NSMutableArray arrayWithObjects:@"2015-05-23 11:22:00",@"2015-05-23 11:22:00",@"2015-05-23 11:22:00",@"2015-05-23 11:22:00", nil];

    
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

        if (indexPath.row == 0) {
            cell.yuanImg.image = [UIImage imageNamed:@"椭圆5"];
        }else
        {
            cell.yuanImg.image = [UIImage imageNamed:@"椭圆5"];

        }
        if ([[dic objectForKey:@"img"] isEqualToString:@"进校"]) {
            cell.stateImg.image = [UIImage imageNamed:@"进校"];
        }else if ([[dic objectForKey:@"img"] isEqualToString:@"出校"])
        {
            cell.stateImg.image = [UIImage imageNamed:@"出校"];


        }else if ([[dic objectForKey:@"img"] isEqualToString:@"未知"])
        {

        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 108;
    }else
    {
        return 70;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backView.backgroundColor = COLOR(0, 0, 0, 0.2);
    UITapGestureRecognizer * backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap:)];
    self.backView.userInteractionEnabled = YES;
    [self.backView addGestureRecognizer:backTap];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.backView];

    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(15, kScreenHeight / 2 - (kScreenWidth - 30) * 210 / 345 / 2, kScreenWidth - 30 , (kScreenWidth - 30) * 210 / 345)];
    img.image = [UIImage imageNamed:@"监控"];
    UITapGestureRecognizer * imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
    img.userInteractionEnabled = YES;
    [img addGestureRecognizer:imgTap];
    [self.backView addSubview:img];
    
    UIImageView * close = [[UIImageView alloc] initWithFrame:CGRectMake(img.frame.size.width + img.frame.origin.x - 10, img.frame.origin.y - 10, 20 , 20)];
    close.image = [UIImage imageNamed:@"guanbi"];
    UITapGestureRecognizer * closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTap:)];
    close.userInteractionEnabled = YES;
    [close addGestureRecognizer:closeTap];
    [self.backView addSubview:close];
}

- (void)dingweiClick:(UIBarButtonItem *)sender
{
    DingWeiViewController * VC = [[DingWeiViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)imgTap:(UITapGestureRecognizer *)sender
{
}

- (void)closeTap:(UITapGestureRecognizer *)sender
{
    [self.backView removeFromSuperview];
}

- (void)backTap:(UITapGestureRecognizer *)sender
{
    [self.backView removeFromSuperview];
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
