//
//  ShiPinListViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ShiPinListViewController.h"
#import "ShiPinListCell.h"
#import "SchoolDongTaiModel.h"
@interface ShiPinListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * shiPinListTableView;
@property (nonatomic, strong) UIImageView * zanwushuju;

@property (nonatomic, strong) NSMutableArray * shiPinListAry;
@end

@implementation ShiPinListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.shiPinListTableView.delegate = self;
    self.shiPinListTableView.dataSource = self;
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
    
    [self.view addSubview:self.shiPinListTableView];
    self.shiPinListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.shiPinListTableView registerClass:[ShiPinListCell class] forCellReuseIdentifier:@"ShiPinListCellId"];
    
    [self setNetWork];
    
}

- (NSMutableArray *)shiPinListAry
{
    if (!_shiPinListAry) {
        self.shiPinListAry = [@[]mutableCopy];
    }
    return _shiPinListAry;
}

- (void)setNetWork
{
    NSDictionary * dic = @{@"key":[UserManager key], @"teacher_id":[NSString stringWithFormat:@"%ld", self.teacherZaiXianDetailsModel.teacher_id]};
    [[HttpRequestManager sharedSingleton] POST:onlineTheTeacherList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [SchoolDongTaiModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (SchoolDongTaiModel *model in arr) {
                [self.shiPinListAry addObject:model];
            }
            if (self.shiPinListAry.count == 0) {
                self.zanwushuju.alpha = 1;
                
            } else {
                self.zanwushuju.alpha = 0;
                [self.shiPinListTableView reloadData];
            }
            [self.shiPinListTableView reloadData];
        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (UITableView *)shiPinListTableView
{
    if (!_shiPinListTableView) {
        self.shiPinListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.shiPinListTableView.delegate = self;
        self.shiPinListTableView.dataSource = self;
    }
    return _shiPinListTableView;
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
    return self.shiPinListAry.count;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShiPinListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ShiPinListCellId" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    if (self.shiPinListAry.count != 0) {
        SchoolDongTaiModel * model = [self.shiPinListAry objectAtIndex:indexPath.row];
        [cell.ShiPinListImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
        cell.titleLabel.text = model.title;
        cell.timeLabel.text = model.create_time;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shiPinListAry.count != 0) {
        SchoolDongTaiModel * model = [self.shiPinListAry objectAtIndex:indexPath.row];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shipinListBoFang" object:@{@"SchoolDongTaiModel":model}];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
    
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
