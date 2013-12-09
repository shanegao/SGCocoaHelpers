//
//  DateUtils.m
//  TouchMobLib
//
//  Created by Shane on 10-12-28.
//  Copyright 2010 touchmob. All rights reserved.
//

#import "NSDate+Helpers.h"


@implementation NSDate (Helper)

// return YEAR, MONTH, DAY in NSDateComponents by given NSDate
+ (NSDateComponents *)dateComponents:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];    
    return comps;
}

// return whether given date and today is the same day
+ (BOOL)isToday:(NSDate *)date
{
    // Get Today's YYYY-MM-DD
    NSDateComponents *today_comps = [self dateComponents:[NSDate date]];
    // Given Date's YYYY-MM-DD
    NSDateComponents *select_comps = [self dateComponents:date];        
    
    // if it's today, return TODAY
    return [today_comps year] == [select_comps year]
         &&[today_comps month] == [select_comps month]
         &&[today_comps day] == [select_comps day];
}

// covert date to string by given locale
+ (NSString *)dateToLocaleString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *locale = [NSLocale currentLocale];
    [dateFormatter setLocale:locale];
    
    NSLog(@"Date string for locale %@: %@",
          [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:date]);
    return [dateFormatter stringFromDate:date]; 
}

// convert date to string in YYYY-MM-DD format
+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-DD"];
    return [dateFormatter stringFromDate:date];   
}

// covert date to string by given format
+ (NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date]; 
}

// convert string to date by given format
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:string];   
}

// return start date time of the day
+ (NSDate *)dateStart:(NSDate *)date
{
    NSDateComponents* comp = [self dateComponents:date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [NSString stringWithFormat:@"%04d-%02d-%02d 00:00:00", 
                            [comp year], [comp month], [comp day]];
    
    return [formatter dateFromString:dateString];
}

// return end date time of the day
+ (NSDate *)dateEnd:(NSDate *)date
{
    NSDateComponents* comp = [self dateComponents:date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [NSString stringWithFormat:@"%04d-%02d-%02d 23:59:59", 
                            [comp year], [comp month], [comp day]];
    return [formatter dateFromString:dateString];
}

// next date of given date
+ (NSDate *)nextDate:(NSDate *)date
{
    return [[NSDate alloc] initWithTimeInterval:24*3600 sinceDate:date];
}

// previous date of given date
+ (NSDate *)previousDate:(NSDate *)date
{
    return [[NSDate alloc] initWithTimeInterval:-24*3600 sinceDate:date];
}

+ (NSString *)currentTime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init ];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateTmp = [NSDate date];
    return [dateFormat stringFromDate: dateTmp];
}

@end
