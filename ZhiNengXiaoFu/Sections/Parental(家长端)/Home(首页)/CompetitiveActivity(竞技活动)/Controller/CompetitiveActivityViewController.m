//
//  CompetitiveActivityViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "CompetitiveActivityViewController.h"
#import "JingJiActivityCell.h"
#import "JingJiActivityDetailsViewController.h"
@interface CompetitiveActivityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *athleticActivitiesTableView;
@property (nonatomic, strong) NSMutableArray *athleticActivitiesArr;
@end

@implementation CompetitiveActivityViewController

- (NSMutableArray *)athleticActivitiesArr {
    if (!_athleticActivitiesArr) {
        self.athleticActivitiesArr = [NSMutableArray array];
    }
    return _athleticActivitiesArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"竞技活动";
    self.view.backgroundColor = COLOR(246, 246, 246, 1);
    
    NSMutableArray *timeArr = [NSMutableArray arrayWithObjects:@"2017.10.21",@"2017.10.20",@"2017.10.19", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"赤水一中学生才艺大赛",@"中学生知识竞赛活动",@"初中生数学竞赛", nil];
    NSMutableArray *contentArr = [NSMutableArray arrayWithObjects:@"营造优美的校园环境。学校是学生的第二个家，学生从学校中不知不觉地接受教育和影响，因此，优雅、洁净、文明、舒适的校园环境能给学生“润物细无声”的良好心理影响。校园中亭阁假山、名人雕像、书画长廊、名人名言、校风校训以及各种宣传橱窗都会给学生美的享受和理性的思考。生物园里生机盎然，校园里繁花点点，绿草茵茵，学生在曲径廊亭中看书，这些自然风景和人文景观无时无刻不在触动着学生的感官，使学生受到了美的熏陶和道德的感染，在愉悦中受到教育，自觉地形成一种积极向上的心态。",@"营造优美的校园环境。学校是学生的第二个家，学生从学校中不知不觉地接受教育和影响，因此，优雅、洁净、文明、舒适的校园环境能给学生“润物细无声”的良好心理影响。校园中亭阁假山、名人雕像、书画长廊、名人名言、校风校训以及各种宣传橱窗都会给学生美的享受和理性的思考。生物园里生机盎然，校园里繁花点点，绿草茵茵，学生在曲径廊亭中看书，这些自然风景和人文景观无时无刻不在触动着学生的感官，使学生受到了美的熏陶和道德的感染，在愉悦中受到教育，自觉地形成一种积极向上的心态。",@"营造优美的校园环境。学校是学生的第二个家，学生从学校中不知不觉地接受教育和影响，因此，优雅、洁净、文明、舒适的校园环境能给学生“润物细无声”的良好心理影响。校园中亭阁假山、名人雕像、书画长廊、名人名言、校风校训以及各种宣传橱窗都会给学生美的享受和理性的思考。生物园里生机盎然，校园里繁花点点，绿草茵茵，学生在曲径廊亭中看书，这些自然风景和人文景观无时无刻不在触动着学生的感官，使学生受到了美的熏陶和道德的感染，在愉悦中受到教育，自觉地形成一种积极向上的心态。", nil];
    
    for (int i = 0; i < titleArr.count; i++) {
        NSString *time  = [timeArr objectAtIndex:i];
        NSString *title = [titleArr objectAtIndex:i];
        NSString *content = [contentArr objectAtIndex:i];
        NSDictionary * dic = @{@"time":time,@"title":title,@"content":content};
        [self.athleticActivitiesArr addObject:dic];
    }
    
    [self.view addSubview:self.athleticActivitiesTableView];
    
    
    
    self.athleticActivitiesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.athleticActivitiesTableView registerClass:[JingJiActivityCell class] forCellReuseIdentifier:@"JingJiActivityCellId"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    JingJiActivityDetailsViewController * jingJiAc = [[JingJiActivityDetailsViewController alloc] init];
    [self.navigationController pushViewController:jingJiAc animated:YES];
    
}




- (UITableView *)athleticActivitiesTableView {
    if (!_athleticActivitiesTableView) {
        self.athleticActivitiesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_TABH) style:UITableViewStyleGrouped];
        self.athleticActivitiesTableView.backgroundColor = COLOR(246, 246, 246, 1);
        self.athleticActivitiesTableView.delegate = self;
        self.athleticActivitiesTableView.dataSource = self;
    }
    return _athleticActivitiesTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JingJiActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JingJiActivityCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary  * dic = [self.athleticActivitiesArr objectAtIndex:indexPath.row];
    cell.timeLabel.text = [dic objectForKey:@"time"];
    cell.titleLabel.text = [dic objectForKey:@"title"];
    cell.connectLabel.text = [dic objectForKey:@"content"];
    cell.chakanDetaislLabel.text = @"查看详情";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
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
