//
//  LocationManaer.h
//  SGCocoaHelpers
//
//  Created by Shane Gao on 1/16/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef void(^CurrentAddressFoundBlock)(NSString *address);
typedef void(^CurrentAddressNotFoundBlock)();

@interface LocationManaer : NSObject <MKMapViewDelegate>
+ (instancetype)shared;

- (void)finderCurrentAddress:(CurrentAddressFoundBlock)found
                        fail:(CurrentAddressNotFoundBlock)fail;
@end
