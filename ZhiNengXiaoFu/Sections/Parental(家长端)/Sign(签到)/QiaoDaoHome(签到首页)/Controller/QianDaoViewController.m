//
//  QianDaoViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/20.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "QianDaoViewController.h"
#import "QianDaoPsersonCell.h"
#import "QianDaoItemCell.h"
#import "DingWeiViewController.h"
#import "QianDaoModel.h"
#import "QianDaoInModel.h"
@interface QianDaoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,weak) CLPlayerView *playerView;

@property (nonatomic, strong) UITableView * QianDaoTableView;
@property (nonatomic, strong) NSMutableArray * QianDaoAry;
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) QianDaoModel * qianDaoModel;

@end

@implementation QianDaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dingwei"] style:UIBarButtonItemStyleDone target:self action:@selector(dingweiClick:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"进出安全";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:173/ 255.0 green:228 / 255.0 blue: 211 / 255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    
//    NSMutableArray * imgAry = [NSMutableArray arrayWithObjects:@"进校",@"出校",@"进校",@"出校", nil];
//    NSMutableArray * TitleAry = [NSMutableArray arrayWithObjects:@"星期四",@"星期四",@"星期四",@"星期四", nil];
//    NSMutableArray * TimeAry = [NSMutableArray arrayWithObjects:@"2015-05-23 11:22:00",@"2015-05-23 11:22:00",@"2015-05-23 11:22:00",@"2015-05-23 11:22:00", nil];
//
//    
//    for (int i = 0; i < imgAry.count; i++) {
//        NSString * img  = [imgAry objectAtIndex:i];
//        NSString * title = [TitleAry objectAtIndex:i];
//        NSString * time = [TimeAry objectAtIndex:i];
//        NSDictionary * dic = @{@"img":img, @"title":title, @"time":time};
//        [self.QianDaoAry addObject:dic];
//    }
    [self setNetWork];
    
    [self.view addSubview:self.QianDaoTableView];
    
    
    
    [self.QianDaoTableView registerClass:[QianDaoPsersonCell class] forCellReuseIdentifier:@"QianDaoPsersonCellId"];
    [self.QianDaoTableView registerClass:[QianDaoItemCell class] forCellReuseIdentifier:@"QianDaoItemCellId"];

    self.QianDaoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setNetWork
{
    NSLog(@"%@",self.studentId);
    NSDictionary * dic  = [NSDictionary dictionary];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"]) {
        dic = @{@"key":[UserManager key], @"student_id":self.studentId};

    }else
    {
        dic = @{@"key":[UserManager key]};

    }
    [[HttpRequestManager sharedSingleton] POST:recordURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        self.qianDaoModel = [QianDaoModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.QianDaoAry = [QianDaoInModel mj_objectArrayWithKeyValuesArray:self.qianDaoModel.record];
            [self.QianDaoTableView reloadData];
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

- (NSMutableArray *)QianDaoAry
{
    if (!_QianDaoAry) {
        self.QianDaoAry = [@[]mutableCopy];
    }
    return _QianDaoAry;
}


- (UITableView *)QianDaoTableView
{
    if (!_QianDaoTableView) {
        self.QianDaoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        self.QianDaoTableView.delegate = self;
        self.QianDaoTableView.dataSource = self;
    }
    return _QianDaoTableView;
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
    if (section == 0) {
        return 1;
    }else
    {
        return self.QianDaoAry.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        QianDaoPsersonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QianDaoPsersonCellId" forIndexPath:indexPath];
        cell.itemLabel.text = [UserManager getUserObject].name;
        [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:[UserManager getUserObject].head_img] placeholderImage:[UIImage imageNamed:@"user"]];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
        QianDaoItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QianDaoItemCellId" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        QianDaoInModel * model = [self.QianDaoAry objectAtIndex:indexPath.row];
        if (model.type == 1) {
            cell.stateLabel.text = @"进校";
            cell.stateImg.image = [UIImage imageNamed:@"进校"];

        }else
        {
            cell.stateLabel.text = @"出校";
            cell.stateImg.image = [UIImage imageNamed:@"出校"];

        }
        cell.timeLabel.text = model.week;
        cell.detailsTimeLabel.text = model.create_time;

        if (indexPath.row == 0) {
            cell.yuanImg.image = [UIImage imageNamed:@"椭圆5"];
        }else
        {
            cell.yuanImg.image = [UIImage imageNamed:@"椭圆5"];

        }
       
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 108;
    }else
    {
        return 70;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else
    {
        QianDaoInModel * model = [self.QianDaoAry objectAtIndex:indexPath.row];
//        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        self.backView.backgroundColor = COLOR(0, 0, 0, 0.2);
//        UITapGestureRecognizer * backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap:)];
//        self.backView.userInteractionEnabled = YES;
//        [self.backView addGestureRecognizer:backTap];
//        [[[UIApplication sharedApplication] keyWindow] addSubview:self.backView];
        
        
        CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.CLwidth , 200)];
        playerView.maskView.fullButton.alpha = 0;
        _playerView = playerView;
        
        [self.view addSubview:_playerView];
        
        //    //重复播放，默认不播放
        _playerView.repeatPlay = YES;
        //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
        _playerView.isLandscape = YES;
        //    //设置等比例全屏拉伸，多余部分会被剪切
        //    _playerView.fillMode = ResizeAspectFill;
        //    //设置进度条背景颜色
        //    _playerView.progressBackgroundColor = [UIColor purpleColor];
        //    //设置进度条缓冲颜色
        //    _playerView.progressBufferColor = [UIColor redColor];
        //    //设置进度条播放完成颜色
        //    _playerView.progressPlayFinishColor = [UIColor greenColor];
        //    //全屏是否隐藏状态栏
        //    _playerView.fullStatusBarHidden = NO;
        //    //是否静音，默认NO
        //    _playerView.mute = YES;
        //    //转子颜色
        //    _playerView.strokeColor = [UIColor redColor];
        //视频地址
             _playerView.url = [NSURL URLWithString:@"http://c31.aipai.com/user/128/31977128/1006/card/44340096/card.mp4?l=f&ip=1"];
//            _playerView.url = [NSURL URLWithString:model.video];
        //播放
        [_playerView playVideo];
        //返回按钮点击事件回调
        [_playerView backButton:^(UIButton *button) {
            NSLog(@"返回按钮被点击");
            //查询是否是全屏状态
            NSLog(@"%d",_playerView.isFullScreen);
        }];
        //播放完成回调
        [_playerView endPlay:^{
            //销毁播放器
            //        [_playerView destroyPlayer];
            //        _playerView = nil;
            NSLog(@"播放完成");
        }];
//        UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(15, kScreenHeight / 2 - (kScreenWidth - 30) * 210 / 345 / 2, kScreenWidth - 30 , (kScreenWidth - 30) * 210 / 345)];
//        img.image = [UIImage imageNamed:@"监控"];
//        UITapGestureRecognizer * imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTap:)];
//        img.userInteractionEnabled = YES;
//        [img addGestureRecognizer:imgTap];
//        [self.backView addSubview:img];
        
        
        
//        UIImageView * close = [[UIImageView alloc] initWithFrame:CGRectMake(_playerView.frame.size.width + _playerView.frame.origin.x - 10, _playerView.frame.origin.y - 10, 20 , 20)];
//        close.image = [UIImage imageNamed:@"guanbi"];
//        UITapGestureRecognizer * closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTap:)];
//        close.userInteractionEnabled = YES;
//        [close addGestureRecognizer:closeTap];
//        [self.backView addSubview:close];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [_playerView destroyPlayer];
    _playerView = nil;
}

- (void)dingweiClick:(UIBarButtonItem *)sender
{
    DingWeiViewController * VC = [[DingWeiViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)imgTap:(UITapGestureRecognizer *)sender
{
}

- (void)closeTap:(UITapGestureRecognizer *)sender
{
    [self.backView removeFromSuperview];
    [_playerView destroyPlayer];
    _playerView = nil;
}

- (void)backTap:(UITapGestureRecognizer *)sender
{
    [self.backView removeFromSuperview];
    
}

#pragma mark -- 需要设置全局支持旋转方向，然后重写下面三个方法可以让当前页面支持多个方向
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
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
