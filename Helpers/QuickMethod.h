//
//  QuickMethod.h
//  ToolsBox
//
//  Created by Shane Gao on 10-10-1.
//  Copyright 2010 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>

#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define IS_IPAD   UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define IS_PHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

#define IS_OS7_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IS_RETINA [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2
#define IS_IPHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[[UIDevice currentDevice] model] hasPrefix:@"iPhone"]
#define IS_IPOD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[[UIDevice currentDevice] model] hasPrefix:@"iPod"]

extern NSString* const kCallNotSupportOnThisDevice;
extern NSString* const kSmsNotSupportOnThisDevice;

@interface QuickMethod : NSObject
+ (instancetype)shared;

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

@end
