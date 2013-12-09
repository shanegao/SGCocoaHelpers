//
//  DateUtils.h
//  TouchMobLib
//
//  Created by Shane on 10-12-28.
//  Copyright 2010 touchmob. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (Helper)

+ (NSDateComponents *)dateComponents:(NSDate *)date;
+ (BOOL)isToday:(NSDate *)date;

+ (NSString *)dateToLocaleString:(NSDate *)date;
+ (NSString *)dateToString:(NSDate *)date;

+ (NSString *)dateToString:(NSDate *)date
                withFormat:(NSString *)format;
+ (NSString *)currentTime ;

+ (NSDate *)dateFromString:(NSString *)string
                withFormat:(NSString *)format;

+ (NSDate *)dateStart:(NSDate *)date;
+ (NSDate *)dateEnd:(NSDate *)date;

+ (NSDate *)nextDate:(NSDate *)date;
+ (NSDate *)previousDate:(NSDate *)date;


@end
