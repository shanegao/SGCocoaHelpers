//
//  MKMapView+ZoomControl.h
//  TouchMobLib
//
//  Created by Gao Shane on 12-1-7.
//  Copyright (c) 2012年 touchmob.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapView (Helpers)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end 
