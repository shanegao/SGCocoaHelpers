//
//  VersionChecker.m
//  SGCocoaHelpers
//
//  Created by Shane Gao on 2/9/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import "VersionChecker.h"

#define APP_URL @"http://itunes.apple.com/cn/lookup?id=%@"
#define APP_DownloadURL  @"http://itunes.apple.com/app/id%@?mt=8"

@interface VersionChecker () <UIAlertViewDelegate>
@property (nonatomic, copy) NSString *appid;

@property (nonatomic) BOOL isChecking;
@end

@implementation VersionChecker

+ (id)checker
{
	static id instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[self alloc] init];
	});
	return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isChecking = NO;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:APP_DownloadURL, self.appid]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)checkForAppId:(NSString *)appId
{
    if (self.isChecking) return;
    self.appid = appId;
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    NSString *URL = [NSString stringWithFormat:APP_URL, appId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    
    self.isChecking = YES;
    //将请求的url数据放到NSData对象中
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error)
     {
         self.isChecking = NO;
         NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
         NSArray *infoArray = [dic objectForKey:@"results"];
         if ([infoArray count]) {
             NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
             NSString *lastVersion = [releaseInfo objectForKey:@"version"];
             if ([lastVersion compare:appVersion options:NSNumericSearch] == NSOrderedDescending) {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本更新"
                                                                 message:@"检测到有新的版本，是否前往更新？"
                                                                delegate:self
                                                       cancelButtonTitle:@"忽略"
                                                       otherButtonTitles:@"更新", nil];
                 [alert show];
             } else {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                 message:@"已更新到最新版本"
                                                                delegate:self
                                                       cancelButtonTitle:@"知道了"
                                                       otherButtonTitles:nil, nil];
                 [alert show];
             }
         }}
     ];
}
@end
