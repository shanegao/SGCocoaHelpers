//
//  NSMutableURLRequest+HttpMethod.m
//  TouchMobLib
//
//  Created by Shane Gao on 6/10/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import "NSMutableURLRequest+HttpMethod.h"

@implementation NSMutableURLRequest (HTTPMethod)

- (void)setHTTPParams:(NSDictionary *)paramDictionary baseURLString:(NSString *)baseURLString
{
    self.HTTPMethod = @"GET";
    if (paramDictionary.count == 0) return;
    
    NSMutableArray *parts = [[NSMutableArray alloc] initWithCapacity:[paramDictionary count]];
    
    for (NSString *key in [paramDictionary keyEnumerator]) {
        NSString *value = paramDictionary[key];
        NSString *part = [NSString stringWithFormat:@"%@=%@", key, value];
        [parts addObject:part];
    }
    NSString *paramsString = [parts componentsJoinedByString:@"&"];
    self.URL = [NSURL URLWithString:
                [baseURLString stringByAppendingFormat:@"?%@", paramsString]];
}

- (void)setHTTPPostBody:(NSDictionary *)bodyDictionary encoding:(NSStringEncoding)encoding
{
    self.HTTPMethod = @"POST";
    if (bodyDictionary.count == 0) return;
    
    NSMutableArray *parts = [[NSMutableArray alloc] initWithCapacity:[bodyDictionary count]];
    
    for (NSString *key in [bodyDictionary keyEnumerator]) {
        NSString *value = bodyDictionary[key];
        NSString *part = [NSString stringWithFormat:@"%@=%@", [key stringByAddingPercentEscapesUsingEncoding:encoding], [value stringByAddingPercentEscapesUsingEncoding:encoding]];
        [parts addObject:part];
    }
    
    self.HTTPBody = [[parts componentsJoinedByString:@"&"] dataUsingEncoding:NSASCIIStringEncoding];
}
@end
