//
//  NSMutableURLRequest+HttpMethod.h
//  TouchMobLib
//
//  Created by Shane Gao on 6/10/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (HTTPMethod)

- (void)setHTTPParams:(NSDictionary *)paramDictionary baseURLString:(NSString *)baseURLString;

- (void)setHTTPPostBody:(NSDictionary *)bodyDictionary encoding:(NSStringEncoding)encoding;

@end
