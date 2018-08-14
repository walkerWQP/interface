//
//  KeChengJieShaoViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "KeChengJieShaoViewController.h"
#import "KeChengJieShaonCell.h"
@interface KeChengJieShaoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * KeChengJieShaoTableView;


@end

@implementation KeChengJieShaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.\
    
    self.KeChengJieShaoTableView.delegate = self;
    self.KeChengJieShaoTableView.dataSource = self;
    
    [self.view addSubview:self.KeChengJieShaoTableView];
    self.KeChengJieShaoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.KeChengJieShaoTableView registerNib:[UINib nibWithNibName:@"KeChengJieShaonCell" bundle:nil] forCellReuseIdentifier:@"KeChengJieShaonCellId"];
}

- (UITableView *)KeChengJieShaoTableView
{
    if (!_KeChengJieShaoTableView) {
        self.KeChengJieShaoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.KeChengJieShaoTableView.delegate = self;
        self.KeChengJieShaoTableView.dataSource = self;
    }
    return _KeChengJieShaoTableView;
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
    return 1;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    KeChengJieShaonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"KeChengJieShaonCellId" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:self.teacherZaiXianDetailsModel.head_img] placeholderImage:[UIImage imageNamed:@"user"]];
    cell.userNName.text = self.teacherZaiXianDetailsModel.name;
    cell.jieShaoLabel.text = self.teacherZaiXianDetailsModel.honor;
    cell.shanChangConnectLabel.text = self.teacherZaiXianDetailsModel.introduce;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger width = kScreenWidth - 30;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize size = [self.teacherZaiXianDetailsModel.introduce boundingRectWithSize:CGSizeMake(width, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return 150 + size.height;
    
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
