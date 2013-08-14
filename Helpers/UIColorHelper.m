//
//  UIColor+Hex.m
//  SGCocoaHelpers
//
//  Created by Shane Gao on 12-10-8.
//  Copyright (c) 2012年 touchmob.com. All rights reserved.
//

#import "UIColorHelper.h"

@implementation UIColor (Helper)
/**
 *	Create a UIColor with hex value
 *
 *	@param	hex
 *          0xFFAABBCC , FF for alpha, the rest for   RGB value
 *
 *	@return	UIColor instance
 */
+ (UIColor *)colorWithHex:(uint)hex
{
    int red, green, blue, alpha;
    blue = hex & 0x000000FF;
    green = ((hex & 0x0000FF00) >> 8);
    red = ((hex & 0x00FF0000) >> 16);
    alpha = ((hex & 0xFF000000) >> 24);
    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:alpha/255.0f];
}
@end
