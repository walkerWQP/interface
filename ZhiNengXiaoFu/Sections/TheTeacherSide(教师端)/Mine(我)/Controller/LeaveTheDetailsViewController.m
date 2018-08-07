//
//  LeaveTheDetailsViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/8/6.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveTheDetailsViewController.h"
#import "LeaveListModel.h"

@interface LeaveTheDetailsViewController ()

@property (nonatomic, strong) UIView       *firstView;
@property (nonatomic, strong) UIImageView  *userIconImg;
@property (nonatomic, strong) UILabel      *userNameLabel;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *StartEndView;
@property (nonatomic, strong) UIImageView *StartImg;
@property (nonatomic, strong) UIImageView *EndImg;
@property (nonatomic, strong) UILabel *StartLabel;
@property (nonatomic, strong) UILabel *EndLabel;

@property (nonatomic, strong) UIView     *bgView;

@property (nonatomic, strong) UIView       *typeView;
@property (nonatomic, strong) UIImageView  *typeImgView;
@property (nonatomic, strong) UILabel      *typeLabel;
@property (nonatomic, strong) UILabel      *statusLabel;

@property (nonatomic, strong) UIView       *whyView;
@property (nonatomic, strong) UIImageView  *whyImgView;
@property (nonatomic, strong) UILabel      *whyLabel;
@property (nonatomic, strong) UIView       *lineView;
@property (nonatomic, strong) UILabel      *reasonLeaveLabel;

@property (nonatomic, strong) UIView       *noteView;
@property (nonatomic, strong) UIImageView  *noteImgView;
@property (nonatomic, strong) UILabel      *noteLabel;
@property (nonatomic, strong) UIView       *lineView1;
@property (nonatomic, strong) WTextView    *noteTextView;

@property (nonatomic, strong) UIButton     *submitBtn;
@property (nonatomic, strong) NSMutableArray *LeaveTheDetailsArr;

@property (nonatomic, strong) LeaveListModel *leaveListModel;

@end

@implementation LeaveTheDetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请假详情";
    [self getLeaveLeaveDetailData];
    
}

- (void)getLeaveLeaveDetailData {
    
    NSDictionary *dic = @{@"key":[UserManager key],@"id":self.ID};
    [[HttpRequestManager sharedSingleton] POST:leaveLeaveDetail parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.leaveListModel = [LeaveListModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [self makeLeaveTheDetailsViewControllerUI];
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_failed_56_w100"];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)makeLeaveTheDetailsViewControllerUI {
    
    self.firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 200)];
    self.firstView.backgroundColor = backColor;
    [self.view addSubview:self.firstView];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 155)];
    self.backView.backgroundColor = TEACHERTHEMECOLOR;
    [self.firstView addSubview:self.backView];
    
    self.userIconImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.backView.frame.size.width / 2 -35, 4, 70, 70)];
    [self.userIconImg sd_setImageWithURL:[NSURL URLWithString:self.headImg] placeholderImage:nil];
    self.userIconImg.layer.cornerRadius = 35;
    self.userIconImg.layer.masksToBounds = YES;
    [self.backView addSubview:self.userIconImg];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.userIconImg.frame.size.height + self.userIconImg.frame.origin.y + 12, kScreenWidth, 17)];
    self.userNameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    self.userNameLabel.textColor = [UIColor whiteColor];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel.text = self.name;
    [self.backView addSubview:self.userNameLabel];
    
    self.StartEndView = [[UIView alloc] initWithFrame:CGRectMake(32, 155 - 85 / 2, kScreenWidth - 64, 85)];
    self.StartEndView.backgroundColor = [UIColor whiteColor];
    self.StartEndView.layer.cornerRadius = 4;
    self.StartEndView.layer.masksToBounds = YES;
    [self.firstView addSubview:self.StartEndView];
    
    self.StartImg = [[UIImageView alloc] initWithFrame:CGRectMake(25, 53 / 2, 32, 32)];
    self.StartImg.image = [UIImage imageNamed:@"起"];
    [self.StartEndView addSubview:self.StartImg];
    
    self.StartLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.StartImg.frame.origin.x + self.StartImg.frame.size.width + 10, self.StartEndView.frame.size.height / 2 - 10, 90, 20)];
    self.StartLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    self.StartLabel.textColor = COLOR(119, 119, 119, 1);
    self.StartLabel.text = self.leaveListModel.start;
    [self.StartEndView addSubview:self.StartLabel];
    
    self.EndImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.StartEndView.frame.size.width / 2 + 10, 53 / 2, 32, 32)];
    self.EndImg.image = [UIImage imageNamed:@"止"];
    [self.StartEndView addSubview:self.EndImg];
    
    self.EndLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.EndImg.frame.origin.x + self.EndImg.frame.size.width + 10, self.StartEndView.frame.size.height / 2 - 10, 90, 20)];
    self.EndLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:15];
    self.EndLabel.textColor = COLOR(119, 119, 119, 1);
    self.EndLabel.text = self.leaveListModel.end;
    [self.StartEndView addSubview:self.EndLabel];
    
    
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, APP_WIDTH, APP_HEIGHT - 230)];
    self.bgView.backgroundColor = backColor;
    [self.view addSubview:self.bgView];
    
    self.typeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 50)];
    self.typeView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.typeView];
    
    self.typeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 28)];
    self.typeImgView.image = [UIImage imageNamed:@"请加状态"];
    [self.typeView addSubview:self.typeImgView];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.typeImgView.frame.size.width + 20, 10, APP_WIDTH * 0.6, 30)];
    self.typeLabel.text = @"请假状态";
    self.typeLabel.textColor = titlColor;
    self.typeLabel.font = titFont;
    [self.typeView addSubview:self.typeLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(APP_WIDTH - 100, 5, 90, 30)];
    self.statusLabel.font = titFont;
    if (self.leaveListModel.status == 0) {
        self.statusLabel.text = @"审核中";
        self.statusLabel.textColor = [UIColor redColor];
    } else if (self.leaveListModel.status == 1) {
        self.statusLabel.text = @"已批准";
        self.statusLabel.textColor = THEMECOLOR;
    }
    [self.typeView addSubview:self.statusLabel];
    
    self.whyView = [[UIView alloc] initWithFrame:CGRectMake(0, self.typeView.frame.size.height + 20, APP_WIDTH, 100)];
    self.whyView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.whyView];
    
    self.whyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 28)];
    self.whyImgView.image = [UIImage imageNamed:@"请假原因"];
    [self.whyView addSubview:self.whyImgView];
    
    self.whyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.whyImgView.frame.size.width, 10, APP_WIDTH * 0.6, 30)];
    self.whyLabel.text = @"请假原因:";
    self.whyLabel.tintColor = titlColor;
    self.whyLabel.font = titFont;
    [self.whyView addSubview:self.whyLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, APP_WIDTH, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.whyView addSubview:self.lineView];
    
    self.reasonLeaveLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, APP_WIDTH - 40, 30)];
    self.reasonLeaveLabel.textColor = titlColor;
    self.reasonLeaveLabel.font = contentFont;
    self.reasonLeaveLabel.text = self.leaveListModel.reason;
    [self.whyView addSubview:self.reasonLeaveLabel];
    
    self.noteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.typeView.frame.size.height + self.whyView.frame.size.height + 40, APP_WIDTH, 150)];
    self.noteView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.noteView];
    
    self.noteImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 22, 28)];
    self.noteImgView.image = [UIImage imageNamed:@"备注"];
    [self.noteView addSubview:self.noteImgView];
    
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.noteImgView.frame.size.width + 20, 10, APP_WIDTH * 0.6, 30)];
    self.noteLabel.text = @"备注:";
    self.noteLabel.textColor = titlColor;
    self.noteLabel.font = titFont;
    [self.noteView addSubview:self.noteLabel];
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, APP_WIDTH, 1)];
    self.lineView1.backgroundColor = fengeLineColor;
    [self.noteView addSubview:self.lineView1];
    
    self.noteTextView = [[WTextView alloc] initWithFrame:CGRectMake(20, 60, APP_WIDTH - 40, 70)];
    if (self.leaveListModel.status == 0) {
        self.noteTextView.placeholder = @"请输入审核内容";
    } else if (self.leaveListModel.status == 1) {
        self.noteTextView.text = self.leaveListModel.remark;
    }
    
    self.noteTextView.backgroundColor = backColor;
    [self.noteView addSubview:self.noteTextView];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.typeView.frame.size.height + self.whyView.frame.size.height + self.noteView.frame.size.height + 60, APP_WIDTH - 40, 40)];
    self.submitBtn.backgroundColor = THEMECOLOR;
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.submitBtn addTarget:self action:@selector(submitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.submitBtn];
    
    if (self.leaveListModel.status == 1) {
        self.submitBtn.hidden = YES;
        self.noteTextView.editable = NO;
    } else {
        self.submitBtn.hidden = NO;
        self.noteTextView.editable = YES;
    }
}



- (void)submitBtn : (UIButton *)sender {
    
    if ([self.noteTextView.text isEqualToString:@""]) {
        [EasyShowTextView showImageText:@"审核内容不能为空" imageName:@"icon_sym_toast_failed_56_w100"];
        return;
    } else {
       
        NSDictionary *dic = @{@"key":[UserManager key],@"id":self.ID,@"remark":self.noteTextView.text};
        [[HttpRequestManager sharedSingleton] POST:leaveHandleLeave parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                
                [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_succeed_56_w100"];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                    [UserManager logoOut];
                } else {
                    [EasyShowTextView showImageText:[responseObject objectForKey:@"msg"] imageName:@"icon_sym_toast_failed_56_w100"];
                    
                }
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
    
    
}



@end
