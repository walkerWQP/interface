//
//  SchoolInformationViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolInformationViewController.h"
#import "TongZhiDetailsCell.h"
#import "TongZhiDetailsModel.h"

@interface SchoolInformationViewController ()

<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tongZhiDetailsTableView;
@property (nonatomic, strong) TongZhiDetailsModel * tongZhiDetailsModel;
@property (nonatomic, strong) TongZhiDetailsCell * tongZhiDetailsCell;

@property (nonatomic, strong) UIImageView *noDataImgView;

@end

@implementation SchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"动态详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNetWork];
    [self.view addSubview:self.tongZhiDetailsTableView];
    
    [self.tongZhiDetailsTableView registerNib:[UINib nibWithNibName:@"TongZhiDetailsCell" bundle:nil] forCellReuseIdentifier:@"TongZhiDetailsCellId"];
    
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
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary * dic = @{@"key":key, @"id":self.ID};
    [[HttpRequestManager sharedSingleton] POST:dynamicGetDetail parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.tongZhiDetailsModel = [TongZhiDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            
            [self configureImage];
            
            [self.tongZhiDetailsTableView reloadData];
        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showSuccessfulAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
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
    return self.tongZhiDetailsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.tongZhiDetailsModel.img.count == 0) {
        
        self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
        return 200;
        
    }else
    {
        
        //            self.communityDetailsCell.CommunityDetailsImageViewHegit.constant = self.communityDetailsModel.images.count * 210;
        return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 200;
        //             self.H = 476 + self.communityDetailsCell.communityDetailsHegiht.constant;
        
    }
}


@end
