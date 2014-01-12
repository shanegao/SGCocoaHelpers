//
//  UIImage+Helpers.h
//  SGCocoaHelpersDemo
//
//  Created by Shane Gao on 13-12-10.
//  Copyright (c) 2013年 touchmob.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (Helpers)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage*)blurredImage:(CGFloat)blurAmount;

+ (UIImage *)screenshot;
@end
