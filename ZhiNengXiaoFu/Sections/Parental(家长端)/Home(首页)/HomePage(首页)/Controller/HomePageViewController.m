//
//  HomePageViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomePageViewController.h"
#import "PrefixHeader.pch"
#import "HomePageLunBoCell.h"
#import "HomePageItemCell.h"
#import "UIImageView+WebCache.h"
#import "SchoolTongZhiViewController.h"
#import "TeacherTongZhiViewController.h"
#import "HomeWorkPViewController.h"
#import "SchoolDongTaiViewController.h"
#import "CompetitiveActivityViewController.h"
#import "TongZhiViewController.h"
#import "TeacherZaiXianViewController.h"
#import "ParentXueTangViewController.h"
#import "WenTiZiXunViewController.h"
#import "GrowthAlbumViewController.h"
#import "CourseManagementViewController.h"
#import "ChengZhangXiangCeViewController.h"

@interface HomePageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * HomePageCollectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSMutableArray * homePageAry;
@property (nonatomic, assign) NSInteger force;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.HomePageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:self.layout];

    self.HomePageCollectionView.backgroundColor = [UIColor whiteColor];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:173/ 255.0 green:228 / 255.0 blue: 211 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.HomePageCollectionView.delegate = self;
    self.HomePageCollectionView.dataSource = self;
    [self.view addSubview:self.HomePageCollectionView];
    
    [self.HomePageCollectionView registerClass:[HomePageLunBoCell class] forCellWithReuseIdentifier:@"HomePageLunBoCellId"];
    [self.HomePageCollectionView registerClass:[HomePageItemCell class] forCellWithReuseIdentifier:@"HomePageItemCellId"];
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"通知",@"作业",@"课堂查询",@"成长手册",@"名师在线",@"家长学堂",@"问题咨询",@"竞技活动",@"学校动态", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"通知",@"作业",@"右脑开发",@"成长相册",@"名师在线",@"家长学堂",@"问题咨询",@"竞技活动",@"学校动态", nil];

    for (int i = 0; i < imgAry.count; i++)
    {
        NSString * img  = [imgAry objectAtIndex:i];
        NSString * title = [TitleAry objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title};
        [self.homePageAry addObject:dic];
    }
    
   
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qiangzhiGengXin:) name:@"qiangzhiGengXin" object:nil];
//    [self setHuoQuShangXianBanBen];
}

//- (void)qiangzhiGengXin:(NSNotification *)nofity
//{
//}

//- (void)setHuoQuShangXianBanBen
//{
//    NSDictionary * dic = @{@"system":@"2"};
//    [[HttpRequestManager sharedSingleton] POST:versionGetVersion parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@", responseObject);
//        //一句代码实现检测更新
//        self.force = [[[responseObject objectForKey:@"data"] objectForKey:@"force"] integerValue];
//
//        [self hsUpdateApp:[[responseObject objectForKey:@"data"] objectForKey:@"version"] force:[[[responseObject objectForKey:@"data"] objectForKey:@"force"] integerValue]];
//        
//        [SingletonHelper manager].version = [[responseObject objectForKey:@"data"] objectForKey:@"version"];
//        [SingletonHelper manager].force = [[[responseObject objectForKey:@"data"] objectForKey:@"force"] integerValue];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@", error);
//    }];
//}
//
///**
// *  天朝专用检测app更新
// */
//-(void)hsUpdateApp:(NSString *)version  force:(NSInteger)force
//{
//    //2先获取当前工程项目版本号
//    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion=[infoDic[@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"."withString:@""];
//    
//    NSString * versinNew  = [version stringByReplacingOccurrencesOfString:@"."withString:@""];
//    //3从网络获取appStore版本号
//    
//        if([currentVersion integerValue] < [versinNew integerValue])
//        {
//            [self setGengXinNeiRon:force];
//            
//        }else{
//            NSLog(@"版本号好像比商店大噢!检测到不需要更新");
//        }
//   
//}
//
//- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (self.force == 1) {
//        if(buttonIndex==0)
//        {
//            //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    }else
//    {
//        //5实现跳转到应用商店进行更新
//        if(buttonIndex==1)
//        {
//            //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
//            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    
//    }
//}
//
//- (void)setGengXinNeiRon:(NSInteger)force
//{
//    if (force == 1) {
//        UIAlertView * neironAlertView = [[UIAlertView alloc] initWithTitle:@"版本有更新,请前往appstore下载" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [neironAlertView show];
//    }else
//    {
//         UIAlertView * neironAlertView = [[UIAlertView alloc] initWithTitle:@"版本有更新,请前往appstore下载" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [neironAlertView show];
//    }
//
//}

- (NSMutableArray *)homePageAry
{
    if (!_homePageAry) {
        self.homePageAry = [@[]mutableCopy];
    }
    return _homePageAry;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        return self.homePageAry.count;
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        HomePageLunBoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageLunBoCellId" forIndexPath:indexPath];
        return cell;
    }else
    {
        HomePageItemCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageItemCellId" forIndexPath:indexPath];
        NSDictionary * dic = [self.homePageAry objectAtIndex:indexPath.row];
        cell.itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
        cell.titleLabel.text = [dic objectForKey:@"title"];
        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (kScreenWidth == 414) {
            return CGSizeMake(kScreenWidth, 200);
            
        }else
        {
            return CGSizeMake(kScreenWidth, 170);
        }
    }else
    {
        return CGSizeMake((kScreenWidth  - 30 )/ 3, 100);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else
    {
        if (indexPath.row == 0) {
            TongZhiViewController * teacherTongZhiVC = [[TongZhiViewController alloc] init];
            [self.navigationController pushViewController:teacherTongZhiVC animated:YES];
        }else if (indexPath.row == 1)
        {
            HomeWorkPViewController * homeWorkVC = [[HomeWorkPViewController alloc] init];
            [self.navigationController pushViewController:homeWorkVC animated:YES];
        }else if (indexPath.row == 2)
        {
            CourseManagementViewController *courseManagementVC = [[CourseManagementViewController alloc] init];
            [self.navigationController pushViewController:courseManagementVC animated:YES];
        }else if (indexPath.row == 3)
        {
            ChengZhangXiangCeViewController * chengzhang = [[ChengZhangXiangCeViewController alloc] init];
            [self.navigationController pushViewController:chengzhang animated:YES];

        }else if (indexPath.row == 4)
        {
            TeacherZaiXianViewController * teacherZaiXianVC = [[TeacherZaiXianViewController alloc] init];
            [self.navigationController pushViewController:teacherZaiXianVC animated:YES];
        }else if (indexPath.row == 5) {
           ParentXueTangViewController * parentXueTangVC = [[ParentXueTangViewController alloc] init];
            [self.navigationController pushViewController:parentXueTangVC animated:YES];
        }else if (indexPath.row == 6)
        {
            WenTiZiXunViewController * wenTiZiXunVC = [[WenTiZiXunViewController alloc] init];
            [self.navigationController pushViewController:wenTiZiXunVC animated:YES];
        }else if (indexPath.row == 7)
        {
            CompetitiveActivityViewController * comeptitiveActivityVC = [[CompetitiveActivityViewController alloc] init];
            [self.navigationController pushViewController:comeptitiveActivityVC animated:YES];
        }else if (indexPath.row == 8)
        {
            SchoolDongTaiViewController * schoolDongTaiVC = [[SchoolDongTaiViewController alloc] init];
            [self.navigationController pushViewController:schoolDongTaiVC animated:YES];
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
