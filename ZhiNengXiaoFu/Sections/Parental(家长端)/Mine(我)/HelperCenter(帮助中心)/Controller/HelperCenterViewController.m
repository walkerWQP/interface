//
//  HelperCenterViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HelperCenterViewController.h"
#import "ClassHomePageItemCell.h"
#import "AdviceFeedbackViewController.h"
#import "HelperCenterModel.h"

@interface HelperCenterViewController ()<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, strong) UITableView * HelperCenterTableView;
@property (nonatomic, strong) NSMutableArray * HelperCenterAry;
@property (nonatomic, strong) HelperCenterModel * helperCenterModel;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIView * back;

@property (nonatomic, strong) NSMutableArray *bannerArr;

@end

@implementation HelperCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"帮助中心";

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.HelperCenterTableView];
    [self.HelperCenterTableView registerClass:[ClassHomePageItemCell class] forCellReuseIdentifier:@"ClassHomePageItemCellId"];
    self.HelperCenterTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self setNetWork];
    
    [self getBannersURLData];

}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}


- (void)getBannersURLData {
    NSDictionary *dic = @{@"key":[UserManager key],@"t_id":@"7"};
    NSLog(@"%@",[UserManager key]);
    [[HttpRequestManager sharedSingleton] POST:bannersURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            
            [self.HelperCenterTableView reloadData];
            
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)setNetWork
{
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:userContactUs parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.helperCenterModel = [HelperCenterModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
        NSLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (NSMutableArray *)HelperCenterAry
{
    if (!_HelperCenterAry) {
        self.HelperCenterAry = [@[]mutableCopy];
    }
    return _HelperCenterAry;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 2;
    }else if (section == 2)
    {
        return 1;
    }else
    {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
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
        if (self.bannerArr.count == 0) {
            //            imgs.image = [UIImage imageNamed:@"教师端活动管理banner"];
        } else {
            BannerModel * model = [self.bannerArr objectAtIndex:0];
            [imgs sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"bannerHelper"]];
        }
        [cell addSubview:imgs];
        return cell;
    }else
    {
        ClassHomePageItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassHomePageItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.itemImg.image = [UIImage imageNamed:@"拨打电话家长"];
                cell.itemLabel.text = @"拨打电话";
            }else
            {
                cell.itemImg.image = [UIImage imageNamed:@"QQ电话"];
                cell.itemLabel.text = @"QQ电话";
            }
        }else if (indexPath.section == 2)
        {
            cell.itemImg.image = [UIImage imageNamed:@"关注我们"];
            cell.itemLabel.text = @"关注我们";
        }else
        {
            cell.itemImg.image = [UIImage imageNamed:@"建议反馈1"];
            cell.itemLabel.text = @"建议与反馈";
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1)
    {
        return 40;
    }else if (section == 2)
    {
        return 40;
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
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        headerView.backgroundColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
        
        UIImageView * titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 16, 16)];
        [headerView addSubview:titleImg];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImg.frame.origin.x + titleImg.frame.size.width + 10, 10, 100, 20)];
        titleLabel.font = [UIFont systemFontOfSize: 16];
        titleLabel.textColor = COLOR(51, 51, 51, 1);
        [headerView addSubview:titleLabel];
        if (section == 1) {
            titleLabel.text = @"联系我们";
            titleImg.image = [UIImage imageNamed:@"联系我们家长"];
        }else if (section == 2)
        {
            titleLabel.text = @"关注我们";
            titleImg.image = [UIImage imageNamed:@"关注我们家长"];

        }else
        {
             titleLabel.text = @"建议反馈";
             titleImg.image = [UIImage imageNamed:@"建议反馈家长"];
        }
        return headerView;
    }
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UITableView *)HelperCenterTableView
{
    if (!_HelperCenterTableView) {
        self.HelperCenterTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.HelperCenterTableView.dataSource = self;
        self.HelperCenterTableView.delegate = self;
    }
    return _HelperCenterTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 170;
    }else if (indexPath.section == 1)
    {
        return 50;
    }else if (indexPath.section == 2)
    {
        return 50;
    }else
    {
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    
    switch (indexPath.section) {
        case 1:
        {
            if (indexPath.row == 0) {
                NSLog(@"拨打电话");
                
                if (_webView == nil) {
                    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
                }
                [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.helperCenterModel.phone]]]];
            }
            
            if (indexPath.row == 1) {
                NSLog(@"qq联系");
                UIWebView *webView = [[UIWebView alloc] init];
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web", self.helperCenterModel.qq]];
                
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                webView.delegate = self;
                
                [webView loadRequest:request];
                
                [self.view addSubview:webView];
            }
        }
            break;
        case 2:
        {
            NSLog(@"关注我们");
            self.back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
            self.back.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.8];
            [[[UIApplication sharedApplication] keyWindow] addSubview:self.back];
            
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 100, kScreenHeight / 2 - 100, 200, 200)];
            [img sd_setImageWithURL:[NSURL URLWithString:self.helperCenterModel.wx] placeholderImage:nil];
            [self.back addSubview:img];
            
            UITapGestureRecognizer * imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
            self.back.userInteractionEnabled = YES;
            [self.back addGestureRecognizer:imgTap];
            
        }
            break;
        case 3:
        {
            NSLog(@"建议与反馈");
            AdviceFeedbackViewController *adviceFeedbackVC = [[AdviceFeedbackViewController alloc] init];
            [self.navigationController pushViewController:adviceFeedbackVC animated:YES];
        }
            break;
            
            
        default:
            break;
    }
    
}

- (void)imgTap:(UITapGestureRecognizer *)sender
{
    [self.back removeFromSuperview];
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
