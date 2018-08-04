//
//  SchoolDongTaiDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "SchoolDongTaiDetailsViewController.h"
#import "TongZhiDetailsCell.h"
#import "WorkDetailsModel.h"
@interface SchoolDongTaiDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * schoolDongTaiDetailsTableView;
@property (nonatomic, strong) WorkDetailsModel * workDetailsModel;
@property (nonatomic, strong) TongZhiDetailsCell * tongZhiDetailsCell;

@property (nonatomic, strong) NSMutableArray * imgAry;
@end

@implementation SchoolDongTaiDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学校动态详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNetWork];
    [self.view addSubview:self.schoolDongTaiDetailsTableView];
    
    [self.schoolDongTaiDetailsTableView registerNib:[UINib nibWithNibName:@"TongZhiDetailsCell" bundle:nil] forCellReuseIdentifier:@"TongZhiDetailsCellId"];
}

- (NSMutableArray *)imgAry
{
    if (!_imgAry) {
        self.imgAry = [@[]mutableCopy];
    }
    return _imgAry;
}

- (void)setNetWork
{
    NSDictionary * dic = @{@"id":self.schoolDongTaiId, @"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:dynamicGetDetail parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.workDetailsModel = [WorkDetailsModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [self.imgAry addObject:self.workDetailsModel.img];
            [self configureImage];
            
            [self.schoolDongTaiDetailsTableView reloadData];
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

- (UITableView *)schoolDongTaiDetailsTableView
{
    if (!_schoolDongTaiDetailsTableView) {
        self.schoolDongTaiDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.schoolDongTaiDetailsTableView.backgroundColor = [UIColor whiteColor];
        self.schoolDongTaiDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.schoolDongTaiDetailsTableView.delegate = self;
        self.schoolDongTaiDetailsTableView.dataSource = self;
    }
    return _schoolDongTaiDetailsTableView;
}


- (void)configureImage
{
    for (int i = 0; i < self.imgAry.count; i++) {
        UIImageView * imageViewNew = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * 210, self.tongZhiDetailsCell.PicView.bounds.size.width ,0)];
        
        [imageViewNew sd_setImageWithURL:[NSURL URLWithString:[self.imgAry objectAtIndex:i]] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize size = image.size;
            CGFloat w = size.width;
            CGFloat H = size.height;
            if (w != 0) {
                CGFloat newH = H * self.tongZhiDetailsCell.PicView.bounds.size.width / w;
                self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant += (newH + 10);
                imageViewNew.frame =CGRectMake(0, self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant - newH,self.tongZhiDetailsCell.PicView.bounds.size.width, H * self.tongZhiDetailsCell.PicView.bounds.size.width / w);
            }
            [self.schoolDongTaiDetailsTableView reloadData];
            
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
    self.tongZhiDetailsCell.TongZhiDetailsTitleLabel.text = self.workDetailsModel.title;
    self.tongZhiDetailsCell.TongZhiDetailsConnectLabel.text = self.workDetailsModel.content;
    self.tongZhiDetailsCell.TongZhiDetailsTimeLabel.text = self.workDetailsModel.create_time;
    return self.tongZhiDetailsCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.imgAry.count == 0) {
        
        self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant = 0;
        return 150;
        
    }else
    {
        return  self.tongZhiDetailsCell.CommunityDetailsImageViewHegit.constant + 150;
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
