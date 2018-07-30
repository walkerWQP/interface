//
//  SchoolTongZhiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolTongZhiViewController.h"
#import "TeacherTongZhiCell.h"
@interface SchoolTongZhiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * schoolTongZhiAry;
@property (nonatomic, strong) UITableView * schoolTongZhiTableView;

@end

@implementation SchoolTongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学校通知";
    
    [self.view addSubview:self.schoolTongZhiTableView];
    [self.schoolTongZhiTableView registerClass:[TeacherTongZhiCell class] forCellReuseIdentifier:@"TeacherTongZhiCellId"];
    self.schoolTongZhiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)schoolTongZhiAry
{
    if (!_schoolTongZhiAry) {
        self.schoolTongZhiAry = [@[]mutableCopy];
    }
    return _schoolTongZhiAry;
}



- (UITableView *)schoolTongZhiTableView
{
    if (!_schoolTongZhiTableView) {
        self.schoolTongZhiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.schoolTongZhiTableView.delegate = self;
        self.schoolTongZhiTableView.dataSource = self;
    }
    return _schoolTongZhiTableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
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
        imgs.image = [UIImage imageNamed:@"homepagelunbo2"];
        [cell addSubview:imgs];
        return cell;
    }else
    {
        TeacherTongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherTongZhiCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgView.image = [UIImage imageNamed:@"img_notice_place_holder_big"];
        cell.titleLabel.text = @"暑假放假通知";
        cell.contentLabel.text = @"未知";
        cell.timeLabel.text = @"2018-07-12";
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }else
    {
        return 70;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else
    {
        
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
