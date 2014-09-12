//
//  UIButton+EasyTapped
//  TouchMobLib
//
//  Created by Shane Gao on 8/3/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import "UIButton+EasyTapped.h"
#import <objc/runtime.h>

@implementation UIButton (EasyTapped)

+ (void)load
{
    Method originMethod = class_getInstanceMethod([UIButton class], @selector(pointInside:withEvent:));
    Method newMethod = class_getInstanceMethod([UIButton class], @selector(_pointInside:withEvent:));
    method_exchangeImplementations(originMethod, newMethod);
}

/**
 * 重写此方法，保证小于44x44大小的Button方便点击
 */
- (BOOL)_pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
