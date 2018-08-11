//
//  HomeViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/23.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeLunBoCell.h"
#import "HomeItemCell.h"
#import "SchoolDynamicViewController.h"
#import "SchoolNoticeViewController.h"
#import "ConsultingViewController.h"
#import "ActivityManagementViewController.h"
#import "UploadVideoViewController.h"
#import "GrowthAlbumViewController.h"
#import "CourseManagementViewController.h"
#import "JobManagementViewController.h"
#import "TeacherNotifiedViewController.h"
#import "TongZhiViewController.h"
#import "PublishJobModel.h"


@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * HomeCollectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout * layout;
@property (nonatomic, strong) NSMutableArray * homePageAry;
@property (nonatomic, strong) NSMutableArray *publishJobArr;

@end

@implementation HomeViewController

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (NSMutableArray *)homePageAry {
    if (!_homePageAry) {
        _homePageAry = [NSMutableArray array];
    }
    return _homePageAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = backColor;
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.HomeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH) collectionViewLayout:self.layout];
    self.HomeCollectionView.backgroundColor = backColor;
    self.HomeCollectionView.delegate = self;
    self.HomeCollectionView.dataSource = self;
    [self.view addSubview:self.HomeCollectionView];
    
    [self.HomeCollectionView registerClass:[HomeLunBoCell class] forCellWithReuseIdentifier:@"HomePageLunBoCellId"];
    [self.HomeCollectionView registerClass:[HomeItemCell class] forCellWithReuseIdentifier:@"HomePageItemCellId"];
    
    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"老师通知",@"作业管理",@"课程管理",@"成长相册",@"视频上传",@"活动管理",@"问题咨询",@"学校通知",@"学校动态1", nil];
    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"老师通知",@"作业管理",@"右脑开发",@"成长相册",@"名师在线",@"活动管理",@"问题咨询",@"学校通知",@"学校动态", nil];
    
    for (int i = 0; i < imgAry.count; i++) {
        NSString * img  = [imgAry objectAtIndex:i];
        NSString * title = [TitleAry objectAtIndex:i];
        NSDictionary * dic = @{@"img":img, @"title":title};
        [self.homePageAry addObject:dic];
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.homePageAry.count;
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HomeLunBoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageLunBoCellId" forIndexPath:indexPath];
        return cell;
    } else {
        HomeItemCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageItemCellId" forIndexPath:indexPath];
        NSDictionary * dic = [self.homePageAry objectAtIndex:indexPath.row];
        cell.itemImg.image = [UIImage imageNamed:[dic objectForKey:@"img"]];
        cell.titleLabel.text = [dic objectForKey:@"title"];
        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (kScreenWidth == 414) {
            return CGSizeMake(kScreenWidth, 200);
            
        } else {
            return CGSizeMake(kScreenWidth, 170);
        }
    } else {
        return CGSizeMake((kScreenWidth  - 30 )/ 3, 100);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {

    } else {
        
        switch (indexPath.row) {
            case 0:
            {
                NSLog(@"点击老师通知");
                TeacherNotifiedViewController *teacherNotifiedVC = [[TeacherNotifiedViewController alloc] init];
                [self.navigationController pushViewController:teacherNotifiedVC animated:YES];
                
            }
                break;
            case 1:
            {
                NSLog(@"点击作业管理");
                JobManagementViewController *jobManagementVC = [[JobManagementViewController alloc] init];
                [self.navigationController pushViewController:jobManagementVC animated:YES];
                
            }
                break;
            case 2:
            {
                NSLog(@"点击课程管理");
                CourseManagementViewController *courseManagementVC = [[CourseManagementViewController alloc] init];
                [self.navigationController pushViewController:courseManagementVC animated:YES];
                
            }
                break;
            case 3:
            {
                NSLog(@"点击成长相册");
                [self getClassURLData];
                
            }
                break;
            case 4:
            {
                NSLog(@"点击视频上传");
                UploadVideoViewController *uploadVideoVC = [[UploadVideoViewController alloc] init];
                [self.navigationController pushViewController:uploadVideoVC animated:YES];
                
            }
                break;
            case 5:
            {
                NSLog(@"点击活动管理");
                ActivityManagementViewController *activityManagementVC = [[ActivityManagementViewController alloc] init];
                [self.navigationController pushViewController:activityManagementVC animated:YES];
                
                
            }
                break;
            case 6:
            {
                NSLog(@"点击问题咨询");
                ConsultingViewController *consultingVC = [[ConsultingViewController alloc] init];
                [self.navigationController pushViewController:consultingVC animated:YES];
                
            }
                break;
            case 7:
            {
                NSLog(@"点击学校通知");
                SchoolNoticeViewController *schoolNoticeVC = [[SchoolNoticeViewController alloc] init];
                [self.navigationController pushViewController:schoolNoticeVC animated:YES];
//                TongZhiViewController *tongZhiVC = [[TongZhiViewController alloc] init];
//                tongZhiVC.teacherID = @"2";
//                [self.navigationController pushViewController:tongZhiVC animated:YES];
               
            }
                break;
            case 8:
            {
                NSLog(@"点击学校动态");
                SchoolDynamicViewController *schoolDynamicVC = [[SchoolDynamicViewController alloc] init];
                [self.navigationController pushViewController:schoolDynamicVC animated:YES];

            }
                break;
                
            default:
                break;
        }
        
    }
    
}

- (void)postDataForGetURL:(NSString *)classID {
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":classID};
    [[HttpRequestManager sharedSingleton] POST:getURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSString *url = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
            GrowthAlbumViewController *growthAlbumVC = [[GrowthAlbumViewController alloc] init];
            if (url == nil) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                growthAlbumVC.urlStr = url;
                growthAlbumVC.webTitle = @"成长相册";
                [self.navigationController pushViewController:growthAlbumVC animated:YES];
            }
           
            
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

- (void)getClassURLData {
    
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.ID]];
            }
            NSLog(@"%@",ary[0]);
            if (ary[0] == nil) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [self postDataForGetURL:ary[0]];
            }
            
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
