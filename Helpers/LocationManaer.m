//
//  LocationManaer.m
//  SGCocoaHelpers
//
//  Created by Shane Gao on 1/16/14.
//  Copyright (c) 2014 touchmob.com. All rights reserved.
//

#import "LocationManaer.h"
#import <AddressBookUI/AddressBookUI.h>

@interface LocationManaer ()
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, copy) CurrentAddressFoundBlock foundAddressBlock;
@property (nonatomic, copy) CurrentAddressNotFoundBlock notFoundAddressBlock;
@end

@implementation LocationManaer
+ (instancetype)shared
{
    static id sharedManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedManager = [[self alloc] init];
	});
	return sharedManager;
}

- (void)startLocation
{
    if (self.mapView) {
        [self stopLocation];
    }
    MKMapView *mapView = [[MKMapView alloc] init];
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    self.mapView = mapView;
}

- (void)stopLocation
{
    self.mapView.showsUserLocation = NO;
    self.mapView = nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation");
    CLLocation *newLocation = userLocation.location;
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLGeocodeCompletionHandler handle = ^(NSArray *placemarks,NSError *error)
    {
        for (CLPlacemark * placeMark in placemarks)
        {
            if (_foundAddressBlock) {
                
                NSString *state = placeMark.locality;
                NSString *city = placeMark.subLocality;
                NSString *area = placeMark.administrativeArea;
                NSString *thoroughfare = placeMark.thoroughfare;
                NSString *subThoroughfare = placeMark.subThoroughfare;
                NSMutableString *address = [NSMutableString string];
                if (state) {
                    [address appendString:state];
                }
                if (area) {
                    [address appendString:area];
                }
                
                if (city) {
                    [address appendString:city];
                }
                if (thoroughfare) {
                    [address appendString:thoroughfare];
                }
                
                if (subThoroughfare) {
                    [address appendString:subThoroughfare];
                }
                _foundAddressBlock(address);
                break;
            }
        }
    };
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:handle];
    //for only called once
    [self stopLocation];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self stopLocation];
    if (_notFoundAddressBlock) {
        _notFoundAddressBlock();
    }
}


- (void)finderCurrentAddress:(CurrentAddressFoundBlock)found
                        fail:(CurrentAddressNotFoundBlock)fail
{
    self.foundAddressBlock = found;
    self.notFoundAddressBlock = fail;
    [self startLocation];
}
@end
