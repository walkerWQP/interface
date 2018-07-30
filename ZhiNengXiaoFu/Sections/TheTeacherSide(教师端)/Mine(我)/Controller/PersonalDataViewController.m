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

@end

@implementation PersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = backColor;

    self.personalDataTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.nameArr = [NSMutableArray arrayWithObjects:@"头像",@"名字",@"修改密码", @"手机号", @"学校", @"账号", nil];
    [self.view addSubview:self.personalDataTableView];
    [self.personalDataTableView registerClass:[PersonInfomationCell class] forCellReuseIdentifier:@"PersonInfomationCellId"];
    [self.personalDataTableView registerClass:[PersonIconCell class] forCellReuseIdentifier:@"PersonIconCellId"];
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
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PersonIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonIconCellId" forIndexPath:indexPath];
        cell.nameLabel.text = @"头像";
        return cell;
    } else {
        PersonInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfomationCellId" forIndexPath:indexPath];
        cell.nameLabel.text = [self.nameArr objectAtIndex:indexPath.row];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
            cell.moreImg.alpha = 1;
        } else {
            cell.moreImg.alpha = 0;
            
        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"赵婷韵";
        }else if (indexPath.row == 3) {
            cell.titleLabel.text = @"18873090308";
            
        } else if (indexPath.row == 4) {
            cell.titleLabel.text = @"赤水一中";
            
        }else if (indexPath.row == 5)
        {
            cell.titleLabel.text = @"99999";
            
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
