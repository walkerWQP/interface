//
//  JingJiActivityDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "JingJiActivityDetailsViewController.h"
#import "TongZhiDetailsCell.h"
#import "JingJiHuoDongListModel.h"
@interface JingJiActivityDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * JingJiActivityDetailsTableView;
@property (nonatomic, strong) JingJiHuoDongListModel * jingJiHuoDongListModol;
@property (nonatomic, strong) TongZhiDetailsCell * tongZhiDetailsCell;
@end

@implementation JingJiActivityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"竞技活动详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNetWork];
    [self.view addSubview:self.JingJiActivityDetailsTableView];
    
    [self.JingJiActivityDetailsTableView registerNib:[UINib nibWithNibName:@"TongZhiDetailsCell" bundle:nil] forCellReuseIdentifier:@"TongZhiDetailsCellId"];
}

- (UITableView *)JingJiActivityDetailsTableView
{
    if (!_JingJiActivityDetailsTableView) {
        self.JingJiActivityDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.JingJiActivityDetailsTableView.backgroundColor = [UIColor whiteColor];
        self.JingJiActivityDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.JingJiActivityDetailsTableView.delegate = self;
        self.JingJiActivityDetailsTableView.dataSource = self;
    }
    return _JingJiActivityDetailsTableView;
}

- (void)setNetWork
{
    NSString * key = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    NSDictionary * dic = @{@"key":key, @"id":self.JingJiActivityDetailsId};
    [[HttpRequestManager sharedSingleton] POST:activityDetail parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.jingJiHuoDongListModol = [JingJiHuoDongListModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            
            [self configureImage];
            
            [self.JingJiActivityDetailsTableView reloadData];
        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_failed_56_w100"];
                
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)configureImage
{
        UIImageView * imageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 210, self.tongZhiDetailsCell.PicView.bounds.size.width ,0)];
        
        [imageViewNew sd_setImageWithURL:[NSURL URLWithString:self.jingJiHuoDongListModol.img] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize size = image.size;
            CGFloat w = size.width;
            CGFloat H = size.height;
            if (w != 0) {
                CGFloat newH = H * self.tongZhiDetailsCell.PicView.bounds.size.width / w;
                self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant += (newH + 10);
                imageViewNew.frame =CGRectMake(0, self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant - newH,self.tongZhiDetailsCell.PicView.bounds.size.width, H * self.tongZhiDetailsCell.PicView.bounds.size.width / w);
            }
            
            
            [self.JingJiActivityDetailsTableView reloadData];
            
        }];
        
        [self.tongZhiDetailsCell.PicView addSubview:imageViewNew];

    
    
    
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
    
    self.tongZhiDetailsCell.TongZhiDetailsTitleLabel.text = self.jingJiHuoDongListModol.title;
    self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.text = self.jingJiHuoDongListModol.introduction;
    self.tongZhiDetailsCell.TongZhiDetailsTimeLabel.text = [NSString stringWithFormat:@"活动时间:%@-%@", self.jingJiHuoDongListModol.start, self.jingJiHuoDongListModol.end];
    return self.tongZhiDetailsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.jingJiHuoDongListModol.img isEqualToString:@""]) {
        
        self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
        return 200;
        
    }else
    {
        
        //            self.communityDetailsCell.CommunityDetailsImageViewHegit.constant = self.communityDetailsModel.images.count * 210;
        return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 200;
        //             self.H = 476 + self.communityDetailsCell.communityDetailsHegiht.constant;
        
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
