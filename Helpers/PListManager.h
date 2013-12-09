//
//  PListManager.h
//  TouchMobLib
//
//  Created by Shane on 10-12-8.
//  Copyright 2010 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PListManager : NSObject {

}

+ (void)writePlistData:(id)plistData toPlistFile:(NSString*)plistFileName;
+ (id)readPlistFileInDocumentDirectory:(NSString*)plistFileName;
+ (id)readPlistFileAt:(NSString *)filePath;
@end
