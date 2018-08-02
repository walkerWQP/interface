//
//  DingWeiViewController.m
//  ZhiNengXiaoFu
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 henanduxiu. All rights reserved.
//

#import "DingWeiViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface DingWeiViewController ()

@property (nonatomic, strong) AMapLocationManager * locationManager;
@property (nonatomic, strong) MAMapView * mapView;

@end

@implementation DingWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [AMapServices sharedServices].enableHTTPS = YES;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    //设置缩放级别
    [_mapView setZoomLevel:18];
    //是否显示指南针
    [_mapView setShowsCompass:YES];
    
    //是否显示比例尺
    [_mapView setShowsScale:YES];
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 50;
    //    UIImageView * dingweiImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //    dingweiImg.image = [UIImage imageNamed:@"dingwei1"];
    //    [self.view addSubview:dingweiImg];
    
    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
    }
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
