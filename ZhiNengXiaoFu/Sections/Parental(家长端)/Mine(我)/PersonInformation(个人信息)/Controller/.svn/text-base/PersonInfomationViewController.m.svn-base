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
@interface PersonInfomationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * personInfomationTableView;
@property (nonatomic, strong) NSMutableArray * nameAry;
@end

@implementation PersonInfomationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.personInfomationTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.nameAry = [NSMutableArray arrayWithObjects:@"头像",@"名字",@"手机",@"亲属账号",@"修改密码", @"学生类型",@"账号", @"学校", @"年级", @"班级", nil];
    [self.view addSubview:self.personInfomationTableView];
    [self.personInfomationTableView registerClass:[PersonInfomationCell class] forCellReuseIdentifier:@"PersonInfomationCellId"];
    [self.personInfomationTableView registerClass:[PersonIconCell class] forCellReuseIdentifier:@"PersonIconCellId"];
}


- (UITableView *)personInfomationTableView
{
    if (!_personInfomationTableView) {
        self.personInfomationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        self.personInfomationTableView.dataSource = self;
        self.personInfomationTableView.delegate = self;
    }
    return _personInfomationTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PersonIconCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonIconCellId" forIndexPath:indexPath];
        cell.nameLabel.text = @"头像";
        return cell;
    }else
    {
        PersonInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfomationCellId" forIndexPath:indexPath];
        cell.nameLabel.text = [self.nameAry objectAtIndex:indexPath.row];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
            cell.moreImg.alpha = 1;
        }else
        {
            cell.moreImg.alpha = 0;

        }
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"赵子龙";
        }else if (indexPath.row == 2)
        {
            cell.titleLabel.text = @"18873090308";

        }else if (indexPath.row == 5)
        {
            cell.titleLabel.text = @"在校生";
            
        }else if (indexPath.row == 6)
        {
            cell.titleLabel.text = @"12347";
            
        }else if (indexPath.row == 7)
        {
            cell.titleLabel.text = @"赤水一中";
            
        }else if (indexPath.row == 8)
        {
            cell.titleLabel.text = @"高一年级";
            
        }else if (indexPath.row == 9)
        {
            cell.titleLabel.text = @"高一(8)班";
            
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
