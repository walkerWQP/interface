//
//  TeacherZaiXianModel.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefixHeader.pch"
@interface TeacherZaiXianModel : NSObject

@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * head_img;
@property (nonatomic, copy) NSString * honor;
@property (nonatomic, copy) NSString * ID;

@property (nonatomic, assign) int   is_charge;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * price;

@property (nonatomic, copy) NSString * title;

@end
