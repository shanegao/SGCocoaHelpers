//
//  PListManager.m
//  TouchMobLib
//
//  Created by Shane on 10-12-8.
//  Copyright 2010 touchmob.com. All rights reserved.
//

#import "PListManager.h"
#import "FileManager.h"

@implementation PListManager

+ (void)writePlistData:(id)plistData toPlistFile:(NSString*)plistFileName 
{
	NSString *error;
    NSString *plistPath = [[FileManager documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", plistFileName]];
    NSData *data = [NSPropertyListSerialization dataFromPropertyList:plistData
																   format:NSPropertyListXMLFormat_v1_0
														 errorDescription:&error];
    if(data) {
        [data writeToFile:plistPath atomically:YES];
    } else {
        NSLog(@"error:%@",error);
    }
}

+ (id)readPlistFileInDocumentDirectory:(NSString*)plistFileName 
{
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSString *plistPath = [[FileManager documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",plistFileName]];
    /*
	if (![FileManager isFileExistsAtPath:plistPath]) {
		plistPath = [[NSBundle mainBundle] pathForResource:plistFileName ofType:@"plist"];
	}
    */
	NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	id result = [NSPropertyListSerialization propertyListFromData:plistData
                                                 mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                           format:&format
                                                 errorDescription:&errorDesc];
	if (!result) {
		NSLog(@"Error reading plist: %@, format: %u", errorDesc, format);
	}
	return result ;
}

+ (id)readPlistFileAt:(NSString *)filePath
{
    NSString *errorDesc = nil;
	NSPropertyListFormat format;
    
    id result = nil;
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:filePath];
		result = [NSPropertyListSerialization propertyListFromData:plistData
                                                     mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                               format:&format
                                                     errorDescription:&errorDesc];
        if (!result) {
            NSLog(@"Error reading plist: %@, format: %u", errorDesc, format);
        }
	}
	
	return result ;
}
@end
