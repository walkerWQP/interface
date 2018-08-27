//
//  TongZhiDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TongZhiDetailsViewController.h"
#import "TongZhiDetailsCell.h"
#import "TongZhiDetailsModel.h"
#import <WebKit/WebKit.h>
#import "UIView+XXYViewFrame.h"
#import "ChangeViewController.h"

@interface TongZhiDetailsViewController ()<UITableViewDelegate, UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UITableView * tongZhiDetailsTableView;
@property (nonatomic, strong) TongZhiDetailsModel * tongZhiDetailsModel;
@property (nonatomic, strong) TongZhiDetailsCell * tongZhiDetailsCell;

@property (nonatomic, assign) CGFloat Hnew;
@end

@implementation TongZhiDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNetWork];
    [self.view addSubview:self.tongZhiDetailsTableView];
    [self.tongZhiDetailsTableView registerNib:[UINib nibWithNibName:@"TongZhiDetailsCell" bundle:nil] forCellReuseIdentifier:@"TongZhiDetailsCellId"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通知详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    if ([self.typeStr isEqualToString:@"1"]) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [button setTitle:@"修改" forState:UIControlStateNormal];
        button.titleLabel.font = titFont;
        [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        
    }

}

- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击修改");
    ChangeViewController *ChangeVC = [ChangeViewController new];
    
    if (self.tongZhiId != nil) {
        ChangeVC.ID = self.tongZhiId;
        ChangeVC.titleStr = self.tongZhiDetailsModel.title;
        ChangeVC.content = self.tongZhiDetailsModel.content;
        ChangeVC.typeID = @"1";
        [self.navigationController pushViewController:ChangeVC animated:YES];
    } else {
        [WProgressHUD showErrorAnimatedText:@"数据不正确,请重新加载"];
    }
    
}


- (UITableView *)tongZhiDetailsTableView
{
    if (!_tongZhiDetailsTableView) {
        self.tongZhiDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.tongZhiDetailsTableView.backgroundColor = [UIColor whiteColor];
        self.tongZhiDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        self.tongZhiDetailsTableView.delegate = self;
        self.tongZhiDetailsTableView.dataSource = self;
    }
    return _tongZhiDetailsTableView;
}

- (void)setNetWork
{
    
    NSDictionary * dic = @{@"key":[UserManager key], @"id":self.tongZhiId};
    [[HttpRequestManager sharedSingleton] POST:JIAOSHIJIAZHANGCHAKANXIANGQING parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.Hnew = 0;
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            [self.tongZhiDetailsCell.PicView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            self.tongZhiDetailsModel = [TongZhiDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            
            [self configureImage];
            
            [self.tongZhiDetailsTableView reloadData];
        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                
            }
            [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];

        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)configureImage
{
        for (int i = 0; i < self.tongZhiDetailsModel.img.count; i++) {
            UIImageView * imageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * 210, self.tongZhiDetailsCell.PicView.bounds.size.width ,0)];
            
            [imageViewNew sd_setImageWithURL:[NSURL URLWithString:[self.tongZhiDetailsModel.img objectAtIndex:i]] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                CGSize size = image.size;
                CGFloat w = size.width;
                CGFloat H = size.height;
                if (w != 0) {
                    CGFloat newH = H * self.tongZhiDetailsCell.PicView.bounds.size.width / w;
                    self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant += (newH + 10);
                    imageViewNew.frame =CGRectMake(0, self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant - newH,self.tongZhiDetailsCell.PicView.bounds.size.width, H * self.tongZhiDetailsCell.PicView.bounds.size.width / w);
                }
                                
                
                [self.tongZhiDetailsTableView reloadData];
                
            }];
            
            [self.tongZhiDetailsCell.PicView addSubview:imageViewNew];
        }
        
        
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

//有时候tableview的底部视图也会出现此现象对应的修改就好了
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tongZhiDetailsCell  = [tableView dequeueReusableCellWithIdentifier:@"TongZhiDetailsCellId" forIndexPath:indexPath];
    self.tongZhiDetailsCell.selectionStyle = UITableViewCellSelectionStyleNone;

    self.tongZhiDetailsCell.TongZhiDetailsTitleLabel.text = self.tongZhiDetailsModel.title;
    self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.text = self.tongZhiDetailsModel.content;
    self.tongZhiDetailsCell.TongZhiDetailsTimeLabel.text = self.tongZhiDetailsModel.create_time;
//    self.tongZhiDetailsCell.webView.scrollView.delegate = self;

    if (self.Hnew ==0) {
        
        self.tongZhiDetailsCell.webView.hidden = NO;
        //            self.newsDetailsTopCell.webView.backgroundColor = BAKit_Color_Yellow_pod;
        self.tongZhiDetailsCell.webView.userInteractionEnabled = YES;
        
        self.tongZhiDetailsCell.webView.UIDelegate = self;
        self.tongZhiDetailsCell.webView.navigationDelegate = self;
        
        
        
        
        if (self.tongZhiDetailsModel.content.length>0) {
            
            
            
            [self.tongZhiDetailsCell.webView loadHTMLString:[NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", kScreenWidth - 20 , self.tongZhiDetailsModel.content] baseURL:nil];
            
        }
        
    }
    
    return self.tongZhiDetailsCell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // 让webview的内容一直居中显示
//    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - kScreenWidth) / 2, scrollView.contentOffset.y);
//}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
    NSString *heightString4 = @"document.body.scrollHeight";
    
    
    [webView evaluateJavaScript:heightString4 completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        
        
        CGFloat currentHeight = [item doubleValue];
        NSInteger width = kScreenWidth - 30;
        
//        self.titleText = self.tongZhiDetailsModel.title;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:30]};
        CGSize size = [self.tongZhiDetailsModel.title boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        self.tongZhiDetailsCell.webView.frame = CGRectMake(10, 30 + size.height , kScreenWidth - 20, currentHeight);
        //                weak_self.communityDetailsCell.communityDetailsHegiht.constant = currentHeight;
        
        self.Hnew = currentHeight;
        NSLog(@"html 高度2：%f", currentHeight);
        self.tongZhiDetailsCell.webView.hidden =NO;
        
        self.tongZhiDetailsCell.TongZhiDetailsTWebopCon.constant = self.Hnew + 26;
        
        self.tongZhiDetailsCell.webView.height = currentHeight;
        [self.tongZhiDetailsTableView reloadData];
        
    }];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger width = kScreenWidth - 30;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:30]};
    CGSize size = [self.tongZhiDetailsModel.title boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    if (self.Hnew ==0) {
        if (self.tongZhiDetailsModel.img.count == 0) {
            
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            return 200 + size.height;
            
        }else
        {

            return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 200 + size.height;
            //             self.H = 476 + self.communityDetailsCell.communityDetailsHegiht.constant;
            
        }
    }else
    {
        if (self.tongZhiDetailsModel.img.count == 0) {
            
            self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
            return 200 + self.Hnew + size.height;
            
        }else
        {
            
            //            self.communityDetailsCell.CommunityDetailsImageViewHegit.constant = self.communityDetailsModel.images.count * 210;
            return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 200+ self.Hnew + size.height;
            //             self.H = 476 + self.communityDetailsCell.communityDetailsHegiht.constant;
            
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
