//
//  Random.h
//  TouchMobLib
//
//  Created by Shane Gao on 10-11-30.
//  Copyright 2010 touchmob.com All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Random : NSObject 
+(NSInteger)createRandomsizeValueInt:(NSInteger)fromInt toInt:(NSInteger)toInt;
+(double) createRandomsizeValueFloat:(double)fromFloat toFloat:(double)toFloat;

@end
