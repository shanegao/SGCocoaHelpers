//
//  LocalNotificationManager.m
//  TubeBox
//
//  Created by Shane Gao on 12-8-28.
//  Copyright (c) 2012年 touchmob.com All rights reserved.
//

#import "LocalNotificationManager.h"

@implementation LocalNotificationManager

#pragma mark - singleton instance
static LocalNotificationManager *instance;
+ (LocalNotificationManager *)sharedManager
{
	@synchronized(self) {
		if (!instance)
			instance = [[LocalNotificationManager alloc] init];
	}
	return instance;
}

+ (id)alloc
{
	@synchronized(self) {
		NSAssert(instance == nil, @"Attempted to allocate a second instance of a singleton.");
		return [super alloc];
	}
	return nil;
}

#pragma mark - lifecircle
- (id)init
{
    self = [super init];
    if (self) {
      //
    }
    return self;
}

- (BOOL)scheduleNotificationOn:(NSDate*) fireDate
                          text:(NSString*) alertText
                        action:(NSString*) alertAction
                         sound:(NSString*) soundfileName
                   launchImage:(NSString*) launchImage
                       andInfo:(NSDictionary*) userInfo
{
	UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = fireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = alertText;
    localNotification.alertAction = alertAction;
	localNotification.soundName = soundfileName != nil ? soundfileName : UILocalNotificationDefaultSoundName;
	localNotification.alertLaunchImage = launchImage;
    localNotification.userInfo = userInfo;
    
    for (UILocalNotification *notification in [self allLocalNotifications]) {
        if ([notification.fireDate timeIntervalSinceDate:localNotification.fireDate] == 0 &&
            [notification.alertBody isEqualToString:localNotification.alertBody]
            ) {
            return NO;
        }
    }
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    return YES;
}

- (NSArray *)allLocalNotifications
{
    return [[UIApplication sharedApplication] scheduledLocalNotifications];
}
- (void)cancelLocalNotification:(UILocalNotification *)notification
{
    [[UIApplication sharedApplication] cancelLocalNotification:notification];
}

- (void)cancelAllLocalNotifications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)cancelLocalNotificationByAlertBody:(NSString *)alertBody
{
    for (UILocalNotification *notification in [self allLocalNotifications]) {
        if ([notification.alertBody isEqual:alertBody] ) {
            [self cancelLocalNotification:notification];
            break;
        }
    }
}
@end
