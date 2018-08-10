//
//  GrowthAlbumViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/26.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "GrowthAlbumViewController.h"
#import "WebViewJavascriptBridge.h"
#import "PublishJobModel.h"
#import "ReleasedAlbumsViewController.h"


@interface GrowthAlbumViewController ()<UIWebViewDelegate,HQPickerViewDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, strong) UIWebView   *webView;
@property (nonatomic, strong) NSString   *shareURL;
@property (nonatomic, strong) NSString   *shareTitle;
@property (nonatomic, strong) NSString   *shareMessage;
@property (nonatomic, strong) NSString   *shareImgurl;
@property (nonatomic, strong) NSMutableArray *publishJobArr;
@property (nonatomic, strong) UIView     *bgView;

@end

@implementation GrowthAlbumViewController

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.webTitle;
    NSLog(@"%@",self.classID);
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT)];
    self.bgView.backgroundColor = backColor;
    [self.view addSubview:self.bgView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    [button setTitle:@"选择班级" forState:UIControlStateNormal];
    button.titleLabel.font = titFont;
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self prepareViews];
}

- (void)rightBtn:(UIButton *)sender {
    
    NSLog(@"点击发布");
    [self getClassURLData];

    
}

- (void)getClassURLData {
    
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            
            HQPickerView *picker = [[HQPickerView alloc]initWithFrame:self.view.bounds];
            picker.delegate = self ;
            picker.customArr = ary;
            [self.view addSubview:picker];
            
            if (self.publishJobArr.count == 0) {
                [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                
                
            }
            
            
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

- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text  index:(NSInteger)index{
    PublishJobModel *model = [self.publishJobArr objectAtIndex:index];
    NSLog(@"%@",model.ID);
    [self postDataForGetURL:model.ID];
    
}

- (void)postDataForGetURL:(NSString *)classID {
    NSDictionary *dic = @{@"key":[UserManager key],@"class_id":classID};
    [[HttpRequestManager sharedSingleton] POST:getURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.bgView.hidden = YES;
            self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -80, APP_WIDTH, APP_HEIGHT + 90)];
            self.bgView.backgroundColor = backColor;
            [self.view addSubview:self.bgView];
            [self cleanCacheAndCookie];
            NSString *url = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
            self.urlStr = url;
            [self prepareViews];
            
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

-(void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}


- (void)prepareViews {
    
//        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//
//        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//
//        NSURL *url = [[NSURL alloc] initWithString:filePath];
//
//        [self.webView loadHTMLString:htmlString baseURL:url];
//    if (self.webView == nil) {
//        self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
//        self.webView.delegate = self;
//        [self.view addSubview:self.webView];
//    }
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.bgView addSubview:self.webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@", self.urlStr];
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    // 3.开启日志
    [WebViewJavascriptBridge enableLogging];
    
    // 4.给webView建立JS和OC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    
    
    /* JS调用OC的API:打开分享 */
    
    [self.bridge registerHandler:@"uploadphoto" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"点击上传");
        ReleasedAlbumsViewController *releasedAlbumsVC = [[ReleasedAlbumsViewController alloc] init];
        [self.navigationController pushViewController:releasedAlbumsVC animated:YES];
    }];
    
   
    
}

- (void)viewWillAppear:(BOOL)animated {
    //    [SVProgressHUD show];
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //    [SVProgressHUD dismiss];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"---------%@", request.URL.absoluteString);
    
    self.hidesBottomBarWhenPushed = YES;
    
    NSString *urlString = request.URL.absoluteString;
    
    
    
    if ([urlString containsString:@"weixin://"]) {
        
        [[UIApplication sharedApplication]openURL:request.URL options:@{} completionHandler:^(BOOL success) {
            
            NSLog(@"=========%d", success);
            
        }];
        
    }
    
    return YES;
    
}

@end
