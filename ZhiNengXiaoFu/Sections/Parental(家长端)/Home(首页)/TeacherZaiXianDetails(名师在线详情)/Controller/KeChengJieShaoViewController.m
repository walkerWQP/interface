//
//  KeChengJieShaoViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "KeChengJieShaoViewController.h"
#import "KeChengJieShaoCell.h"
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
    [self.KeChengJieShaoTableView registerClass:[KeChengJieShaoCell class] forCellReuseIdentifier:@"KeChengJieShaoCellId"];
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
  
    KeChengJieShaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"KeChengJieShaoCellId" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.userImg.image = [UIImage imageNamed:@"头像"];
    cell.userNName.text = @"安娜";
    cell.jieShaoLabel.text = @"著名物理学博士";
    cell.shanChangImg.image = [UIImage imageNamed:@"擅长领域"];
    cell.shanChangConnectLabel.text = @"马云，男，1964年9月10日生于浙江省杭州市，祖籍浙江省嵊州市（原嵊县）谷来镇， 阿里巴巴集团主要创始人，现担任阿里巴巴集团董事局主席、日本软银董事、大自然保护协会中国理事会主席兼全球董事会成员、华谊兄弟董事、生命科学突破奖基金会董事、联合国数字合作高级别小组联合主席。 [1-2] 1988年毕业于杭州师范学院外语系，同年担任杭州电子工业学院英文及国际贸易教师，1995年创办中国第一家互联网商业信息发布网站“中国黄页”，1998年出任中国国际电子商务中心国富通信息技术发展有限公司总经理，1999年创办阿里巴巴，并担任阿里集团CEO、董事局主席。";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 800;
    
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
