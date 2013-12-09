//
//  LocationUtils.m
//  TouchMobLib
//
//  Created by Gao Shane on 12/23/11.
//  Copyright (c) 2011 touchmob.com. All rights reserved.
//

#import "LocationUtils.h"

@implementation LocationUtils

static CLLocationManager *manager ;

+ (CLLocationManager *) shareLocationManager
{
    @synchronized(self) {
        if (!manager) {
            manager = [[CLLocationManager alloc] init];//创建位置管理器  
            //manager.delegate = self;//设置代理  
            manager.desiredAccuracy = kCLLocationAccuracyBest;//指定需要的精度级别  
            manager.distanceFilter = 1000.0f;//设置距离筛选器  
            [manager startUpdatingLocation];//启动位置管理器
        }
    }
    return manager;
}

@end
