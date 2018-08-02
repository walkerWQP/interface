//
//  HelperCenterViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HelperCenterViewController.h"
#import "ClassHomePageItemCell.h"

@interface HelperCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * HelperCenterTableView;
@property (nonatomic, strong) NSMutableArray * HelperCenterAry;

@end

@implementation HelperCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"帮助中心";

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.HelperCenterTableView];
    [self.HelperCenterTableView registerClass:[ClassHomePageItemCell class] forCellReuseIdentifier:@"ClassHomePageItemCellId"];
    self.HelperCenterTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)HelperCenterAry
{
    if (!_HelperCenterAry) {
        self.HelperCenterAry = [@[]mutableCopy];
    }
    return _HelperCenterAry;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 2;
    }else if (section == 2)
    {
        return 1;
    }else
    {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *CellIdentifier = @"TableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }else{
            //删除cell中的子对象,刷新覆盖问题。
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView * imgs = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
        imgs.image = [UIImage imageNamed:@"bannerHelper"];
        [cell addSubview:imgs];
        return cell;
    }else
    {
        ClassHomePageItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassHomePageItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.itemImg.image = [UIImage imageNamed:@"拨打电话家长"];
                cell.itemLabel.text = @"拨打电话";
            }else
            {
                cell.itemImg.image = [UIImage imageNamed:@"QQ电话"];
                cell.itemLabel.text = @"QQ电话";
            }
        }else if (indexPath.section == 2)
        {
            cell.itemImg.image = [UIImage imageNamed:@"关注我们"];
            cell.itemLabel.text = @"关注我们";
        }else
        {
            cell.itemImg.image = [UIImage imageNamed:@"建议反馈1"];
            cell.itemLabel.text = @"建议与反馈";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1)
    {
        return 40;
    }else if (section == 2)
    {
        return 40;
    }else
    {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return nil;
    }else
    {
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        headerView.backgroundColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
        
        UIImageView * titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 16, 16)];
        [headerView addSubview:titleImg];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x + titleImg.frame.size.width + 10, 10, 100, 20)];
        titleLabel.font = [UIFont systemFontOfSize: 16];
        titleLabel.textColor = COLOR(51, 51, 51, 1);
        [headerView addSubview:titleLabel];
        if (section == 1) {
            titleLabel.text = @"联系我们";
            titleImg.image = [UIImage imageNamed:@"联系我们家长"];
        }else if (section == 2)
        {
            titleLabel.text = @"关注我们";
            titleImg.image = [UIImage imageNamed:@"关注我们家长"];

        }else
        {
             titleLabel.text = @"建议反馈";
             titleImg.image = [UIImage imageNamed:@"建议反馈家长"];
        }
        return headerView;
    }
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UITableView *)HelperCenterTableView
{
    if (!_HelperCenterTableView) {
        self.HelperCenterTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.HelperCenterTableView.dataSource = self;
        self.HelperCenterTableView.delegate = self;
    }
    return _HelperCenterTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }else if (indexPath.section == 1)
    {
        return 50;
    }else if (indexPath.section == 2)
    {
        return 50;
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
