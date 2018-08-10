//
//  ChengZhangXiangCeViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ChengZhangXiangCeViewController.h"
#import "WebViewJavascriptBridge.h"
@interface ChengZhangXiangCeViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIWebView   *webView;
@end

@implementation ChengZhangXiangCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    self.title = @"成长相册";
    [self prepareViews];
    // Do any additional setup after loading the view.
    
    [self setNetWork];
}

- (void)setNetWork
{
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            NSString *url1 = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
            NSURL *url = [NSURL URLWithString:url1];
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
            
//            [self prepareViews];
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}




- (void)prepareViews {
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@", self.urlStr];
//    NSURL *url = [NSURL URLWithString:urlStr];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
//    // 3.开启日志
//    [WebViewJavascriptBridge enableLogging];
//
//    // 4.给webView建立JS和OC的沟通桥梁
//    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
//    [self.bridge setWebViewDelegate:self];
//
//
//    /* JS调用OC的API:打开分享 */
//
//    [self.bridge registerHandler:@"uploadphoto" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"点击上传");
//        
//    }];
    
    
    
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
