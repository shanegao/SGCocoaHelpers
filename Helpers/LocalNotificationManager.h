//
//  LocalNotificationManager.h
//  TubeBox
//
//  Created by Shane Gao on 12-8-28.
//  Copyright (c) 2012年 touchmob.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalNotificationManager : NSObject

+ (LocalNotificationManager *)sharedManager;

- (BOOL)scheduleNotificationOn:(NSDate*) fireDate
                          text:(NSString*) alertText
                        action:(NSString*) alertAction
                         sound:(NSString*) soundfileName
                   launchImage:(NSString*) launchImage
                       andInfo:(NSDictionary*) userInfo;
- (NSArray *)allLocalNotifications;
- (void)cancelLocalNotification:(UILocalNotification *)notification;
- (void)cancelAllLocalNotifications;
@end
