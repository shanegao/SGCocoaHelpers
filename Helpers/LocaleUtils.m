//
//  LocalUtils.m
//  TouchMobLib
//
//  Created by Gao Shane on 11/29/11.
//  Copyright (c) 2011 touchmob.com. All rights reserved.
//

#import "LocaleUtils.h"

@implementation LocaleUtils

+ (NSString *)getCountryCode
{
    NSLocale *currentLocale = [NSLocale currentLocale];   
    return [currentLocale objectForKey:NSLocaleCountryCode];
}

+ (NSString *)getLanguageCode
{
    NSLocale *currentLocale = [NSLocale currentLocale];
    return [currentLocale objectForKey:NSLocaleLanguageCode];
}

@end
