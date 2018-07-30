//
//  ExitCell.m
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/24.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "ExitCell.h"

@implementation ExitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.exitBtn];
    }
    return self;
}

- (UIButton *)exitBtn {
    if (!_exitBtn) {
        self.exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [self.exitBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        [self.exitBtn setFont:[UIFont fontWithName:@"PingFangSC-Semibold" size:13]];
        [self.exitBtn setTitleColor:[UIColor colorWithRed:235 / 255.0 green:7 / 255.0 blue:25 / 255.0 alpha:1] forState:UIControlStateNormal];
    }
    return _exitBtn;
}

@end
