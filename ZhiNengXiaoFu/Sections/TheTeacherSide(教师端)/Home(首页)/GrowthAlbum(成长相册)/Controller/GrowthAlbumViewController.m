//
//  GrowthAlbumViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "GrowthAlbumViewController.h"


@interface GrowthAlbumViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic)  WKWebView* webView;

@end

@implementation GrowthAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成长相册";
    
    
    [self.view addSubview:self.webView];
}


@end
