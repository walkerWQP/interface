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

@interface PersonalDataViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView    *personalDataTableView;
@property (nonatomic, strong) NSMutableArray *nameArr;
@property (nonatomic, strong) PersonInformationModel * personInfo;

@end

@implementation PersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = backColor;

    self.personalDataTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.nameArr = [NSMutableArray arrayWithObjects:@"头像",@"姓名",@"手机", @"账号", @"学校", nil];
    [self.view addSubview:self.personalDataTableView];
    [self.personalDataTableView registerClass:[PersonInfomationCell class] forCellReuseIdentifier:@"PersonInfomationCellId"];
    [self.personalDataTableView registerClass:[PersonIconCell class] forCellReuseIdentifier:@"PersonIconCellId"];
    self.personInfo = [UserManager getUserObject];
}


- (UITableView *)personalDataTableView {
    if (!_personalDataTableView) {
        self.personalDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
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
        [cell.iConImg sd_setImageWithURL:[NSURL URLWithString:self.personInfo.head_img] placeholderImage:nil];
        return cell;
    } else {
        PersonInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfomationCellId" forIndexPath:indexPath];
        cell.nameLabel.text = [self.nameArr objectAtIndex:indexPath.row];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
        if (indexPath.row == 1) {
            cell.titleLabel.text = self.personInfo.name;
        }else if (indexPath.row == 2) {
            cell.titleLabel.text = self.personInfo.mobile;
            
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
            NSLog(@"修改密码");
        }
            break;
        case 3:
        {
            NSLog(@"手机号");
        }
            break;
        case 4:
        {
            NSLog(@"学校");
        }
            break;
        case 5:
        {
            NSLog(@"账号");
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
