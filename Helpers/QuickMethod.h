//
//  QuickMethod.h
//  ToolsBox
//
//  Created by Shane Gao on 10-10-1.
//  Copyright 2010 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>

#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];

extern NSString* const kCallNotSupportOnThisDevice;
extern NSString* const kSmsNotSupportOnThisDevice;

@interface QuickMethod : NSObject {

}
+ (instancetype)shared;

+ (BOOL)isPhone4;
+ (BOOL)isPhone;
+ (BOOL)isPod;
+ (BOOL)isPad;
+ (BOOL)targetString:(NSString *)tString contains:(NSString *)cString;
+ (BOOL)connectedToNetwork;

+ (void)alert:(NSString *)msg;
- (void)makeCallWithWebView:(NSString *)aPhoneNumber;
+ (void)makeCall:(NSString *)phoneNumber;
+ (void)sendSms:(NSString *)phoneNumber;
+ (void)sendMailByNumber:(NSString *)phoneNumber;
+ (void)sendEmail:(NSString *)to cc:(NSString*)cc subject:(NSString*)subject body:(NSString*)body;

+ (NSString *)cleanPhoneNumber:(NSString*)phoneNumber;
+ (NSString *)deviceIPAdress;

+ (void)vibratePhone;
+ (void)openAppPageInAppStoreWithID:(long)appid;

+ (NSString *)stringOfNotificationTokenData:(NSData *)deviceToken;
@end
