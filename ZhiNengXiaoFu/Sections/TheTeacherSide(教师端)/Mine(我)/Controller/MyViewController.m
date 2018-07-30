//
//  MyViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "MyViewController.h"
#import "ExitCell.h"
#import "MyInformationCell.h"
#import "HomeworkCell.h"
#import "PersonalDataViewController.h"
#import "HelperCenterViewController.h"
#import "SystemInfomationViewController.h"
#import "LeaveListViewController.h"

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTabelView;
@property (nonatomic, strong) NSMutableArray *myArr;

@end

@implementation MyViewController

- (NSMutableArray *)myArr {
    if (!_myArr) {
        _myArr = [NSMutableArray array];
    }
    return _myArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.title = @"我";
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"c4",@"c5",@"c6", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"帮助",@"系统消息",@"请假消息", nil];
    
    for (int i = 0; i < imgAry.count; i++) {
        NSString * img  = [imgAry objectAtIndex:i];
        NSString * title = [TitleAry objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title};
        [self.myArr addObject:dic];
    }
    
    [self.view addSubview:self.myTabelView];
    [self.myTabelView registerClass:[HomeworkCell class] forCellReuseIdentifier:@"HomeworkCellId"];
    [self.myTabelView registerClass:[MyInformationCell class] forCellReuseIdentifier:@"MyInformationCellId"];
    [self.myTabelView registerClass:[ExitCell class] forCellReuseIdentifier:@"ExitCellId"];
    self.myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (UITableView *)myTabelView {
    if (!_myTabelView) {
        self.myTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStyleGrouped];
        self.myTabelView.delegate = self;
        self.myTabelView.dataSource = self;
        self.myTabelView.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _myTabelView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 20;
    } else {
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    return headerView;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyInformationCellId" forIndexPath:indexPath];
        cell.userName.text = @"小明";
        cell.userZiLiao.text = @"我的资料";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        HomeworkCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeworkCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary * dic = [self.myArr objectAtIndex:indexPath.row];
        cell.itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
        cell.itemLabel.text = [dic objectForKey:@"title"];
        return cell;
    } else {
        ExitCell *  cell = [tableView dequeueReusableCellWithIdentifier:@"ExitCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    } else if (indexPath.section == 1) {
        return 50;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PersonalDataViewController *personalDataVC = [[PersonalDataViewController alloc] init];
        [self.navigationController pushViewController:personalDataVC animated:YES];
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                NSLog(@"1");
                HelperCenterViewController *helpCenterVC = [[HelperCenterViewController alloc] init];
                [self.navigationController pushViewController:helpCenterVC animated:YES];
            }
                break;
            case 1:
            {
                NSLog(@"2");
                SystemInfomationViewController *systemInfomationVC = [[SystemInfomationViewController alloc] init];
                [self.navigationController pushViewController:systemInfomationVC animated:YES];
            }
                break;
            case 2:
            {
                NSLog(@"3");
                LeaveListViewController *leaveListVC = [[LeaveListViewController alloc] init];
                [self.navigationController pushViewController:leaveListVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    } else {
        NSLog(@"退出登录");
    }
}

@end
