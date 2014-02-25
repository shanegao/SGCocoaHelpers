//
//  NSURLRequest+SOAP.m
//  SGCocoaHelpers
//
//  Created by Shane Gao on 1/14/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import "NSURLRequest+SOAP.h"

@implementation NSURLRequest (SOAP)
/*
 - <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns0="urn:App2Controllerwsdl" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
 - <soapenv:Body>
 - <ns0:isServiceByAddress>
 <address soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/" xsi:type="xsd:string">上海市普坨区中山北路3700</address>
 </ns0:isServiceByAddress>
 </soapenv:Body>
 </soapenv:Envelope>
 */

+ (NSURLRequest *)requestForSoapInvoke:(NSString *)method
                                params:(NSDictionary *)params
                             nameSpace:(NSString *)nameSpace
                               baseURL:(NSString *)baseURL
{
    NSMutableString * post = [[ NSMutableString alloc ] init ];
    [ post appendString:
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
     "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\""
     " xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\""
     " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n"
     "<soapenv:Body>\n" ];
    [ post appendString:[NSString stringWithFormat:@"<ns0:%@>\n", method]];
    
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *value = (NSString *)obj;
        if (value.length > 0) {
            [ post appendString:@"<"];
            [ post appendString:key];
            [ post appendString:@">"];
            [ post appendString:obj];
            [ post appendString:@"</"];
            [ post appendString:key];
            [ post appendString:@">\n"];
        }
    }];
    
    [ post appendString:@"</ns0:"];
    [ post appendString:method];
    [ post appendString:@">\n"];
    
    [ post appendString:
     @"</soapenv:Body>\n"
     "</soapenv:Envelope>\n"
     ];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSString *soapAction = [NSString stringWithFormat:@"%@#%@",nameSpace , method];
    
    NSURL *url = [NSURL URLWithString:baseURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"text/xml;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:soapAction forHTTPHeaderField:@"SOAPAction"];
    [request addValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request addValue:@"ZhaiSuJie" forHTTPHeaderField:@"User-Agent"];
    [request setHTTPBody:postData];
    
    NSLog(@"request xml:%@", post);
    return request;
}
@end
