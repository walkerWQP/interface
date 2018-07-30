//
//  ClassViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassHomePageItemCell.h"

@interface ClassViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *classTableView;
@property (nonatomic, strong) NSMutableArray * classArr;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.classTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    self.view.backgroundColor = backColor;
    self.title = @"班级";
   
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"icon_class_info",@"c1",@"c2",@"icon_password", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"班级信息",@"考试成绩",@"班内消息",@"锁定信息", nil];
    
    for (int i = 0; i < imgAry.count; i++) {
        NSString * img  = [imgAry objectAtIndex:i];
        NSString * title = [TitleAry objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title};
        [self.classHomePageAry addObject:dic];
    }
    
    [self.view addSubview:self.classTableView];
    
    [self.classTableView registerClass:[ClassHomePageItemCell class] forCellReuseIdentifier:@"ClassHomePageItemCell1Id"];
    self.classTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSMutableArray *)classHomePageAry {
    if (!_classArr) {
        self.classArr = [@[]mutableCopy];
    }
    return _classArr;
}


- (UITableView *)classTableView {
    if (!_classTableView) {
        self.classTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.classTableView.delegate = self;
        self.classTableView.dataSource = self;
        self.classTableView.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _classTableView;
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
        return 4;
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
        imgs.image = [UIImage imageNamed:@"homepagelunbo2"];
        [cell addSubview:imgs];
        return cell;
    } else {
        ClassHomePageItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassHomePageItemCell1Id" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary * dic = [self.classHomePageAry objectAtIndex:indexPath.row];
        cell.itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
        cell.itemLabel.text = [dic objectForKey:@"title"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 170;
    } else {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSLog(@"1");
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                NSLog(@"班级信息");
            }
                break;
            case 1:
            {
                NSLog(@"考试成绩");
            }
                break;
            case 2:
            {
                NSLog(@"班级信息");
            }
                break;
            case 3:
            {
                NSLog(@"锁定信息");
            }
                break;
                
            default:
                break;
        }
    }
    
}


@end
