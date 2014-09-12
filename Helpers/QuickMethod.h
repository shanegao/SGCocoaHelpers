//
//  QuickMethod.h
//  ToolsBox
//
//  Created by Shane Gao on 10-10-1.
//  Copyright 2010 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#define WIDTH_IPAD 1024
#define WIDTH_IPHONE_5 568
#define WIDTH_IPHONE_4 480
#define HEIGHT_IPAD 768
#define HEIGHT_IPHONE 320

#define IS_IPAD  UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define IS_PHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

#define IS_OS7_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
#define IS_IPHONE (IS_PHONE && [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
#define IS_IPOD (IS_PHONE && [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_PHONE_5  ( IS_PHONE && IS_WIDESCREEN )
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )
#define IS_IPOD_5   ( IS_IPHONE &% IS_WIDESCREEN )


#define cp_ph4(__X__, __Y__) ccp(cx_ph4(__X__), cy_ph4(__Y__))
#define cx_ph4(__X__) (IS_IPAD ? (__X__ * WIDTH_IPAD / WIDTH_IPHONE_4) : (IS_IPHONE_5 ? (__X__ * WIDTH_IPHONE_5 / WIDTH_IPHONE_4) : (__X__)))
#define cy_ph4(__Y__) (IS_IPAD ? (__Y__ * HEIGHT_IPAD / HEIGHT_IPHONE) : (__Y__))

#define cp_pad(__X__, __Y__) ccp(cx_pad(__X__), cy_pad(__Y__))
#define cx_pad(__X__) (IS_IPAD ? (__X__) : (IS_IPHONE_5 ? (__X__ * WIDTH_IPHONE_5 / WIDTH_IPAD) : (__X__ * WIDTH_IPHONE_4 / WIDTH_IPAD)))
#define cy_pad(__Y__) (IS_IPAD ? (__Y__) : (__Y__ * HEIGHT_IPHONE / HEIGHT_IPAD))

#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

#define ApplicationDelegate                 [[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define STR(string, args...)              	[NSString stringWithFormat:string, args]

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
void on_main_thread(void (^b)());
@end
