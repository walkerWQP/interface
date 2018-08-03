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
#import "HelpCenterViewController.h"
#import "LoginHomePageViewController.h"
#import "LeaveListViewController.h"
#import "ChangePasswordViewController.h"

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *myTabelView;
@property (nonatomic, strong) NSMutableArray *myArr;
@property (nonatomic, strong) PersonInformationModel * personInfo;

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
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"帮助1",@"请假列表",@"修改密码", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"帮助",@"请假列表",@"修改密码", nil];
    
    for (int i = 0; i < imgAry.count; i++) {
        NSString * img  = [imgAry objectAtIndex:i];
        NSString * title = [TitleAry objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title};
        [self.myArr addObject:dic];
    }
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"personInfo"];
    self.personInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
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
        cell.userName.text = self.personInfo.name;
        cell.userZiLiao.text = @"我的资料";
        [cell.userImg sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:nil];
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
        [cell.exitBtn addTarget:self action:@selector(exitBtn:) forControlEvents:UIControlEventTouchUpInside];
        
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
                HelpCenterViewController *helpCenterVC = [[HelpCenterViewController alloc] init];
                [self.navigationController pushViewController:helpCenterVC animated:YES];
            }
                break;
            case 1:
            {
                NSLog(@"请假列表");
                LeaveListViewController *leaveListVC = [[LeaveListViewController alloc] init];
                [self.navigationController pushViewController:leaveListVC animated:YES];
               
            }
                break;
            case 2:
            {
                NSLog(@"修改密码");
                ChangePasswordViewController *changePasswordVC = [[ChangePasswordViewController alloc] init];
                [self.navigationController pushViewController:changePasswordVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        NSLog(@"退出登录");
    }
}

- (void)exitBtn : (UIButton *)sender {
    NSLog(@"点击退出");
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"确定要退出登录吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击退出登录");
        [self tuichuLogin];
    }];
    UIAlertAction *alertF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionSheet addAction:alertT];
    [actionSheet addAction:alertF];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

- (void)tuichuLogin
{
    [UserManager logoOut];
}

@end
