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
#import "LoginHomePageViewController.h"
#import "OffTheListViewController.h"
#import "ChangePasswordViewController.h"
#import "OngoingTableViewController.h"
#import "PersonInformationModel.h"
#import "SleepManagementViewController.h"
#import "BindMobilePhoneViewController.h"

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView    *myTabelView;
@property (nonatomic, strong) NSMutableArray *myArr;
@property (nonatomic, strong) PersonInformationModel * personInfo;
@property (nonatomic, strong) PersonInformationModel * model;

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
    [self setUser];
   
    
//    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"personInfo"];
//    self.personInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    [self.view addSubview:self.myTabelView];
    [self.myTabelView registerClass:[HomeworkCell class] forCellReuseIdentifier:@"HomeworkCellId"];
    [self.myTabelView registerClass:[MyInformationCell class] forCellReuseIdentifier:@"MyInformationCellId"];
    [self.myTabelView registerClass:[ExitCell class] forCellReuseIdentifier:@"ExitCellId"];
    self.myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        NSLog(@"点击l");
        BindMobilePhoneViewController *bindMobilePhoneVC = [[BindMobilePhoneViewController alloc] init];
        bindMobilePhoneVC.typeStr = @"1";
        [self.navigationController pushViewController:bindMobilePhoneVC animated:YES];
    }
    
}



- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [WProgressHUD showHUDShowText:@"加载中..."];

    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        [WProgressHUD hideAllHUDAnimated:YES];

        self.model = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        if (self.model.is_adviser == 1 && self.model.dorm_open == 1) {
            NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"帮助1",@"请假列表",@"修改密码",@"已发布", @"就寝管理",nil];
            NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"帮助",@"请假列表",@"修改密码",@"已发布的活动", @"就寝管理", nil];
            
            for (int i = 0; i < imgAry.count; i++) {
                NSString * img  = [imgAry objectAtIndex:i];
                NSString * title = [TitleAry objectAtIndex:i];
                NSDictionary * dic = @{@"img":img, @"title":title};
                [self.myArr addObject:dic];
            }
        
        }else
        {
            NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"帮助1",@"请假列表",@"修改密码",@"已发布",nil];
            NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"帮助",@"请假列表",@"修改密码",@"已发布的活动", nil];
            
            for (int i = 0; i < imgAry.count; i++) {
                NSString * img  = [imgAry objectAtIndex:i];
                NSString * title = [TitleAry objectAtIndex:i];
                NSDictionary * dic = @{@"img":img, @"title":title};
                [self.myArr addObject:dic];
            }
        }
        
        NSLog(@"%@",self.model.mobile);
        if (self.model.mobile == nil || [self.model.mobile isEqualToString:@""]) {
            NSLog(@"手机号为空");
            
            UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请绑定手机号码, 便于登录使用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [locationAlert show];
            
            
        } else {
            NSLog(@"手机号不为空");
        }

        [self.myTabelView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}



- (UITableView *)myTabelView {
    if (!_myTabelView) {
        self.myTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.myTabelView.backgroundColor = backColor;
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
        return self.myArr.count;
    } else {
        return 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 10;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 10)];
    headerView.backgroundColor = backColor;
    return headerView;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MyInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyInformationCellId" forIndexPath:indexPath];
        cell.userName.text = self.model.name;
        cell.userZiLiao.text = @"我的资料";
       
        if (self.model.head_img == nil)
        {
            cell.userImg.image = [UIImage imageNamed:@"user"];
        } else
        {
            [cell.userImg sd_setImageWithURL:[NSURL URLWithString:self.model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        HomeworkCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeworkCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.myArr.count != 0) {
            NSDictionary * dic = [self.myArr objectAtIndex:indexPath.row];
            cell.itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
            cell.itemLabel.text = [dic objectForKey:@"title"];
        }
        
        return cell;
    } else
    {
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
                HelperCenterViewController *helpCenterVC = [[HelperCenterViewController alloc] init];
                [self.navigationController pushViewController:helpCenterVC animated:YES];
            }
                break;
            case 1:
            {
                NSLog(@"请假列表");
                OffTheListViewController *offTheListVC = [[OffTheListViewController alloc] init];
                [self.navigationController pushViewController:offTheListVC animated:YES];
               
            }
                break;
            case 2:
            {
                NSLog(@"修改密码");
                ChangePasswordViewController *changePasswordVC = [[ChangePasswordViewController alloc] init];
                [self.navigationController pushViewController:changePasswordVC animated:YES];
            }
                break;
            case 3:
            {
                NSLog(@"我的活动");
                OngoingTableViewController *ongoingTableViewC = [[OngoingTableViewController alloc] init];
                [self.navigationController pushViewController:ongoingTableViewC animated:YES];
                
            }
                break;
            case 4:
            {
                NSLog(@"点击就寝管理");
                SleepManagementViewController * sleepManagementVC = [[SleepManagementViewController alloc] init];
                [self.navigationController pushViewController:sleepManagementVC animated:YES];
            }
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        NSLog(@"退出登录");
    }
}

- (void)exitBtn : (UIButton *)sender
{
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
    [WProgressHUD showSuccessfulAnimatedText:@"退出成功"];

}

@end
