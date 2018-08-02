//
//  URLMacro.h
//  ZhiNengXiaoFu
//
//  Created by duxiu on 2018/7/25.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#ifndef URLMacro_h
#define URLMacro_h


#endif /* URLMacro_h */

#define YUMING  @"http://www.ksznxt.com/"

//登录接口
#define LOGIN  [NSString stringWithFormat:@"%@index/login/login",YUMING]

//退出登录接口
#define TUICHULOGIN  [NSString stringWithFormat:@"%@index/login/logout",YUMING]

//文件上传接口
#define WENJIANSHANGCHUANJIEKOU  [NSString stringWithFormat:@"%@index/upload/upload",YUMING]

//老师发布通知
#define LAOSHIFABUTONGZHI [NSString stringWithFormat:@"%@index/notice/publish",YUMING]

//老师查看通知列表
#define LAOSHICHAKANTONGZHILIEBIAO [NSString stringWithFormat:@"%@index/notice/notice_list",YUMING]

//家长查看通知列表
#define JIAZHANGCHAKANTONGZHILIEBIAO [NSString stringWithFormat:@"%@index/notice/get_notice",YUMING]

//教师/家长查看通知详情
#define JIAOSHIJIAZHANGCHAKANXIANGQING [NSString stringWithFormat:@"%@index/notice/notice_detail",YUMING]







