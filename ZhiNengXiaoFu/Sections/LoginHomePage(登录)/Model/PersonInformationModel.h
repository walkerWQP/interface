//
//  PersonInformationModel.h
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInformationModel : NSObject

//班级id
@property (nonatomic, assign) NSInteger class_id;
//头像
@property (nonatomic, copy) NSString * head_img;
//手机号
@property (nonatomic, copy) NSString * mobile;
//用户id
@property (nonatomic, copy) NSString * ID;
//姓名
@property (nonatomic, copy) NSString * name;
//学生性质
@property (nonatomic, assign) NSInteger nature;
//密码
@property (nonatomic, copy) NSString * password;
//学校id
@property (nonatomic, assign) NSInteger school_id;
//token
@property (nonatomic, copy) NSString * token;
//用户账号
@property (nonatomic, copy) NSString * usernum;
//性别
@property (nonatomic, assign) NSInteger sex;

@end
