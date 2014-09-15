//
//  UIViewController+Helpers.m
//  SGCocoaHelpersDemo
//
//  Created by Shane Gao on 14/9/15.
//  Copyright (c) 2014年 touchmob.com. All rights reserved.
//

#import "UIViewController+Helpers.h"

@implementation UIViewController (Helpers)

- (void)removeAllChildControllers
{
    for (UIViewController* subViewController in self.childViewControllers){
        [subViewController willMoveToParentViewController:nil];
        [subViewController removeFromParentViewController];
    }
}
@end
