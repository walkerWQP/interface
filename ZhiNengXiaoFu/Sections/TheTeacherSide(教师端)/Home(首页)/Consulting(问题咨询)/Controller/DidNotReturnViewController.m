//
//  DidNotReturnViewController.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/28.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "DidNotReturnViewController.h"
#import "DidNotReturnCell.h"
#import "ConsultListModel.h"
#import "ReplyViewController.h"

@interface DidNotReturnViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray  *didNotReturnArr;
@property (nonatomic, strong) UICollectionView *didNotReturnCollectionView;
@property (nonatomic, assign) NSInteger    page;

@end

@implementation DidNotReturnViewController

- (NSMutableArray *)didNotReturnArr {
    if (!_didNotReturnArr) {
        _didNotReturnArr = [NSMutableArray array];
    }
    return _didNotReturnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self getConsultConsultListURLData:self.page];
    
    [self makeDidNotReturnViewControllerUI];
}

- (void)getConsultConsultListURLData :(NSInteger )page {
    NSDictionary * dic = @{@"key":[UserManager key], @"status":@0,@"page":[NSString stringWithFormat:@"%ld",page]};
    
    [[HttpRequestManager sharedSingleton] POST:ConsultConsultList parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            self.didNotReturnArr = [ConsultListModel mj_objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            [self.didNotReturnCollectionView reloadData];
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

- (void)makeDidNotReturnViewControllerUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.didNotReturnCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVH - 40) collectionViewLayout:layout];
    self.didNotReturnCollectionView.backgroundColor = backColor;
    self.didNotReturnCollectionView.delegate = self;
    self.didNotReturnCollectionView.dataSource = self;
    [self.view addSubview:self.didNotReturnCollectionView];
    
    [self.didNotReturnCollectionView registerClass:[DidNotReturnCell class] forCellWithReuseIdentifier:DidNotReturnCell_CollectionView];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.didNotReturnArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    UICollectionViewCell *gridcell = nil;
    DidNotReturnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DidNotReturnCell_CollectionView forIndexPath:indexPath];
    ConsultListModel *model = [self.didNotReturnArr objectAtIndex:indexPath.row];
    [cell.headImgView sd_setImageWithURL:[NSURL URLWithString:model.s_headimg] placeholderImage:nil];
    cell.problemLabel.text = [NSString stringWithFormat:@"%@%@问:", model.class_name ,model.student_name];
    cell.problemContentLabel.text = model.question;
//    [cell.answerBtn addTarget:self action:@selector(answerBtn:) forControlEvents:UIControlEventTouchUpInside];
    gridcell = cell;
    return gridcell;
    
}

//- (void)answerBtn : (UIButton *)sender {
//    NSLog(@"点击回答咨询");
//    
//}

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
    ConsultListModel *model = [self.didNotReturnArr objectAtIndex:indexPath.row];
    ReplyViewController *replyVC = [[ReplyViewController alloc] init];
    replyVC.ID = model.ID;
    [self.navigationController pushViewController:replyVC animated:YES];
    
}


@end
