//
//  UIImage+Helpers.m
//  SGCocoaHelpersDemo
//
//  Created by Shane Gao on 13-12-10.
//  Copyright (c) 2013年 touchmob.com. All rights reserved.
//

#import "UIImage+Helpers.h"

@implementation UIImage (Helpers)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}
@end
