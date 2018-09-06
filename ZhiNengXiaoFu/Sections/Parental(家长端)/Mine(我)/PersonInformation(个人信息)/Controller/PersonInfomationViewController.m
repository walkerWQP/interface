//
//  PersonInfomationViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PersonInfomationViewController.h"
#import "PersonInfomationCell.h"
#import "PersonIconCell.h"
#import "PersonInformationModel.h"
#import "BindMobilePhoneViewController.h"

@interface PersonInfomationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * personInfomationTableView;
@property (nonatomic, strong) NSMutableArray * nameAry;
@property (nonatomic, strong) PersonInformationModel * personInfo;

@end

@implementation PersonInfomationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.personInfomationTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.nameAry = [NSMutableArray arrayWithObjects:@"头像",@"名字",@"手机", @"学生类型",@"账号", @"学校", @"所在班级", nil];
    [self.view addSubview:self.personInfomationTableView];
    [self.personInfomationTableView registerClass:[PersonInfomationCell class] forCellReuseIdentifier:@"PersonInfomationCellId"];
    [self.personInfomationTableView registerClass:[PersonIconCell class] forCellReuseIdentifier:@"PersonIconCellId"];
//    self.personInfo = [UserManager getUserObject];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setNetWork];
}

- (void)setNetWork
{
    NSDictionary * dic = @{@"key":[UserManager key]};
    
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        self.personInfo = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self.personInfomationTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (UITableView *)personInfomationTableView
{
    if (!_personInfomationTableView) {
        self.personInfomationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - APP_NAVH) style:UITableViewStylePlain];
        self.personInfomationTableView.dataSource = self;
        self.personInfomationTableView.delegate = self;
    }
    return _personInfomationTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        PersonIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonIconCellId" forIndexPath:indexPath];
        cell.nameLabel.text = @"头像";
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;

        [cell.iConImg sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        return cell;
    }else
    {
        PersonInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfomationCellId" forIndexPath:indexPath];
        cell.nameLabel.text = [self.nameAry objectAtIndex:indexPath.row];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 2) {
            cell.moreImg.alpha = 1;
            cell.newTitleLabel.alpha = 1;
            cell.titleLabel.alpha = 0;
            
            if (self.personInfo.mobile == nil || [self.personInfo.mobile isEqualToString:@""]) {
                cell.newTitleLabel.text = @"请绑定手机号";
            } else {
                NSString *numberString = [self.personInfo.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                cell.newTitleLabel.text = numberString;
            }
        }else
        {
            cell.moreImg.alpha = 0;
            cell.newTitleLabel.alpha = 0;
            cell.titleLabel.alpha = 1;
        }

        if (indexPath.row == 1) {
            cell.titleLabel.text = self.personInfo.name;
        }else if (indexPath.row == 2)
        {
            cell.titleLabel.text = self.personInfo.mobile;

        }else if (indexPath.row == 3)
        {
            if (self.personInfo.nature == 1) {
                cell.titleLabel.text = @"走读生";
            }else
            {
                cell.titleLabel.text = @"住校生";
            }
            
        }else if (indexPath.row == 4)
        {
            cell.titleLabel.text = self.personInfo.usernum;
            
        }else if (indexPath.row == 5)
        {
            cell.titleLabel.text = self.personInfo.school_name;
            
        }else if (indexPath.row == 6)
        {
            cell.titleLabel.text = self.personInfo.class_name_s;
            
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70;
    }else
    {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        BindMobilePhoneViewController * bingMoblie = [[BindMobilePhoneViewController alloc] init];
        if (self.personInfo.mobile == nil || [self.personInfo.mobile isEqualToString:@""]) {
            bingMoblie.typeStr = @"1";
        } else {
            bingMoblie.typeStr = @"2";
        }
        [self.navigationController pushViewController:bingMoblie animated:YES];

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
