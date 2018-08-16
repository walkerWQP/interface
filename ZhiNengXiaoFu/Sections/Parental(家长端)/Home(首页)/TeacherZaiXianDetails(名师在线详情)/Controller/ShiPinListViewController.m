//
//  ShiPinListViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ShiPinListViewController.h"
#import "TeacherListNCell.h"
#import "TeacherZaiXianModel.h"
@interface ShiPinListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * shiPinListTableView;
@property (nonatomic, strong) UIImageView * zanwushuju;
@property (nonatomic, assign) NSInteger     page;
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
    [self.shiPinListTableView registerNib:[UINib nibWithNibName:@"TeacherListNCell" bundle:nil] forCellReuseIdentifier:@"TeacherListNCellId"];

//    //下拉刷新
//    self.shiPinListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
//    //自动更改透明度
//    self.shiPinListTableView.mj_header.automaticallyChangeAlpha = YES;
//    //进入刷新状态
//    [self.shiPinListTableView.mj_header beginRefreshing];
//    //上拉刷新
//    self.shiPinListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    [self setNetWork];

}

- (NSMutableArray *)shiPinListAry
{
    if (!_shiPinListAry) {
        self.shiPinListAry = [@[]mutableCopy];
    }
    return _shiPinListAry;
}

//- (void)loadNewTopic {
//    self.page = 1;
//    [self.shiPinListAry removeAllObjects];
//    [self setNetWork:self.page];
//}
//
//- (void)loadMoreTopic {
//    self.page += 1;
//    [self setNetWork:self.page];
//}

- (void)setNetWork
{
    NSDictionary * dic = @{@"key":[UserManager key], @"t_id":[NSString stringWithFormat:@"%ld", self.teacherZaiXianDetailsModel.t_id]};
    [[HttpRequestManager sharedSingleton] POST:indexOnlineGetRelated parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        //结束头部刷新
        [self.shiPinListTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.shiPinListTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *arr = [TeacherZaiXianModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (TeacherZaiXianModel *model in arr) {
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
        self.shiPinListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 200 - APP_NAVH - 40) style:UITableViewStyleGrouped];
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

    TeacherListNCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherListNCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.shiPinListAry.count != 0) {
        TeacherZaiXianModel * model = [self.shiPinListAry objectAtIndex:indexPath.row];
        [cell.TeacherListNImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"缩略图"]];
        cell.TeacherListNTitleLabel.text = model.title;
        if (model.view > 9999) {
            CGFloat num = model.view / 10000;
            cell.TeacherListNBoFangCi.text = [NSString stringWithFormat:@"%.1f万次播放", num];
        }else
        {
            cell.TeacherListNBoFangCi.text = [NSString stringWithFormat:@"%ld次播放", model.view];
            
        }
        cell.TeacherListNFenLeiLabel.text = [NSString stringWithFormat:@"所属分类:%@", model.t_name];
        
        if (model.label.count == 0) {
            cell.TeacherListNOneImg.alpha = 0;
            cell.TeacherListNTwoImg.alpha = 0;
            cell.TeacherListNThreeImg.alpha = 0;
            
            cell.TeacherListNOneLabel.alpha = 0;
            cell.TeacherListNTwoLabel.alpha = 0;
            cell.TeacherListNThreeLabel.alpha = 0;
        }else if (model.label.count == 1)
        {
            cell.TeacherListNOneImg.alpha = 1;
            cell.TeacherListNTwoImg.alpha = 0;
            cell.TeacherListNThreeImg.alpha = 0;
            
            cell.TeacherListNOneLabel.alpha = 1;
            cell.TeacherListNTwoLabel.alpha = 0;
            cell.TeacherListNThreeLabel.alpha = 0;
            cell.TeacherListNOneLabel.text = [model.label objectAtIndex:0];
            
        }else if (model.label.count == 2)
        {
            cell.TeacherListNOneImg.alpha = 1;
            cell.TeacherListNTwoImg.alpha = 1;
            cell.TeacherListNThreeImg.alpha = 0;
            
            cell.TeacherListNOneLabel.alpha = 1;
            cell.TeacherListNTwoLabel.alpha = 1;
            cell.TeacherListNThreeLabel.alpha = 0;
            cell.TeacherListNOneLabel.text = [model.label objectAtIndex:0];
            cell.TeacherListNTwoLabel.text = [model.label objectAtIndex:1];
        }else if (model.label.count == 3)
        {
            cell.TeacherListNOneImg.alpha = 1;
            cell.TeacherListNTwoImg.alpha = 1;
            cell.TeacherListNThreeImg.alpha = 1;
            
            cell.TeacherListNOneLabel.alpha = 1;
            cell.TeacherListNTwoLabel.alpha = 1;
            cell.TeacherListNThreeLabel.alpha = 1;
            cell.TeacherListNOneLabel.text = [model.label objectAtIndex:0];
            cell.TeacherListNTwoLabel.text = [model.label objectAtIndex:1];
            cell.TeacherListNThreeLabel.text = [model.label objectAtIndex:2];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shiPinListAry.count != 0) {
        TeacherZaiXianModel * model = [self.shiPinListAry objectAtIndex:indexPath.row];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shipinListBoFang" object:@{@"SchoolDongTaiModel":model}];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
    
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
