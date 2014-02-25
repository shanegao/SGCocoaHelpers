//
//  VersionChecker.h
//  SGCocoaHelpers
//
//  Created by Shane Gao on 2/9/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionChecker : NSObject
+ (id)checker;
- (void)checkForAppId:(NSString *)appId;
@end
