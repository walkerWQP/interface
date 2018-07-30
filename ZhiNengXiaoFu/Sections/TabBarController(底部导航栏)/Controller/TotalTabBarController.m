//
//  TotalTabBarController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TotalTabBarController.h"
//家长端
#import "HomePageViewController.h"
#import "ClassHomeViewController.h"
#import "QianDaoViewController.h"
#import "MineViewController.h"
#import "ChooseHomeViewController.h"
//教师端
#import "HomeViewController.h"
#import "ClassViewController.h"
#import "SignViewController.h"
#import "MyViewController.h"

#import "MainNavigationController.h"

@interface TotalTabBarController ()

@end

@implementation TotalTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"1"]) {
        [[UITabBar appearance] setTintColor:THEMECOLOR];

    }else
    {
        [[UITabBar appearance] setTintColor:TEACHERTHEMECOLOR];

    }

    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"1"]) {
        [self setupChildViewController:@"首页" viewController:[HomeViewController new] image:@"foot1" selectedImage:@"foot1"];
        
        [self setupChildViewController:@"班级" viewController:[ClassViewController new] image:@"foot2" selectedImage:@"foot2"];
        
        [self setupChildViewController:@"签到" viewController:[SignViewController new] image:@"foot3" selectedImage:@"foot3"];
        
        [self setupChildViewController:@"我的" viewController:[MyViewController new] image:@"foot4" selectedImage:@"foot4"];
        
    } else {
        [self setupChildViewController:@"首页" viewController:[HomePageViewController new] image:@"foot1" selectedImage:@"foot1"];
        
        [self setupChildViewController:@"班级信息" viewController:[ClassHomeViewController new] image:@"foot2" selectedImage:@"foot2"];
        
        [self setupChildViewController:@"进出安全" viewController:[QianDaoViewController new] image:@"foot3" selectedImage:@"foot3"];
        
        [self setupChildViewController:@"我的" viewController:[MineViewController new] image:@"foot4" selectedImage:@"foot4"];
    }

}

- (void)setupChildViewController:(NSString *)title viewController:(UIViewController *)controller image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.title = title;
    
    controller.tabBarItem = item;
    MainNavigationController *navController = [[MainNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:navController];
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
