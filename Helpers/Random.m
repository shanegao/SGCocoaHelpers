//
//  Random.m
//  TouchMobLib
//
//  Created by Shane Gao on 10-11-30.
//  Copyright 2010 touchmob.com All rights reserved.
//

#import "Random.h"
#import <stdlib.h>

@implementation Random

//！随机数的最大值
#define ARC4RANDOM_MAX      0x100000000

+ (NSInteger)createRandomsizeValueInt:(NSInteger)fromInt toInt:(NSInteger)toInt
{
    if (toInt < fromInt) {
        return toInt;
    } else if (toInt == fromInt) {
        return fromInt;
    }
    return arc4random() % (toInt - fromInt + 1) + fromInt;
}

+ (double)createRandomsizeValueFloat:(double)fromFloat toFloat:(double)toFloat
{
    if (toFloat < fromFloat) {
        return toFloat;
    } else if (toFloat == fromFloat) {
        return fromFloat;
    }
    return ((double)arc4random() / ARC4RANDOM_MAX) * (toFloat - fromFloat) + fromFloat;
}

@end
