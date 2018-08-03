//
//  SchoolTongZhiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/21.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolTongZhiViewController.h"
#import "TeacherTongZhiCell.h"
#import "TongZhiCell.h"
#import "TongZhiDetailsViewController.h"
#import "TongZhiModel.h"
@interface SchoolTongZhiViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * schoolTongZhiAry;
@property (nonatomic, strong) UITableView * schoolTongZhiTableView;
@property (nonatomic, strong) UIImageView * zanwushuju;
@end

@implementation SchoolTongZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学校通知";
    //网络请求
    [self getNetWork];
    
   
    
    [self.view addSubview:self.schoolTongZhiTableView];
    [self.schoolTongZhiTableView registerClass:[TongZhiCell class] forCellReuseIdentifier:@"TongZhiCellId"];
    self.schoolTongZhiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.zanwushuju = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 105 / 2, 200, 105, 111)];
    self.zanwushuju.image = [UIImage imageNamed:@"暂无数据家长端"];
    self.zanwushuju.alpha = 0;
    [self.view addSubview:self.zanwushuju];
}

- (void)getNetWork
{
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary * dic = @{@"key":key, @"is_school":@1};
    [[HttpRequestManager sharedSingleton] POST:JIAZHANGCHAKANTONGZHILIEBIAO parameters:dic success:^(NSURLSessionDataTask *task, id responseObject)
    {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200)
        {
            self.schoolTongZhiAry = [TongZhiModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            if (self.schoolTongZhiAry.count == 0) {
                self.zanwushuju.alpha = 1;
                
            }
            [self.schoolTongZhiTableView reloadData];

        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_failed_56_w100"];
                
            }
        }        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
    return self.schoolTongZhiAry.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    TongZhiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TongZhiCellId" forIndexPath:indexPath];
    TongZhiModel * model = [self.schoolTongZhiAry objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.headImgView.image = [UIImage imageNamed:@"通知图标"];
    cell.titleLabel.text = model.title;
    cell.subjectsLabel.text = model.abstract;
    cell.timeLabel.text = model.create_time;
    
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TongZhiDetailsViewController * tongZhiDetails  = [[TongZhiDetailsViewController alloc] init];
    TongZhiModel * model = [self.schoolTongZhiAry objectAtIndex:indexPath.row];
    tongZhiDetails.tongZhiId = model.ID;
    [self.navigationController pushViewController:tongZhiDetails animated:YES];
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
