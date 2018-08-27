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

//正式
#define YUMING  @"http://www.ksznxt.com/"
//测试
//#define YUMING    @"http://school.ksznxt.com/"

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

//修改通知
#define updateNoticeURL [NSString stringWithFormat:@"%@index/notice/update_notice",YUMING]

//删除通知
#define deleteNoticeURL [NSString stringWithFormat:@"%@index/notice/delete_notice",YUMING]

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
//教师修改作业
#define updateHomeWork [NSString stringWithFormat:@"%@index/work/update_homework",YUMING]

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

//教师修改活动
#define updateActivityURL [NSString stringWithFormat:@"%@index/activity/update_activity",YUMING]

//教师查看自己发布的活动列表
#define myPublishURL [NSString stringWithFormat:@"%@index/activity/my_publish",YUMING]

//教师删除活动
#define deleteActivityURL [NSString stringWithFormat:@"%@index/activity/delete_activity",YUMING]

//教师、家长查看活动详情
#define activityDetail [NSString stringWithFormat:@"%@index/activity/detail",YUMING]

//请假模块
//家长请假
#define leaveAddLeave  [NSString stringWithFormat:@"%@index/leave/add_leave",YUMING]

//家长、教师查看请假列表
#define leaveLeaveList  [NSString stringWithFormat:@"%@index/leave/leave_list",YUMING]

//根据学生信息获取当天请假信息
#define studentTodayLeaveURL  [NSString stringWithFormat:@"%@index/leave/student_today_leave",YUMING]

//家长、教师查看请假详情
#define leaveLeaveDetail [NSString stringWithFormat:@"%@index/leave/leave_detail",YUMING]

//教师审核请假
#define leaveHandleLeave [NSString stringWithFormat:@"%@index/leave/handle_leave",YUMING]

//学生签入签出模块
//教师查看到校情况。
#define classConditionURL [NSString stringWithFormat:@"%@index/record/class_condition",YUMING]

//家长、教师查看学生进出记录。
#define recordURL [NSString stringWithFormat:@"%@index/record/record",YUMING]

//名师在线模块
//家长查看视频列表
#define onlineVideoList [NSString stringWithFormat:@"%@index/online/video_list",YUMING]

//家长查看视频详情
#define onlineVideoDetail [NSString stringWithFormat:@"%@index/online/video_detail",YUMING]

//家长查看该视频老师所有视频列表
#define onlineTheTeacherList [NSString stringWithFormat:@"%@/index/online/the_teacher_list",YUMING]

//教师查看自己发布的视频列表
#define myPublishListURL [NSString stringWithFormat:@"%@index/online/my_publish_list",YUMING]

//教师修改自己发布的视频
#define toUpdateURL [NSString stringWithFormat:@"%@index/online/to_update",YUMING]

//教师删除自己发布的视频
#define toDeleteURL [NSString stringWithFormat:@"%@index/online/to_delete",YUMING]

//获取个人信息
#define getUserInfoURL [NSString stringWithFormat:@"%@index/user/get_user_info",YUMING]


//修改个人密码
#define updatePasswordURL [NSString stringWithFormat:@"%@index/user/update_password",YUMING]

//获取联系我们数据
#define userContactUs [NSString stringWithFormat:@"%@index/user/contact_us",YUMING]

//家长、教师获取班级信息
#define userClassInfo [NSString stringWithFormat:@"%@index/user/class_info",YUMING]

//成长相册模块
//教师发布相册
#define uploadURL [NSString stringWithFormat:@"%@index/album/upload",YUMING]


//家长学堂模块
//家长获取视频列表
#define pschoolGetList [NSString stringWithFormat:@"%@index/pschool/get_list",YUMING]

//家长获取视频详情
#define pschoolGetDetail [NSString stringWithFormat:@"%@index/pschool/get_detail",YUMING]


//提交建议
#define suggestURL [NSString stringWithFormat:@"%@index/suggest/suggest",YUMING]

//教师、家长获取成长相册链接
#define getURL [NSString stringWithFormat:@"%@index/album/get_url",YUMING]

//获取banner图信息
/*
 1  首页banner图
 2 班级列表banner图
 3 老师通知列表banner图
 4 作业列表banner图
 5 学校通知列表banner图,
 6 学校动态列表banner图
 7 联系我们banner图
 8 名师在线banner图
 9 请假列表banner图
 */
#define bannersURL [NSString stringWithFormat:@"%@index/banner/banners",YUMING]


//获取上线最新版本信息
#define versionGetVersion [NSString stringWithFormat:@"%@index/version/get_version",YUMING]

//获取视频类型列表
#define indexOnlineVideoTypeList [NSString stringWithFormat:@"%@index/online/video_type_list",YUMING]

//名师在线获取视频列表
#define indexOnlineVideoListByType [NSString stringWithFormat:@"%@index/online/video_list_by_type",YUMING]

//名师在线获取视频详情
#define indexOnlineVideoById [NSString stringWithFormat:@"%@index/online/video_by_id",YUMING]

//获取视频推荐列表
#define indexOnlineGetRelated [NSString stringWithFormat:@"%@index/online/get_related",YUMING]

//右脑开发
#define brainURL [NSString stringWithFormat:@"%@index/index/brain",YUMING]

//家长、教师获取新生指南
#define getGuideURL [NSString stringWithFormat:@"%@index/guide/get_guide",YUMING]

//电子围栏
//家长添加电子围栏
#define indexFenceAddFence [NSString stringWithFormat:@"%@index/fence/add_fence",YUMING]

//获取电子围栏列表
#define indexFenceGetFence [NSString stringWithFormat:@"%@index/fence/get_fence",YUMING]

//家长删除电子围栏
#define indexFenceDeleteFence [NSString stringWithFormat:@"%@index/fence/delete_fence",YUMING]


