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

- (void)switchStatusBarWithView:(UIView *)view barHidden:(BOOL)statusBarHidden
{
    [[UIApplication sharedApplication] setStatusBarHidden:statusBarHidden withAnimation:UIStatusBarAnimationFade];
    float __alpha = statusBarHidden ? 1 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = __alpha;
    }];
}
@end
