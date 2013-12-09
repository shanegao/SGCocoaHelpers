//
//  LocationUtils.h
//  TouchMobLib
//
//  Created by Gao Shane on 12/23/11.
//  Copyright (c) 2011 touchmob.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationUtils : NSObject <CLLocationManagerDelegate>
+ (CLLocationManager *)shareLocationManager;
@end
