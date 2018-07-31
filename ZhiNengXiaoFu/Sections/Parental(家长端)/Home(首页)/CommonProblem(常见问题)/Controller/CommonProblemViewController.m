//
//  CommonProblemViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "CommonProblemViewController.h"


@interface CommonProblemViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *CommonProblemsTableView;
@property (nonatomic, strong) NSMutableArray *CommonProblemsArr;
@end

@implementation CommonProblemViewController


- (NSMutableArray *)CommonProblemsArr {
    if (!_CommonProblemsArr) {
        self.CommonProblemsArr = [NSMutableArray array];
    }
    return _CommonProblemsArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"竞技活动";
    self.view.backgroundColor = backColor;
    
    NSMutableArray *timeArr = [NSMutableArray arrayWithObjects:@"2017.10.21",@"2017.10.20",@"2017.10.19", nil];
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"赤水一中学生才艺大赛",@"中学生知识竞赛活动",@"初中生数学竞赛", nil];
    NSMutableArray *contentArr = [NSMutableArray arrayWithObjects:@"营造优美的校园环境。学校是学生的第二个家，学生从学校中不知不觉地接受教育和影响，因此，优雅、洁净、文明、舒适的校园环境能给学生“润物细无声”的良好心理影响。校园中亭阁假山、名人雕像、书画长廊、名人名言、校风校训以及各种宣传橱窗都会给学生美的享受和理性的思考。生物园里生机盎然，校园里繁花点点，绿草茵茵，学生在曲径廊亭中看书，这些自然风景和人文景观无时无刻不在触动着学生的感官，使学生受到了美的熏陶和道德的感染，在愉悦中受到教育，自觉地形成一种积极向上的心态。",@"营造优美的校园环境。学校是学生的第二个家，学生从学校中不知不觉地接受教育和影响，因此，优雅、洁净、文明、舒适的校园环境能给学生“润物细无声”的良好心理影响。校园中亭阁假山、名人雕像、书画长廊、名人名言、校风校训以及各种宣传橱窗都会给学生美的享受和理性的思考。生物园里生机盎然，校园里繁花点点，绿草茵茵，学生在曲径廊亭中看书，这些自然风景和人文景观无时无刻不在触动着学生的感官，使学生受到了美的熏陶和道德的感染，在愉悦中受到教育，自觉地形成一种积极向上的心态。",@"营造优美的校园环境。学校是学生的第二个家，学生从学校中不知不觉地接受教育和影响，因此，优雅、洁净、文明、舒适的校园环境能给学生“润物细无声”的良好心理影响。校园中亭阁假山、名人雕像、书画长廊、名人名言、校风校训以及各种宣传橱窗都会给学生美的享受和理性的思考。生物园里生机盎然，校园里繁花点点，绿草茵茵，学生在曲径廊亭中看书，这些自然风景和人文景观无时无刻不在触动着学生的感官，使学生受到了美的熏陶和道德的感染，在愉悦中受到教育，自觉地形成一种积极向上的心态。", nil];
    
    for (int i = 0; i < titleArr.count; i++) {
        NSString *time  = [timeArr objectAtIndex:i];
        NSString *title = [titleArr objectAtIndex:i];
        NSString *content = [contentArr objectAtIndex:i];
        NSDictionary * dic = @{@"time":time,@"title":title,@"content":content};
        [self.CommonProblemsArr addObject:dic];
    }
    
    [self.view addSubview:self.CommonProblemsTableView];
    self.CommonProblemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    switch (indexPath.row) {
        case 0:
            NSLog(@"点击1");
            break;
        case 1:
            NSLog(@"点击2");
            break;
        case 2:
            NSLog(@"点击3");
            break;
            
        default:
            break;
    }
    
}




- (UITableView *)CommonProblemsTableView {
    if (!_CommonProblemsTableView) {
        self.CommonProblemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_TABH) style:UITableViewStyleGrouped];
        self.CommonProblemsTableView.delegate = self;
        self.CommonProblemsTableView.dataSource = self;
    }
    return _CommonProblemsTableView;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 3;
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
        } else {
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
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 170;
    } else {
        return 250;
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
