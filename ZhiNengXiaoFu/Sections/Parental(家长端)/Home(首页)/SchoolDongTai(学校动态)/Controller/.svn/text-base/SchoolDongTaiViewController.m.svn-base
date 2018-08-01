//
//  SchoolDongTaiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolDongTaiViewController.h"
#import "TeacherTongZhiCell.h"
#import "SchoolDongTaiDetailsViewController.h"
@interface SchoolDongTaiViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *schoolDynamicTableView;
@property (nonatomic, strong) NSMutableArray *schoolDynamicArr;
@end

@implementation SchoolDongTaiViewController

- (NSMutableArray *)schoolDynamicArr {
    if (!_schoolDynamicArr) {
        _schoolDynamicArr = [NSMutableArray array];
    }
    return _schoolDynamicArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.schoolDynamicTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.title = @"学校动态";
    
    
    NSMutableArray *imgArr = [NSMutableArray arrayWithObjects:@"c4",@"c1",@"c2", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"京东云提供多款云服务器供您选择,您无需为硬件的采购和维护投入精力,可随时创建和释放多",@"京东云提供多款云服务器供您选择,您无需为硬件的采购和维护投入精力,可随时创建和释放多",@"京东云提供多款云服务器供您选择,您无需为硬件的采购和维护投入精力,可随时创建和释放多", nil];
    NSMutableArray *timeArr = [NSMutableArray arrayWithObjects:@"2018-07-21",@"2018-07-20",@"2018-07-19", nil];
    for (int i = 0; i < imgArr.count; i ++) {
        NSString * img  = [imgArr objectAtIndex:i];
        NSString * title = [titleArr objectAtIndex:i];
        NSString * time  = [timeArr objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title,@"time":time};
        [self.schoolDynamicArr addObject:dic];
    }
    [self.view addSubview:self.schoolDynamicTableView];
    self.schoolDynamicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.schoolDynamicTableView registerClass:[TeacherTongZhiCell class] forCellReuseIdentifier:@"TeacherTongZhiCellId"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolDongTaiDetailsViewController * schoolDongTaivc = [[SchoolDongTaiDetailsViewController alloc] init];
    [self.navigationController pushViewController:schoolDongTaivc animated:YES];
    
}


- (UITableView *)schoolDynamicTableView {
    if (!_schoolDynamicTableView) {
        self.schoolDynamicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.schoolDynamicTableView.delegate = self;
        self.schoolDynamicTableView.dataSource = self;
    }
    return _schoolDynamicTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else
    {
        return 2;

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        imgs.image = [UIImage imageNamed:@"banner"];
        [cell addSubview:imgs];
        return cell;
    }else
    {
        TeacherTongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherTongZhiCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.titleLabel.text = @"放假通知";
        cell.contentLabel.text = @"通知: 各位家长请在暑假期间督促孩子们完成假期作业...";
        cell.timeLabel.text = @"2018-08-25";
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 170;
    }else
    {
        return 110;
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
