//
//  StringUtil.h
//  TouchMobLib
//
//  Created by Shane Gao on 7/20/08.
//  Copyright touchmob.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Helpers)
- (NSURL *)URLValue;
- (NSString *)URLEncodedString ;
- (NSString *)URLDecodedString;
- (NSString *)encodeAsURIComponent;
- (NSString *)escapeHTML;
- (NSString *)unescapeHTML;
+ (NSString *)localizedString:(NSString*)key;
+ (NSString *)base64encode:(NSString*)str;
+ (NSString *)flattenHTML:(NSString *)html;

- (NSString *)md5String;

- (BOOL)containString:(NSString *)cString;
+ (NSString *)stringOfNotificationTokenData:(NSData *)deviceToken;

- (NSString *)pinyinValue;
- (NSString *)trimmingAllWhitespaceAndNewlineCharacters;
@end


