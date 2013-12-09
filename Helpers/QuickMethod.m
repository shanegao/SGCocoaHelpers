//
//  QuickMethod.m
//  TouchMobLib
//
//  Created by Shane Gao on 10-10-1.
//  Copyright 2010 touchmob.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import "QuickMethod.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <arpa/inet.h> // For AF_INET, etc.
#import <ifaddrs.h> // For getifaddrs()
#import <net/if.h> // For IFF_LOOPBACK

#import "IPAdress.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation QuickMethod

static NSString *kCallNotSupportOnThisDevice = @"该设备不支持电话功能";
static NSString *kSmsNotSupportOnThisDevice = @"该设备不支持短信功能";

+ (BOOL)isPhone4
{
    return [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2;
}
+ (BOOL)isPhone
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[[UIDevice currentDevice] model] hasPrefix:@"iPhone"];
}
+ (BOOL)isPad
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad; 
}

+ (BOOL)isPod
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[[UIDevice currentDevice] model] hasPrefix:@"iPod"];
}

+ (BOOL)targetString:(NSString *)tString contains:(NSString *)cString
{
    //return [tString rangeOfString:cString].location != NSNotFound;
	//[str rangeOfString:@"target"].length > 0
	return [tString rangeOfString:cString].length > 0 && [tString rangeOfString:cString].length <= tString.length ;
}

+ (void)alert:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:msg
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"确定")
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

+ (NSString *)cleanPhoneNumber:(NSString *)phoneNumber
{
    NSArray *filterSignals = @[@" ", @"-", @"(", @")"];
    NSString *newPhoneNoString = [NSString stringWithString:phoneNumber];
    int startIndex = 0;
    while (startIndex < filterSignals.count) {
        newPhoneNoString = [newPhoneNoString stringByReplacingOccurrencesOfString:[filterSignals objectAtIndex:startIndex] withString:@""];
        startIndex++ ;
    }
    return newPhoneNoString;    
}

+ (void)makeCallWithWebView:(NSString *)aPhoneNumber
{
    if (![self isPhone]){
        [QuickMethod alert:kCallNotSupportOnThisDevice];
    } else {
        NSString* numberAfterClear = [QuickMethod cleanPhoneNumber:aPhoneNumber];
        UIWebView *phoneWebView = [[UIWebView alloc] init];
        [phoneWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", numberAfterClear]]]];
    }
}

+ (void)makeCall:(NSString *)phoneNumber
{
    if (![self isPhone]){
        [QuickMethod alert:kCallNotSupportOnThisDevice];
    } else {
        NSString* numberAfterClear = [QuickMethod cleanPhoneNumber:phoneNumber];    
        NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", numberAfterClear]];
        NSLog(@"make call, URL=%@", phoneNumberURL);
        [[UIApplication sharedApplication] openURL:phoneNumberURL];
    }
}

+ (void)sendSms:(NSString *)phoneNumber
{
	if (![self isPhone]){
        [QuickMethod alert:kSmsNotSupportOnThisDevice];
    } else {
        NSString* numberAfterClear = [QuickMethod cleanPhoneNumber:phoneNumber];
        NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", numberAfterClear]];
        //NSLog((@"send sms, URL=%@", phoneNumberURL);
        [[UIApplication sharedApplication] openURL:phoneNumberURL];
    }
}

+ (void)sendMailByNumber:(NSString *)phoneNumber
{
    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", phoneNumber]];
    //NSLog((@"send sms, URL=%@", phoneNumberURL);
    [[UIApplication sharedApplication] openURL:phoneNumberURL];    
}

+ (void)sendEmail:(NSString *)to cc:(NSString *)cc subject:(NSString *)subject body:(NSString *)body
{
    NSString* str = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@",
                     to, cc, subject, body];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

+ (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        //NSLog((@"Error. Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}


+ (NSString *)deviceIPAdress
{
	InitAddresses();
	GetIPAddresses();
	GetHWAddresses();
	return [NSString stringWithFormat:@"%s", ip_names[1]];
}

+ (void)vibratePhone
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

+ (void)openAppPageInAppStoreWithID:(long)appid
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%ld&mt=8", appid]]];
}

+ (NSString *)stringOfNotificationTokenData:(NSData *)deviceToken
{
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    return hexToken;
}
@end
