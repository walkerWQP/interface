//
//  YiHuiFuViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/4.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "YiHuiFuViewController.h"
#import "WenTiZiXunListCell.h"
#import "ConsultListModel.h"

@interface YiHuiFuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * YiHuiFuTableView;
@property (nonatomic, strong) ConsultListModel * consultListModel;
@property (nonatomic, strong) NSMutableArray * yiHuiFuAry;

@end

@implementation YiHuiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.YiHuiFuTableView.delegate = self;
    self.YiHuiFuTableView.dataSource = self;
    
    [self.view addSubview:self.YiHuiFuTableView];
    self.YiHuiFuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.YiHuiFuTableView registerClass:[WenTiZiXunListCell class] forCellReuseIdentifier:@"WenTiZiXunListCellId"];
    
    [self setNetWork];
}

- (NSMutableArray *)yiHuiFuAry
{
    if (!_yiHuiFuAry) {
        self.yiHuiFuAry = [@[]mutableCopy];
    }
    return _yiHuiFuAry;
}

- (void)setNetWork
{
    NSDictionary * dic = @{@"key":[UserManager key], @"status":@1};
    
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.yiHuiFuAry = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            [self.YiHuiFuTableView reloadData];
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
        NSLog(@"%@", error);
    }];
}

- (UITableView *)YiHuiFuTableView
{
    if (!_YiHuiFuTableView) {
        self.YiHuiFuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.YiHuiFuTableView.delegate = self;
        self.YiHuiFuTableView.dataSource = self;
    }
    return _YiHuiFuTableView;
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
    return self.yiHuiFuAry.count;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WenTiZiXunListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WenTiZiXunListCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ConsultListModel * model = [self.yiHuiFuAry objectAtIndex:indexPath.row];
    [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:model.s_headimg] placeholderImage:nil];
    cell.userName.text = [NSString stringWithFormat:@"%@%@问:", model.class_name ,model.student_name];
    cell.questionLabel.text = model.question;
    [cell.userIconT sd_setImageWithURL:[NSURL URLWithString:model.t_headimg] placeholderImage:nil];
    cell.userNameT.text = [NSString stringWithFormat:@"%@%@老师%@回复:", model.class_name, model.course_name, model.teacher_name];
    cell.questionLabelT.text = model.answer;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 171;
    
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
