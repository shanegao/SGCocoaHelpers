//
//  FileManager.h
//  TouchMobLib
//
//  Created by Shane Gao on 10-6-27.
//  Copyright 2010 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileManager : NSObject
+ (BOOL)isDirectory:(NSString *)filePath;
+ (NSString *)resourcePath;
+ (NSString *)cachesPath;
+ (NSString *)documentPath;
+ (NSArray *)allFilesInDirectory:(NSString *)directory;
+ (NSArray *)allFilesInDirectory:(NSString *)directory filteredBy:(NSString *)pathExtension;
+ (NSArray *)allFilesInPathAndItsSubpaths:(NSString *)directoryPath;
+ (NSString *)resourceFilePath:(NSString *)fileName;
+ (NSString *)parentDirectory:(NSString *) currentDirectory;
+ (BOOL)isFileExistsAtPath:(NSString *)filePath;
+ (BOOL)isFileInDocument:(NSString *)fileName;
+ (BOOL)isFileInResource:(NSString *)fileName;
+ (void)createEditableCopyOfFileIfNeeded:(NSString *)fileName toPath:(id)directoryPath;
+ (BOOL)deleteFile:(NSString *)fileName inDirectory:(NSString *)directoryPath;
@end
