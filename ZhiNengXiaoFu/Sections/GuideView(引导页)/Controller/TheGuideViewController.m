//
//  TheGuideViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#define HMNewfeatureImageCount 3
#import "TheGuideViewController.h"
#import "UIImage+Extension.h"
#import "TotalTabBarController.h"
#import "UIImage+GIF.h"
#import "LoginHomePageViewController.h"
#import "UIView+Frame.h"

@interface TheGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel * tiaoguo;
@end

@implementation TheGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setupPageControl];
    

}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    // 1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i<HMNewfeatureImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"%d.png", i + 1];
        //        //        if (FourInch) { // 4inch  需要手动去加载4inch对应的-568h图片
        //        //            name = [name stringByAppendingString:@"-568h"];
        //        //        }
        //        UIImage * image1 = [UIImage imageNamed:name];
        //        imageView.image = image1;
        imageView.image = [UIImage imageNamed:name];
        
        //        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        //        NSData *data = [NSData dataWithContentsOfFile:path];
        //        UIImage *image = [UIImage sd_animatedGIFWithData:data];
        //        imageView.image = image;
        
        
        //        NSArray*loadingArray= image1.images;
        //
        //        imageView.animationImages= loadingArray;
        //
        //        imageView.animationDuration=10;//执行一次完整动画所需的时长
        //
        //        imageView.animationRepeatCount =0;
        
        
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.top = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.left = i * imageW;
        
        // 给最后一个imageView添加按钮
//        if (i == HMNewfeatureImageCount - 1) {
        
            if ([UIScreen mainScreen].bounds.size.height == 812) {
                self.tiaoguo = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 70, 60, 50, 20)];
            }else
            {
                self.tiaoguo = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 70, 30, 50, 20)];
            }
            
            self.tiaoguo.text = @"跳过";
            self.tiaoguo.textColor = [UIColor blackColor];
            self.tiaoguo.font = [UIFont systemFontOfSize:16];
            [imageView addSubview: self.tiaoguo];
            
            [self setupLastImageView:imageView];
//        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(HMNewfeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    
}

/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = HMNewfeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 30;
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = COLOR(253, 98, 42, 1); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = COLOR(189, 189, 189,1); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
}

/**
 设置最后一个UIImageView中的内容
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(start:)];
    [imageView addGestureRecognizer:imageTap];

}

- (void)start:(UITapGestureRecognizer *)sender
{
    LoginHomePageViewController * loginHomepage = [[LoginHomePageViewController alloc] init];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //把自定义标签视图控制器totalTabBarVC 作为window的rootViewController(根视图控制器)
    
//    [window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    window.rootViewController = loginHomepage;
    
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginHomepage];
//    [self.navigationController pushViewController:loginHomepage animated:YES];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = intPage;
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
