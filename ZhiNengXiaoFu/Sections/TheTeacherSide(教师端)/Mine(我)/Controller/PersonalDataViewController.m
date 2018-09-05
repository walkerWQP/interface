//
//  PersonalDataViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "PersonInfomationCell.h"
#import "PersonIconCell.h"
#import "BindMobilePhoneViewController.h"

@interface PersonalDataViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *personalDataTableView;
@property (nonatomic, strong) NSMutableArray *nameArr;
@property (nonatomic, strong) PersonInformationModel * personInfo;


@end

@implementation PersonalDataViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = backColor;
    self.personalDataTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.nameArr = [NSMutableArray arrayWithObjects:@"头像",@"姓名",@"手机", @"账号", @"学校", nil];
    [self.view addSubview:self.personalDataTableView];
    [self.personalDataTableView registerClass:[PersonInfomationCell class] forCellReuseIdentifier:@"PersonInfomationCellId"];
    [self.personalDataTableView registerClass:[PersonIconCell class] forCellReuseIdentifier:@"PersonIconCellId"];
    
}

- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        self.personInfo = [PersonInformationModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self.personalDataTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (UITableView *)personalDataTableView {
    if (!_personalDataTableView) {
        self.personalDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - APP_NAVH) style:UITableViewStylePlain];
        self.personalDataTableView.backgroundColor = backColor;
        self.personalDataTableView.dataSource = self;
        self.personalDataTableView.delegate = self;
        self.personalDataTableView.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _personalDataTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PersonIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonIconCellId" forIndexPath:indexPath];
        cell.nameLabel.text = @"头像";
        
        if (self.personInfo.head_img == nil) {
            cell.iConImg.image = [UIImage imageNamed:@"user"];
        } else {
            [cell.iConImg sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        }
        return cell;
    } else {
        PersonInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfomationCellId" forIndexPath:indexPath];
        cell.nameLabel.text = [self.nameArr objectAtIndex:indexPath.row];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        if (indexPath.row == 2) {
            cell.moreImg.alpha = 1;
            cell.newTitleLabel.alpha = 1;
            cell.titleLabel.alpha = 0;
        }else
        {
            cell.moreImg.alpha = 0;
            cell.newTitleLabel.alpha = 0;
            cell.titleLabel.alpha = 1;
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = self.personInfo.name;
        }else if (indexPath.row == 2) {
            if (self.personInfo.mobile == nil || [self.personInfo.mobile isEqualToString:@""]) {
                cell.newTitleLabel.text = @"请绑定手机号";
            } else {
                cell.newTitleLabel.text = self.personInfo.mobile;
            }
            
            
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = self.personInfo.usernum;
        } else if (indexPath.row == 4) {
            cell.titleLabel.text = self.personInfo.school_name;
            
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"头像");
        }
            break;
        case 1:
        {
            NSLog(@"姓名");
        }
            break;
        case 2:
        {
            NSLog(@"手机号");
             BindMobilePhoneViewController *bingMoblie = [[BindMobilePhoneViewController alloc] init];
            if (self.personInfo.mobile == nil || [self.personInfo.mobile isEqualToString:@""]) {
                bingMoblie.typeStr = @"1";
            } else {
               bingMoblie.typeStr = @"2";
            }
           
            [self.navigationController pushViewController:bingMoblie animated:YES];
        }
            break;
        case 3:
        {
            NSLog(@"账号");
        }
            break;
        case 4:
        {
            NSLog(@"学校");
        }
            break;
            
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 70;
    } else {
        return 50;
    }
}



@end
