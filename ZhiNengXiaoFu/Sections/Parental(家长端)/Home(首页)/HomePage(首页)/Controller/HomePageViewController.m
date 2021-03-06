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
#import "TeacherZaiXianTotalViewController.h"
#import "NewGuidelinesViewController.h"
#import "JiuQinGuanLiViewController.h"
#import "HomePageItemNCell.h"
#import "HomePageNumberModel.h"
#import <JPUSHService.h>
#import "NewDynamicsViewController.h"

@interface HomePageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * HomePageCollectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSMutableArray * homePageAry;
@property (nonatomic, assign) NSInteger force;
@property (nonatomic, strong) NSMutableArray * numberAry;
@property (nonatomic, strong) NSString       * schoolName;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUser];
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.HomePageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) collectionViewLayout:self.layout];

    self.HomePageCollectionView.backgroundColor = [UIColor whiteColor];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:173/ 255.0 green:228 / 255.0 blue: 211 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.HomePageCollectionView.delegate = self;
    self.HomePageCollectionView.dataSource = self;
    [self.view addSubview:self.HomePageCollectionView];
    
    [self.HomePageCollectionView registerClass:[HomePageLunBoCell class] forCellWithReuseIdentifier:@"HomePageLunBoCellId"];
//    [self.HomePageCollectionView registerClass:[HomePageItemCell class] forCellWithReuseIdentifier:@"HomePageItemCellId"];
    
    [self.HomePageCollectionView registerNib:[UINib nibWithNibName:@"HomePageItemNCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageItemNCellId"];
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"通知",@"作业",@"成长手册",@"名师在线",@"家长学堂",@"问题咨询",@"竞技活动",@"学校动态",@"新生指南", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"通知",@"作业",@"班级圈",@"名师在线",@"家长学堂",@"问题咨询",@"竞技活动",@"学校动态",@"新生指南",nil];
    
    for (int i = 0; i < imgAry.count; i++)
    {
        NSString * img  = [imgAry objectAtIndex:i];
        NSString * title = [TitleAry objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title};
        [self.homePageAry addObject:dic];
    }
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qiangzhiGengXin:) name:@"qiangzhiGengXin" object:nil];
//    [self setHuoQuShangXianBanBen];
    
    [self pushJiGuangId];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self huoQuNumber];

}

- (NSMutableArray *)numberAry
{
    if (!_numberAry) {
        self.numberAry = [@[]mutableCopy];
    }
    return _numberAry;
}

- (void)huoQuNumber
{
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:UserGetUnreadNumber parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        HomePageNumberModel * model = [HomePageNumberModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        NSString * activity = [[NSString alloc] init];
        if (model.activity > 9) {
            activity = @"9+";
        }else
        {
            activity = [NSString stringWithFormat:@"%ld", model.activity];
        }
        
        NSString * consult = [[NSString alloc] init];
        if (model.consult > 9) {
            consult = @"9+";
        }else
        {
            consult = [NSString stringWithFormat:@"%ld", model.consult];
        }
        
        NSString * dynamic = [[NSString alloc] init];
        if (model.dynamic > 9) {
            dynamic = @"9+";
        }else
        {
            dynamic = [NSString stringWithFormat:@"%ld", model.dynamic];
        }
        
        NSString * homework = [[NSString alloc] init];
        if (model.homework > 9) {
            homework = @"9+";
        }else
        {
            homework = [NSString stringWithFormat:@"%ld", model.homework];
        }
        
        NSString * notice = [[NSString alloc] init];
        if (model.notice > 9) {
            notice = @"9+";
        }else
        {
            notice = [NSString stringWithFormat:@"%ld", model.notice];
        }
        
        
        self.numberAry = [NSMutableArray arrayWithObjects:notice,homework,@"0",@"0",@"0",consult,activity,dynamic,@"0" ,nil];
        
        
//        NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"通知",@"作业",@"成长手册",@"名师在线",@"家长学堂",@"问题咨询",@"竞技活动",@"学校动态",@"新生指南", nil];
//        NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"通知",@"作业",@"成长相册",@"名师在线",@"家长学堂",@"问题咨询",@"竞技活动",@"学校动态",@"新生指南",nil];
//
//        for (int i = 0; i < imgAry.count; i++)
//        {
//            NSString * img  = [imgAry objectAtIndex:i];
//            NSString * title = [TitleAry objectAtIndex:i];
//            NSString * number = [numberAry objectAtIndex:i];
//            NSDictionary * dic = @{@"img":img, @"title":title, @"number":number};
//            [self.homePageAry addObject:dic];
//        }
        
        [self.HomePageCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
        
    }];
}


- (void)pushJiGuangId
{
    [self.HomePageCollectionView reloadData];

   
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSDictionary * dic = [NSDictionary dictionary];
        if (registrationID == nil)
        {
            dic = @{@"push_id":@"", @"system":@"ios", @"key":[UserManager key]};

        }else
        {
            dic = @{@"push_id":registrationID, @"system":@"ios", @"key":[UserManager key]};
        }
        
        [[HttpRequestManager sharedSingleton] POST:UserSavePushId parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"jpushid%@", responseObject);
            
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                
            }else
            {
                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402)
                {
                    [UserManager logoOut];
                    [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];

                }else
                {
                    
                }
                
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    
    }];
}




- (void)unObserveAllNotifications
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidSetupNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidCloseNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidRegisterNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidLoginNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFNetworkDidReceiveMessageNotification
                           object:nil];
    [defaultCenter removeObserver:self
                             name:kJPFServiceErrorNotification
                           object:nil];
}

- (void)networkDidSetup:(NSNotification *)notification
{
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification
{
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification
{
    NSLog(@"%@", [notification userInfo]);
    
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    NSLog(@"已登录");
    
    if ([JPUSHService registrationID]) {
        
        NSLog(@"get RegistrationID");
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification
{
}

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
    
    if (indexPath.section == 0)
    {
        HomePageLunBoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageLunBoCellId" forIndexPath:indexPath];
//        [cell getClassData];
        return cell;
    }else
    {
        HomePageItemNCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageItemNCellId" forIndexPath:indexPath];
        if (self.homePageAry.count != 0) {
            NSDictionary * dic = [self.homePageAry objectAtIndex:indexPath.row];
            
            cell.itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
            cell.titleLabel.text = [dic objectForKey:@"title"];
            
            if (self.numberAry.count > indexPath.row) {
                NSString * str = [self.numberAry objectAtIndex:indexPath.row];
                
                if ([str isEqualToString:@"0"]) {
                    cell.NumberLabel.alpha = 0;
                }else
                {
                    cell.NumberLabel.alpha = 1;
                    cell.NumberLabel.text = str;
                }
            }
        }
        
        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (APP_WIDTH == 414)
        {
            return CGSizeMake(APP_WIDTH, 200);
        }else
        {
            return CGSizeMake(APP_WIDTH, 170);
        }
    }else
    {
        return CGSizeMake((APP_WIDTH  - 30 )/ 3, 100);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else
    {
        if (indexPath.row == 0)
        {
            TongZhiViewController * teacherTongZhiVC = [[TongZhiViewController alloc] init];
            [self.navigationController pushViewController:teacherTongZhiVC animated:YES];
            
        }else if (indexPath.row == 1)
        {
            HomeWorkPViewController * homeWorkVC = [[HomeWorkPViewController alloc] init];
            [self.navigationController pushViewController:homeWorkVC animated:YES];
        }
        
//        else if (indexPath.row == 2)
//        {
//            GrowthAlbumViewController * growthAlbumVC = [[GrowthAlbumViewController alloc] init];
////            CourseManagementViewController *courseManagementVC = [[CourseManagementViewController alloc] init];
//            growthAlbumVC.webTitle = @"右脑开发";
//            growthAlbumVC.urlStr = brainURL;
//            growthAlbumVC.typeID = @"1";
//
//           [self.navigationController pushViewController:growthAlbumVC animated:YES];
//        }
        else if (indexPath.row == 2)
        {
//            ChengZhangXiangCeViewController * chengzhang = [[ChengZhangXiangCeViewController alloc] init];
//            [self.navigationController pushViewController:chengzhang animated:YES];
            NSLog(@"点击成长轨迹");
            NewDynamicsViewController *newDynamicsVC = [NewDynamicsViewController new];
            newDynamicsVC.typeStr = @"1";
            [self.navigationController pushViewController:newDynamicsVC animated:YES];

        }else if (indexPath.row == 3)
        {
            TeacherZaiXianTotalViewController * teacherZaiXianVC = [[TeacherZaiXianTotalViewController alloc] init];
            [self.navigationController pushViewController:teacherZaiXianVC animated:YES];
        }else if (indexPath.row == 4) {
           ParentXueTangViewController * parentXueTangVC = [[ParentXueTangViewController alloc] init];
            [self.navigationController pushViewController:parentXueTangVC animated:YES];
        }else if (indexPath.row == 5)
        {
            WenTiZiXunViewController * wenTiZiXunVC = [[WenTiZiXunViewController alloc] init];
            [self.navigationController pushViewController:wenTiZiXunVC animated:YES];
        }else if (indexPath.row == 6)
        {
            CompetitiveActivityViewController * comeptitiveActivityVC = [[CompetitiveActivityViewController alloc] init];
            [self.navigationController pushViewController:comeptitiveActivityVC animated:YES];
        }else if (indexPath.row == 7)
        {
            SchoolDongTaiViewController * schoolDongTaiVC = [[SchoolDongTaiViewController alloc] init];
            [self.navigationController pushViewController:schoolDongTaiVC animated:YES];
        }else if (indexPath.row == 8)
        {
            NewGuidelinesViewController *newGuidelinesVC = [NewGuidelinesViewController new];
            [self.navigationController pushViewController:newGuidelinesVC animated:YES];
        }
//        else if (indexPath.row == 9)
//        {
//            NSLog(@"点击成长轨迹");
//            NewDynamicsViewController *newDynamicsVC = [NewDynamicsViewController new];
//            newDynamicsVC.typeStr = @"1";
//            [self.navigationController pushViewController:newDynamicsVC animated:YES];
//        }
        
    }
    
}


#pragma mark ======= 获取个人信息数据 =======
- (void)setUser {
    NSDictionary * dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getUserInfoURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.schoolName = [[responseObject objectForKey:@"data"] objectForKey:@"school_name"];
            UILabel  *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.font = [UIFont boldSystemFontOfSize:18];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = self.schoolName; self.navigationItem.titleView = titleLabel;
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
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
