//
//  NSURLRequest+SOAP.h
//  SGCocoaHelpers
//
//  Created by Shane Gao on 1/14/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (SOAP)
+ (NSURLRequest *)requestForSoapInvoke:(NSString *)method
                                params:(NSDictionary *)params
                             nameSpace:(NSString *)nameSpace
                               baseURL:(NSString *)baseURL;
@end
