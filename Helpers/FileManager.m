//
//  FileManager.m
//  TouchMobLib
//
//  Created by Shane Gao on 10-6-27.
//  Copyright 2010 touchmob.com. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (BOOL)isDirectory:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDir] && isDir;
}

+ (NSString *)resourcePath
{
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

+ (NSString *)cachesPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSArray *)allFilesInDirectory:(NSString *)directory
{
	return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:nil];
}

+ (NSArray *)allFilesInDirectory:(NSString *)directory filteredBy:(NSString *)pathExtension
{
    NSArray *contents = [self allFilesInDirectory:directory];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension ENDSWITH '%@'", pathExtension];
    return [contents filteredArrayUsingPredicate:predicate];
}

+ (NSArray *)allFilesInPathAndItsSubpaths:(NSString *)directoryPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtURL:[NSURL fileURLWithPath:directoryPath isDirectory:YES]
                                          includingPropertiesForKeys:@[NSURLNameKey, NSURLIsDirectoryKey]
                                                             options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        errorHandler:^BOOL(NSURL *url, NSError *error) {
                                                            NSLog(@"[Error] %@ (%@)", error, url);
                                                            return YES;
                                                        }];
    NSMutableArray *mutableFileURLs = [NSMutableArray array];
    for (NSURL *fileURL in enumerator) {
        NSString *filename;
        [fileURL getResourceValue:&filename forKey:NSURLNameKey error:nil];
        
        NSNumber *isDirectory;
        [fileURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
        
        // Skip directories with '_' prefix, for example
        if ([filename hasPrefix:@"_"] && [isDirectory boolValue]) {
            [enumerator skipDescendants];
            continue;
        }
        if (![isDirectory boolValue]) {
            [mutableFileURLs addObject:fileURL];
        }
    }
    
    return mutableFileURLs;
}

+ (NSString *)resourceFilePath:(NSString *)fileName
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
}

+ (NSString *)parentDirectory:(NSString *) currentDirectory
{
    return [currentDirectory stringByDeletingLastPathComponent];
}

+ (BOOL)isFileInDocument:(NSString *)fileName
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[[self documentPath] stringByAppendingPathComponent:fileName]];
}

+ (BOOL)isFileExistsAtPath:(NSString *)filePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)isFileInResource:(NSString *)fileName
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self resourceFilePath:fileName]];
}

+ (BOOL)deleteFile:(NSString *)fileName inDirectory:(NSString *)directoryPath
{
    NSError *err = nil;
    return [[NSFileManager defaultManager] removeItemAtPath:[directoryPath stringByAppendingPathComponent:fileName] error:&err];
}

+ (void)createEditableCopyOfFileIfNeeded:(NSString *)fileName toPath:(id)directoryPath
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *writablePath = [directoryPath stringByAppendingPathComponent: fileName];
    success = [fileManager fileExistsAtPath:writablePath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultPath = [[[NSBundle mainBundle] resourcePath]
							   stringByAppendingPathComponent:fileName];
    success = [fileManager copyItemAtPath:defaultPath toPath:writablePath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable file with message '%@'.",
                  [error localizedDescription]);
    }
}

@end
