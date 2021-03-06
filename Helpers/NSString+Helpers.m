//
//  StringUtil.m
//  TouchMobLib
//
//  Created by Shane Gao on 7/20/08.
//  Copyright touchmob.com. All rights reserved.
//

#import "NSString+Helpers.h"
#import <CommonCrypto/CommonDigest.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"; 

@implementation NSString (Helpers)

- (NSURL *)URLValue
{
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)URLEncodedString 
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                       (CFStringRef)self,
                                                                       NULL,
                                                                       CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                       kCFStringEncodingUTF8));
}

- (NSString*)URLDecodedString
{
	return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8));	
}
- (NSString*)encodeAsURIComponent
{
	const char* p = [self UTF8String];
	NSMutableString* result = [NSMutableString string];
	
	for (;*p ;p++) {
		unsigned char c = *p;
		if (('0' <= c && c <= '9') || ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || c == '-' || c == '_') {
			[result appendFormat:@"%c", c];
		} else {
			[result appendFormat:@"%%%02X", c];
		}
	}
	return result;
}

+ (NSString*)base64encode:(NSString*)str 
{
    @autoreleasepool {
        if ([str length] == 0)
            return @"";
        
        const char *source = [str UTF8String];
        size_t strlength  = strlen(source);
        
        char *characters = malloc(((strlength + 2) / 3) * 4);
        if (characters == NULL)
            return nil;
        
        NSUInteger length = 0;
        NSUInteger i = 0;
        
        while (i < strlength) {
            char buffer[3] = {0,0,0};
            short bufferLength = 0;
            while (bufferLength < 3 && i < strlength)
                buffer[bufferLength++] = source[i++];
            characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
            characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
            if (bufferLength > 1)
                characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
            else characters[length++] = '=';
            if (bufferLength > 2)
                characters[length++] = encodingTable[buffer[2] & 0x3F];
            else characters[length++] = '=';
        }
        
        return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
    }
}

- (NSString*)escapeHTML
{
	NSMutableString* s = [NSMutableString string];
	
	NSInteger start = 0;
	NSUInteger len = [self length];
	NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
	
	while (start < len) {
		NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
		if (r.location == NSNotFound) {
			[s appendString:[self substringFromIndex:start]];
			break;
		}
		
		if (start < r.location) {
			[s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
		}
		
		switch ([self characterAtIndex:r.location]) {
			case '<':
				[s appendString:@"&lt;"];
				break;
			case '>':
				[s appendString:@"&gt;"];
				break;
			case '"':
				[s appendString:@"&quot;"];
				break;
			case '&':
				[s appendString:@"&amp;"];
				break;
		}
		
		start = r.location + 1;
	}
	
	return s;
}

- (NSString*)unescapeHTML
{
	@autoreleasepool {
        NSMutableString* s = [NSMutableString string];
        NSMutableString* target = [self mutableCopy];
                                   NSCharacterSet* chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
                                   
                                   while ([target length] > 0) {
                                       NSRange r = [target rangeOfCharacterFromSet:chs];
                                       if (r.location == NSNotFound) {
                                           [s appendString:target];
                                           break;
                                       }
                                       
                                       if (r.location > 0) {
                                           [s appendString:[target substringToIndex:r.location]];
                                           [target deleteCharactersInRange:NSMakeRange(0, r.location)];
                                       }
                                       
                                       if ([target hasPrefix:@"&lt;"]) {
                                           [s appendString:@"<"];
                                           [target deleteCharactersInRange:NSMakeRange(0, 4)];
                                       } else if ([target hasPrefix:@"&gt;"]) {
                                           [s appendString:@">"];
                                           [target deleteCharactersInRange:NSMakeRange(0, 4)];
                                       } else if ([target hasPrefix:@"&quot;"]) {
                                           [s appendString:@"\""];
                                           [target deleteCharactersInRange:NSMakeRange(0, 6)];
                                       } else if ([target hasPrefix:@"&amp;"]) {
                                           [s appendString:@"&"];
                                           [target deleteCharactersInRange:NSMakeRange(0, 5)];
                                       } else {
                                           [s appendString:@"&"];
                                           [target deleteCharactersInRange:NSMakeRange(0, 1)];
                                       }
                                   }
                                   
        return s;
    }
}

+ (NSString*)localizedString:(NSString*)key
{
	return [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:key];
}

+ (NSString *)flattenHTML:(NSString *)html
{
    
    NSScanner *thescanner;
    NSString *text = nil;
    
    thescanner = [NSScanner scannerWithString:html];
    
    while ([thescanner isAtEnd] == NO) {
        
        // find start of tag
        [thescanner scanUpToString:@"<" intoString:NULL] ; 
        
        // find end of tag
        [thescanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "]; 
    } // while //
    
    return html;
    
}

- (NSString *)md5String
{
    const char *str = [self UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *md5Result = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return md5Result;
}

- (BOOL)containString:(NSString *)cString
{
    return [self rangeOfString:cString].length > 0 && [self rangeOfString:cString].length <= self.length ;
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

- (NSString *)pinyinValue
{
    NSMutableString *source = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    //CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    return source;
}

- (NSString *)trimmingAllWhitespaceAndNewlineCharacters
{
    NSString *source = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *components = [source componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
    return [components componentsJoinedByString:@""];
}

@end



