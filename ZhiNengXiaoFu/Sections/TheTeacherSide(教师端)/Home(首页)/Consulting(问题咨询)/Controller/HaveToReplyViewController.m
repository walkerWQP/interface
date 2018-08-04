//
//  HaveToReplyViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "HaveToReplyViewController.h"
#import "HaveToReplyCell.h"
#import "ConsultListModel.h"

@interface HaveToReplyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *haveToReplyArr;
@property (nonatomic, strong) UICollectionView *haveToReplyCollectionView;
@property (nonatomic, assign) NSInteger     page;

@end

@implementation HaveToReplyViewController

- (NSMutableArray *)haveToReplyArr {
    if (!_haveToReplyArr) {
        _haveToReplyArr = [NSMutableArray array];
    }
    return _haveToReplyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self getConsultListURLData:self.page];
    
    [self makeHaveToReplyViewControllerUI];
}


- (void)getConsultListURLData:(NSInteger)page {
    
    NSDictionary * dic = @{@"key":[UserManager key], @"status":@1,@"page":[NSString stringWithFormat:@"%ld",page]};
    
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.haveToReplyArr = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            [self.haveToReplyCollectionView reloadData];
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

- (void)makeHaveToReplyViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.haveToReplyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.haveToReplyCollectionView.backgroundColor = backColor;
    self.haveToReplyCollectionView.delegate = self;
    self.haveToReplyCollectionView.dataSource = self;
    [self.view addSubview:self.haveToReplyCollectionView];
    
    [self.haveToReplyCollectionView registerClass:[HaveToReplyCell class] forCellWithReuseIdentifier:HaveToReplyCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.haveToReplyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    HaveToReplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HaveToReplyCell_CollectionView forIndexPath:indexPath];
    ConsultListModel *model = [self.haveToReplyArr objectAtIndex:indexPath.row];
    [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.s_headimg]];
    cell.problemLabel.text = [NSString stringWithFormat:@"%@%@问:", model.class_name ,model.student_name];
    cell.problemContentLabel.text = model.question;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model.t_headimg] placeholderImage:nil];
    cell.replyLabel.text = [NSString stringWithFormat:@"%@%@老师%@回复:", model.class_name, model.course_name, model.teacher_name];
    cell.replyContentLabel.text = model.answer;
    gridcell = cell;
    return gridcell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    
    itemSize = CGSizeMake(APP_WIDTH, APP_HEIGHT * 0.3);
    
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",indexPath.row);
    
}


@end
