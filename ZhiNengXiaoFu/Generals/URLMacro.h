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

//通知模块接口
//获取老师所教班级信息
#define getClassURL [NSString stringWithFormat:@"%@index/user/get_class",YUMING]

//老师查看通知列表  
#define noticeListURL [NSString stringWithFormat:@"%@index/notice/notice_list",YUMING]

//老师发布通知
#define publishURL [NSString stringWithFormat:@"%@index/notice/publish",YUMING]

//家长查看通知列表
#define JIAZHANGCHAKANTONGZHILIEBIAO [NSString stringWithFormat:@"%@index/notice/get_notice",YUMING]

//教师/家长查看通知详情
#define JIAOSHIJIAZHANGCHAKANXIANGQING [NSString stringWithFormat:@"%@index/notice/notice_detail",YUMING]

//作业模块接口
//获取课程列表
#define userGetCourse [NSString stringWithFormat:@"%@index/user/get_course",YUMING]

//老师发布作业
#define workPusblish [NSString stringWithFormat:@"%@index/work/publish",YUMING]

//家长查看作业列表
#define workGetHomeWork [NSString stringWithFormat:@"%@index/work/get_home_work",YUMING]

//家长/老师查看作业详情
#define workHomeWorkDetails [NSString stringWithFormat:@"%@index/work/homework_detail",YUMING]

//老师查看作业列表
#define workHomeWorkList [NSString stringWithFormat:@"%@index/work/homework_list",YUMING]

//老师删除作业
#define workDeleteHomeWork [NSString stringWithFormat:@"%@index/work/delete_homework",YUMING]

//问题咨询模块
//家长获取学生所在班级老师信息
#define UserGetStudentTeachers [NSString stringWithFormat:@"%@index/user/get_student_teachers",YUMING]

//家长提问
#define ConsultQuestion [NSString stringWithFormat:@"%@index/consult/question",YUMING]

//家长、教师获取问题列表信息
#define ConsultConsultList [NSString stringWithFormat:@"%@/index/consult/consult_list",YUMING]
//教师回答
#define teacherAnswerURL [NSString stringWithFormat:@"%@index/consult/answer",YUMING]

//学校动态模块
//获取学校动态列表
#define dynamicGetList [NSString stringWithFormat:@"%@index/dynamic/get_list",YUMING]

//获取学校动态详情
#define dynamicGetDetail [NSString stringWithFormat:@"%@index/dynamic/get_detail",YUMING]

//活动模块
//教师发布活动
#define activityPublish [NSString stringWithFormat:@"%@index/activity/publish",YUMING]

//教师、家长查看活动列表
#define activityActivityList [NSString stringWithFormat:@"%@index/activity/activity_list",YUMING]

//教师、家长查看活动详情
#define activityDetail [NSString stringWithFormat:@"%@index/activity/detail",YUMING]



