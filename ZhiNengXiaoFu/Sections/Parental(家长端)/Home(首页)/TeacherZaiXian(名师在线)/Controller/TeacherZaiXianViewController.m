//
//  TeacherZaiXianViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TeacherZaiXianViewController.h"
#import "TeacherZhuanLanCell.h"
#import "TeacherZaiXianDetailsViewController.h"
#import "TeacherZaiXianModel.h"
@interface TeacherZaiXianViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * TeacherZaiXianTableView;
@property (nonatomic, strong) NSMutableArray * TeacherZaiXianAry;
@property (nonatomic, assign) NSInteger     page;

@end

@implementation TeacherZaiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"名师在线";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.TeacherZaiXianTableView];
    self.TeacherZaiXianTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.TeacherZaiXianTableView registerClass:[TeacherZhuanLanCell class] forCellReuseIdentifier:@"TeacherZhuanLanCellId"];
    
//    [self setNetWork];
    
    //下拉刷新
    self.TeacherZaiXianTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    //自动更改透明度
    self.TeacherZaiXianTableView.mj_header.automaticallyChangeAlpha = YES;
    //进入刷新状态
    [self.TeacherZaiXianTableView.mj_header beginRefreshing];
    //上拉刷新
    self.TeacherZaiXianTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

- (void)loadNewTopic {
    self.page = 1;
    [self.TeacherZaiXianAry removeAllObjects];
    [self setNetWork:self.page];
}

- (void)loadMoreTopic {
    self.page += 1;
    [self setNetWork:self.page];
}

- (void)setNetWork:(NSInteger)page
{
    NSDictionary * dic = @{@"key":[UserManager key], @"page":[NSString stringWithFormat:@"%ld",page]};
    [[HttpRequestManager sharedSingleton] POST:onlineVideoList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //结束头部刷新
        [self.TeacherZaiXianTableView.mj_header endRefreshing];
        //结束尾部刷新
        [self.TeacherZaiXianTableView.mj_footer endRefreshing];
        if ([[responseObject objectForKey:@"status"] integerValue] == 200)
        {
            NSMutableArray *arr = [TeacherZaiXianModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (TeacherZaiXianModel *model in arr) {
                [self.TeacherZaiXianAry addObject:model];
            }
            
            
            [self.TeacherZaiXianTableView reloadData];
            
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

- (NSMutableArray *)TeacherZaiXianAry
{
    if (!_TeacherZaiXianAry) {
        self.TeacherZaiXianAry = [@[]mutableCopy];
    }
    return _TeacherZaiXianAry;
}

- (UITableView *)TeacherZaiXianTableView
{
    if (!_TeacherZaiXianTableView) {
        self.TeacherZaiXianTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.TeacherZaiXianTableView.delegate = self;
        self.TeacherZaiXianTableView.dataSource = self;
    }
    return _TeacherZaiXianTableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
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
        UIView * teacherZhuanLanView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        teacherZhuanLanView.backgroundColor = [UIColor whiteColor];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        lineView.backgroundColor = COLOR(247, 247, 247, 1);
        [teacherZhuanLanView addSubview:lineView];
        
        UIImageView * teacherZhuanLanImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 16, 16)];
        teacherZhuanLanImg.image = [UIImage imageNamed:@"名师专栏"];
        [teacherZhuanLanView addSubview:teacherZhuanLanImg];
        
        
        UILabel * teacherZhuanLanLabel = [[UILabel alloc] initWithFrame:CGRectMake(teacherZhuanLanImg.frame.origin.x + teacherZhuanLanImg.frame.size.width + 10, 18, 70, 20)];
        teacherZhuanLanLabel.text = @"名师专栏";
        teacherZhuanLanLabel.font = [UIFont systemFontOfSize:14];
        teacherZhuanLanLabel.textColor = [UIColor blackColor];
        [teacherZhuanLanView addSubview:teacherZhuanLanLabel];

        return teacherZhuanLanView;
    }
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
        return self.TeacherZaiXianAry.count;
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
        imgs.image = [UIImage imageNamed:@"banner"];
        [cell addSubview:imgs];
        return cell;
    }else
    {
        TeacherZhuanLanCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherZhuanLanCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.TeacherZaiXianAry.count != 0) {
            TeacherZaiXianModel * model = [self.TeacherZaiXianAry objectAtIndex:indexPath.row];
            [cell.UserIcon sd_setImageWithURL:[NSURL URLWithString:model.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
            cell.UserName.text = model.name;
            cell.titleLabel.text = model.title;
            cell.subTitleLabel.text = model.honor;
            cell.timeLabel.text = model.create_time;
            if (model.is_charge == 1) {
                cell.stateLabel.text = @"收费课";
            }else
            {
                cell.stateLabel.text = @"公开课";
                
            }
        }
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }else
    {
        return 90;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (self.TeacherZaiXianAry.count != 0) {
            TeacherZaiXianDetailsViewController * teacherZaiXianDetailsVC = [[TeacherZaiXianDetailsViewController alloc] init];
            TeacherZaiXianModel * model = [self.TeacherZaiXianAry objectAtIndex:indexPath.row];
            teacherZaiXianDetailsVC.teacherZaiXianDetailsId = model.ID;
            [self.navigationController pushViewController:teacherZaiXianDetailsVC animated:YES];
        }
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
