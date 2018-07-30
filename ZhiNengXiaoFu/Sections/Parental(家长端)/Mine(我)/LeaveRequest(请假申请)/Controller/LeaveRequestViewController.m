//
//  LeaveRequestViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "LeaveRequestViewController.h"

@interface LeaveRequestViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel * chooseStart;
@property (nonatomic, strong) UILabel * chooseEnd;
@property (nonatomic, strong) UILabel * leaveSeason;
@property (nonatomic, strong) UITextView * leaveSeasonTextView;
@end

@implementation LeaveRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"请假申请";
    
    self.view.backgroundColor = COLOR(246, 246, 246, 1);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitBtn:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    //请假开始view
    UIView * leaveStart = [[UIView alloc] initWithFrame:CGRectMake(17, 15, kScreenWidth - 34, 60)];
    leaveStart.layer.cornerRadius = 4;
    leaveStart.layer.masksToBounds = YES;
    leaveStart.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leaveStart];
    //请假开始时间
    UILabel * leaveStartTime = [[UILabel alloc] initWithFrame:CGRectMake(16, 22, 100, 16)];
    leaveStartTime.text = @"请假开始时间:";
    leaveStartTime.font = [UIFont systemFontOfSize:15];
    leaveStartTime.textColor = COLOR(119, 119, 119, 1);
    [leaveStart addSubview:leaveStartTime];
    
    //选择请假开始时间
    self.chooseStart = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 16 - 160, 0, 140, 60)];
       NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"选择请假开始时间"];
    NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    self.chooseStart.attributedText = content;
    self.chooseStart.textColor = COLOR(170, 170, 170, 1);
    self.chooseStart.font = [UIFont systemFontOfSize:15];
    [leaveStart addSubview:self.chooseStart];
    
    //请假结束view
    UIView * leaveEnd = [[UIView alloc] initWithFrame:CGRectMake(17, leaveStart.frame.origin.y + leaveStart.frame.size.height + 10, kScreenWidth - 34, 60)];
    leaveEnd.layer.cornerRadius = 4;
    leaveEnd.layer.masksToBounds = YES;
    leaveEnd.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leaveEnd];
    //请假结束时间
    UILabel * leaveStartEnd = [[UILabel alloc] initWithFrame:CGRectMake(16, 22, 100, 16)];
    leaveStartEnd.text = @"请假结束时间:";
    leaveStartEnd.font = [UIFont systemFontOfSize:15];
    leaveStartEnd.textColor = COLOR(119, 119, 119, 1);
    [leaveEnd addSubview:leaveStartEnd];
    
    //选择请假结束时间
    self.chooseEnd = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 16 - 160, 0, 140, 60)];
    NSMutableAttributedString *content1 = [[NSMutableAttributedString alloc] initWithString:@"选择请假结束时间"];
    NSRange contentRange1 = {0, [content1 length]};
    [content1 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange1];
    self.chooseEnd.attributedText = content1;
    self.chooseEnd.textColor = COLOR(170, 170, 170, 1);
    self.chooseEnd.font = [UIFont systemFontOfSize:15];
    [leaveEnd addSubview:self.chooseEnd];
    
    //请假原因view
    UIView * leaveSeason = [[UIView alloc] initWithFrame:CGRectMake(17, leaveEnd.frame.size.height + leaveEnd.frame.origin.y  + 10, kScreenWidth - 34, 200)];
    leaveSeason.layer.cornerRadius = 4;
    leaveSeason.layer.masksToBounds = YES;
    leaveSeason.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leaveSeason];
    
    //请假原因
    UILabel * leaveSeasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 22, 100 , 20)];
    leaveSeasonLabel.text = @"请假原因";
    leaveSeasonLabel.font = [UIFont systemFontOfSize:15];
    leaveSeasonLabel.textColor = COLOR(119, 119, 119, 1);
    [leaveSeason addSubview:leaveSeasonLabel];
    
    //横线
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, leaveSeasonLabel.frame.size.height + leaveSeasonLabel.frame.origin.y + 10, leaveSeason.frame.size.width, 1)];
    lineView.backgroundColor = COLOR(229, 229, 229, 1);
    [leaveSeason addSubview:lineView];
    
    //输入框
    self.leaveSeasonTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, lineView.frame.size.height + lineView.frame.origin.y + 15, leaveSeason.frame.size.width - 20, 140)];
    self.leaveSeasonTextView.font = [UIFont systemFontOfSize:15];
    self.leaveSeasonTextView.delegate = self;
    self.leaveSeasonTextView.textColor = COLOR(170, 170, 170, 1);
    self.leaveSeasonTextView.text = @"请输入请假原因...";
    [leaveSeason addSubview:self.leaveSeasonTextView];
    
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请输入请假原因...";
        textView.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入请假原因..."]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}


- (void)submitBtn:(UIBarButtonItem *)sender
{
    
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
