//
//  UIImageView+Helpers.m
//  SGCocoaHelper
//
//  Created by Shane Gao on 1/12/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import "UIImageView+Helpers.h"

@implementation UIImageView (Helpers)

+ (instancetype)imageViewWithImageNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    UIImageView *v = [[UIImageView alloc] initWithFrame:(CGRect){CGPointZero, image.size}];
    v.image = image;
    return v;
}

@end
