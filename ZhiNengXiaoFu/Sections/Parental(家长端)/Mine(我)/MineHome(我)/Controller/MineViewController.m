//
//  MineViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "MineViewController.h"
#import "ClassHomePageItemCell.h"
#import "TuiChuLoginCell.h"
#import "MinePersonXiXinCell.h"
#import "PersonInfomationViewController.h"
#import "HelperCenterViewController.h"
#import "LeaveListViewController.h"
#import "SystemInfomationViewController.h"
#import "PersonInformationModel.h"
#import "PrefixHeader.pch"
#import "LoginHomePageViewController.h"
#import "ChangePasswordViewController.h"
#import "JiuQinGuanLiViewController.h"
#import "ExitCell.h"
#import "BindMobilePhoneViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (nonatomic, strong) UITableView * mineTabelView;
@property (nonatomic, strong) NSMutableArray * mineAry;
@property (nonatomic, strong) PersonInformationModel * personInfo;

@property (nonatomic, assign) NSInteger bangdingState;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 /255.0 alpha:1];
    self.title = @"我的";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:173/ 255.0 green:228 / 255.0 blue: 211 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    
    
   
    
    [self.view addSubview:self.mineTabelView];
    
    [self.mineTabelView registerClass:[ClassHomePageItemCell class] forCellReuseIdentifier:@"ClassHomePageItemCellId"];
    [self.mineTabelView registerClass:[MinePersonXiXinCell class] forCellReuseIdentifier:@"MinePersonXiXinCellId"];
    [self.mineTabelView registerClass:[ExitCell class] forCellReuseIdentifier:@"ExitCellId"];
   
    self.mineTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        NSLog(@"点击l");
        BindMobilePhoneViewController *bindMobilePhoneVC = [[BindMobilePhoneViewController alloc] init];
        bindMobilePhoneVC.typeStr = @"1";
        [self.navigationController pushViewController:bindMobilePhoneVC animated:YES];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mineAry = [@[]mutableCopy];
    [self setNetWork];
}


- (void)setNetWork
{
    NSDictionary * dic = @{@"key":[UserManager key]};
     if (self.bangdingState == 0) {
         
         [WProgressHUD showHUDShowText:@"加载中..."];

     }
    
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        self.personInfo = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        
        if (self.bangdingState == 0) {
            [WProgressHUD hideAllHUDAnimated:YES];

            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"])
            {
                //            [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
                
            }else
            {
            if (self.personInfo.mobile == nil || [self.personInfo.mobile isEqualToString:@""]) {
                NSLog(@"手机号为空");
                
                UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请绑定手机号码, 便于登录使用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [locationAlert show];
                
                self.bangdingState = 1;
            } else {
                NSLog(@"手机号不为空");
            }
            }
            
        }
        
        
        
        if (self.personInfo.dorm_open == 1 && self.personInfo.nature == 2) {
            NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"帮助",@"请假列表",@"修改密码",@"就寝管理", nil];
            NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"帮助",@"请假列表",@"修改密码",@"就寝管理", nil];
            
            for (int i = 0; i < imgAry.count; i++) {
                NSString * img  = [imgAry objectAtIndex:i];
                NSString * title = [TitleAry objectAtIndex:i];
                NSDictionary * dic = @{@"img":img, @"title":title};
                [self.mineAry addObject:dic];
            }
        }else
        {
            NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"帮助",@"请假列表",@"修改密码", nil];
            NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"帮助",@"请假列表",@"修改密码", nil];
            
            for (int i = 0; i < imgAry.count; i++) {
                NSString * img  = [imgAry objectAtIndex:i];
                NSString * title = [TitleAry objectAtIndex:i];
                NSDictionary * dic = @{@"img":img, @"title":title};
                [self.mineAry addObject:dic];
            }
        }
        [self.mineTabelView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (NSMutableArray *)mineAry
{
    if (!_mineAry) {
        self.mineAry = [@[]mutableCopy];
    }
    return _mineAry;
}

- (UITableView *)mineTabelView
{
    if (!_mineTabelView)
    {
        self.mineTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) style:UITableViewStylePlain];
        self.mineTabelView.backgroundColor = backColor;
        self.mineTabelView.delegate = self;
        self.mineTabelView.dataSource = self;
    }
    return _mineTabelView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return self.mineAry.count;
    }else
    {
        return 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1)
    {
        return 10;
    }else
    {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    return headerView;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MinePersonXiXinCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MinePersonXiXinCellId" forIndexPath:indexPath];
        cell.userName.text = self.personInfo.name;
        cell.userZiLiao.text = @"我的资料";
        
        [cell.userImg sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1)
    {
        ClassHomePageItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassHomePageItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.mineAry.count != 0 && self.mineAry.count > indexPath.row ) {
            NSDictionary * dic = [self.mineAry objectAtIndex:indexPath.row];
            cell.itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
            cell.itemLabel.text = [dic objectForKey:@"title"];
        }
      
        
        return cell;
    }else
    {
        ExitCell *  cell = [tableView dequeueReusableCellWithIdentifier:@"ExitCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.exitBtn addTarget:self action:@selector(tuichuLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.userInteractionEnabled = YES;
        return cell;
        
      
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }else if (indexPath.section == 1)
    {
        return 50;
    }else
    {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PersonInfomationViewController * personInformation = [[PersonInfomationViewController alloc] init];
        [self.navigationController pushViewController:personInformation animated:YES];
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            HelperCenterViewController * helperCenterVC = [[HelperCenterViewController alloc] init];
            [self.navigationController pushViewController:helperCenterVC animated:YES];
        }else if (indexPath.row == 1)
        {
            LeaveListViewController * leaveListVC = [[LeaveListViewController alloc] init];
            [self.navigationController pushViewController:leaveListVC animated:YES];
        }else if (indexPath.row == 2)
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"youkeState"] isEqualToString:@"1"])
            {
                [WProgressHUD showErrorAnimatedText:@"游客不能进行此操作"];
                
            }else
            {
            ChangePasswordViewController *changePasswordVC = [[ChangePasswordViewController alloc] init];
            [self.navigationController pushViewController:changePasswordVC animated:YES];
            }
        }else
        {
            JiuQinGuanLiViewController * jiuQin = [[JiuQinGuanLiViewController alloc] init];
            [self.navigationController pushViewController:jiuQin animated:YES];
        }
    }else
    {
        
    }
}

- (void)tuichuLoginBtn:(UIButton *)sender
{
   
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"确定要退出登录吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击退出登录");
        [UserManager logoOut];
        [WProgressHUD showSuccessfulAnimatedText:@"退出成功"];
    }];
    UIAlertAction *alertF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionSheet addAction:alertT];
    [actionSheet addAction:alertF];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
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
