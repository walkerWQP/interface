//
//  TheClassInformationViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/30.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "TheClassInformationViewController.h"
#import "ClassHomeModel.h"
#import "PublishJobModel.h"
@interface TheClassInformationViewController ()<WPopupMenuDelegate>

@property (nonatomic, strong) UIImageView    *backImgView;
@property (nonatomic, strong) UIImageView    *headImgView;
@property (nonatomic, strong) UIView         *bgView;
//班主任
@property (nonatomic, strong) UILabel        *chargeLabel;
@property (nonatomic, strong) UILabel        *chargeNameLabel;
//课任教师
@property (nonatomic, strong) UILabel        *teachersLabel;
@property (nonatomic, strong) UILabel        *teachersNameLael;
//班委班干
@property (nonatomic, strong) UILabel       *dryLabel;
@property (nonatomic, strong) UILabel       *dryNameLabel;
//班级人数
@property (nonatomic, strong) UILabel       *numberLabel;
@property (nonatomic, strong) UILabel       *numberPeopleLabel;
//班级寄语
@property (nonatomic, strong) UILabel       *remarkLabel;
@property (nonatomic, strong) UILabel       *remarksLabel;

@property (nonatomic, strong) UIImageView * userIcon;

@property (nonatomic, assign) NSInteger hnew;

@property (nonatomic, strong) NSMutableArray  *publishJobArr;

@property (nonatomic, strong) NSMutableArray  *classNameArr;

@property (nonatomic, strong) UIButton       *rightBtn;

@end

@implementation TheClassInformationViewController

- (NSMutableArray *)classNameArr {
    if (!_classNameArr) {
        _classNameArr = [NSMutableArray array];
    }
    return _classNameArr;
}

- (NSMutableArray *)publishJobArr {
    if (!_publishJobArr) {
        _publishJobArr = [NSMutableArray array];
    }
    return _publishJobArr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"]) {

    
        [self getClassURLData];
    }else
    {
        [self setNetWork:@""];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);
    self.view.backgroundColor = backColor;
    self.title = @"班级信息";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"]) {

    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [self.rightBtn setTitle:@"切换班级" forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = titFont;
    [self.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    }else{
        
    }
    
}

- (void)rightBtn:(UIButton *)sender {
    NSLog(@"点击选择班级");
    [self getClassURLDataForClassID];
    
}

- (void)getClassURLDataForClassID {
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.classNameArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.classNameArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.name]];
            }
            if (ary.count == 0) {
                [WProgressHUD showErrorAnimatedText:@"数据不正确,请重试"];
            } else {
                [WPopupMenu showRelyOnView:self.rightBtn titles:ary icons:nil menuWidth:140 delegate:self];
            }
            
            
            if (self.publishJobArr.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                
                
            }
            
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    
    PublishJobModel *model = [self.classNameArr objectAtIndex:index];
    NSLog(@"%@",model.ID);
    if (model.ID == nil) {
        [WProgressHUD showSuccessfulAnimatedText:@"数据不正确,请重试"];
    } else {
        self.ID = model.ID;
        [self setNetWork:self.ID];
    }
}

- (void)setNetWork:(NSString *)classID {
    NSDictionary * dic = [NSDictionary dictionary];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"chooseLoginState"] isEqualToString:@"2"]) {
        dic = @{@"key":[UserManager key], @"class_id":classID};
        
    }else
    {
        dic = @{@"key":[UserManager key]};

    }
    
    [[HttpRequestManager sharedSingleton] POST:userClassInfo parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            ClassHomeModel * model = [ClassHomeModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
            [self makeTheClassInformationViewControllerUI:model];
        }else
        {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            }else
            {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)getClassURLData {
    
    NSDictionary *dic = @{@"key":[UserManager key]};
    [[HttpRequestManager sharedSingleton] POST:getClassURL parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            
            self.publishJobArr = [PublishJobModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            NSMutableArray * ary = [@[]mutableCopy];
            for (PublishJobModel * model in self.publishJobArr) {
                [ary addObject:[NSString stringWithFormat:@"%@", model.ID]];
            }
            
            if (self.publishJobArr.count == 0) {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
            } else {
                self.ID = ary[0];
                [self setNetWork:self.ID];
            }
            
            
        } else {
            if ([[responseObject objectForKey:@"status"] integerValue] == 401 || [[responseObject objectForKey:@"status"] integerValue] == 402) {
                [UserManager logoOut];
            } else {
                [WProgressHUD showErrorAnimatedText:[responseObject objectForKey:@"msg"]];
                
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)makeTheClassInformationViewControllerUI:(ClassHomeModel *)model {
    
    self.backImgView.hidden = YES;
    self.backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_TABH - APP_NAVH)];
    self.backImgView.backgroundColor = backColor;
    self.backImgView.image = [UIImage imageNamed:@"背景图"];
    [self.view addSubview:self.backImgView];
    
    self.headImgView.hidden = YES;
    self.headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, APP_WIDTH - 40, APP_HEIGHT * 0.15)];
    self.headImgView.image = [UIImage imageNamed:@"班级信息"];
    [self.backImgView addSubview:self.headImgView];
    
   
    self.bgView.hidden = YES;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(40, self.headImgView.frame.size.height + 40, APP_WIDTH - 80, APP_HEIGHT * 0.63)];
    self.bgView.backgroundColor = whiteTMColor;
    [self.backImgView addSubview:self.bgView];
    
    self.userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(self.bgView.frame.size.width / 2 - 25, 10, 50, 50)];
    self.userIcon.layer.cornerRadius = 25;
    self.userIcon.layer.masksToBounds = YES;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.class_head_img]];
    [self.bgView addSubview:self.userIcon];

    self.chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 80, 20)];
    self.chargeLabel.text = @"班级主任:";
    self.chargeLabel.textColor = [UIColor blackColor];
    self.chargeLabel.font = titFont;
    [self.bgView addSubview:self.chargeLabel];
    
    self.chargeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.chargeLabel.frame.size.width + 30, 80, 100, 20)];
    self.chargeNameLabel.text = model.adviser_name;
    self.chargeNameLabel.textColor = titlColor;
    self.chargeNameLabel.font = titFont;
    self.chargeNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.chargeNameLabel];
    
    self.teachersLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.chargeLabel.frame.size.height + self.chargeLabel.frame.origin.y + 10, self.chargeLabel.frame.size.width, 20)];
    self.teachersLabel.text = @"科任老师:";
    self.teachersLabel.textColor = [UIColor blackColor];
    self.teachersLabel.font = titFont;
    [self.bgView addSubview:self.teachersLabel];
    
    for (int i = 0; i < model.teachers.count; i++ ) {
        self.teachersNameLael = [[UILabel alloc] initWithFrame:CGRectMake(self.teachersLabel.frame.size.width + 30, self.chargeLabel.frame.size.height + self.chargeLabel.frame.origin.y  + 10 * (i + 1) + 20 * (i), 200, 20)];
        NSDictionary * dic = [model.teachers objectAtIndex:i];
        self.teachersNameLael.text = [NSString stringWithFormat:@"%@(%@)",[dic objectForKey:@"teacher_name"], [dic objectForKey:@"course_name"]];
        self.teachersNameLael.textColor = titlColor;
        self.teachersNameLael.font = titFont;
        self.teachersNameLael.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:self.teachersNameLael];
        
    }
    self.hnew = self.chargeLabel.frame.size.height + self.chargeLabel.frame.origin.y + 30 * model.teachers.count;
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.hnew + 10, self.chargeLabel.frame.size.width, 20)];
    self.numberLabel.text = @"班级人数:";
    self.numberLabel.textColor = [UIColor blackColor];
    self.numberLabel.font = titFont;
    [self.bgView addSubview:self.numberLabel];

    self.numberPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.numberLabel.frame.size.width + 30, self.hnew + 10, self.teachersNameLael.frame.size.width, 20)];
    self.numberPeopleLabel.text = [NSString stringWithFormat:@"%ld人", model.num];
    self.numberPeopleLabel.textColor = titlColor;
    self.numberPeopleLabel.font = titFont;
    [self.bgView addSubview:self.numberPeopleLabel];

    self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.numberLabel.frame.origin.y + self.numberLabel.frame.size.height + 10, self.chargeLabel.frame.size.width, 20)];
    self.remarkLabel.text = @"班级寄语:";
    self.remarkLabel.textColor = [UIColor blackColor];
    self.remarkLabel.font = titFont;
    [self.bgView addSubview:self.remarkLabel];

    self.remarksLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.remarkLabel.frame.size.width + 30,  self.remarkLabel.frame.origin.y , self.bgView.frame.size.width - self.remarkLabel.frame.size.width - 50, 90)];
    self.remarksLabel.text = model.message;
    self.remarksLabel.textColor = titlColor;
    self.remarksLabel.font = titFont;
    self.remarksLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.remarksLabel.numberOfLines = 0;
    [self.bgView addSubview:self.remarksLabel];
    
    
}

@end
