//
//  FirstViewController.m
//  MyLocations
//
//  Created by Nguyen Quoc Viet on 5/11/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import "CurrentLocationViewController.h"

@interface CurrentLocationViewController ()
- (void) updateLabels;
- (void) startLocationManager;
- (void) stopLocationManager;
- (void) configureGetButton;
@end

@implementation CurrentLocationViewController {
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLLocation *location;
    NSError *lastLocationError;
    BOOL updatingLocation;
    BOOL performingGeoLocation;
    NSError *lastGeoLocationError;
    CLPlacemark *placemark;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder])) {
        locationManager = [[CLLocationManager alloc] init];
        geocoder = [[CLGeocoder alloc] init];
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateLabels];
    [self configureGetButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tagLocation:(id)sender {
}

- (IBAction)getLocation:(id)sender {
    if(updatingLocation) {
        [self stopLocationManager];
    } else {
        location = nil;
        lastLocationError = nil;
        lastGeoLocationError = nil;
        [self startLocationManager];
    }
    [self updateLabels];
    [self configureGetButton];
    
}

#pragma mark CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error loading location: %@", [error localizedDescription]);
    if(error.code == kCLErrorLocationUnknown) {
        return;
    }
    [self stopLocationManager];

    lastLocationError = error;
    [self updateLabels];
    [self configureGetButton];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if([newLocation.timestamp timeIntervalSinceNow] < -5.0) {
        return;
    }
    if(newLocation.horizontalAccuracy < 0) {
        return;
    }
    if(location == nil || newLocation.horizontalAccuracy < location.horizontalAccuracy) {
        lastLocationError = nil;
        location = newLocation;
        [self updateLabels];
        [self configureGetButton];
        if(newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
            [self stopLocationManager];
            [self configureGetButton];
        }
        
        if(!performingGeoLocation) {
            performingGeoLocation = YES;
            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                lastGeoLocationError = error;
                if(error == nil && [placemarks count] > 0) {
                    placemark = [placemarks lastObject];
                } else {
                    placemark = nil;
                }
                performingGeoLocation = NO;
                [self updateLabels];
            }];
        }
    }
    
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)updateLabels
{
    if(location != nil) {
        self.messageLabel.text = @"GPS Coordinates";
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f",location.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:@"%.8f", location.coordinate.longitude];
        self.tagButton.hidden = NO;
        if(placemark != nil) {
            self.addressLabel.text = [self stringFromPlaceMark:placemark];
        } else if(performingGeoLocation) {
            self.addressLabel.text = @"Searching for address";
        } else if(lastGeoLocationError != nil) {
            self.addressLabel.text = @"Error loading address";
        } else {
            self.addressLabel.text = @"No address found";
        }
    } else {
        self.latitudeLabel.text = @"";
        self.longitudeLabel.text = @"";
        self.addressLabel.text = @"";
        self.tagButton.hidden = YES;
        NSString *statusMessage;
        if(lastLocationError != nil) {
            if([lastLocationError.domain isEqualToString:kCLErrorDomain]  && lastLocationError.code == kCLErrorDenied) {
                statusMessage = @"Location service disabled";
            } else {
                statusMessage = @"Error loading location";
            }
        } else if(![CLLocationManager locationServicesEnabled]) {
            statusMessage = @"Location service disabled";
        } else  if(updatingLocation) {
            statusMessage = @"Searching...";
        } else {
            statusMessage = @"Press the button to start";
        }
        self.messageLabel.text = statusMessage;
    }
}

- (void)startLocationManager
{
    if([CLLocationManager locationServicesEnabled]) {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [locationManager startUpdatingLocation];
        updatingLocation = YES;
    }
}
- (void)stopLocationManager
{
    if(updatingLocation) {
        [locationManager stopUpdatingLocation];
        locationManager.delegate = nil;
        updatingLocation = NO;
    }
}

- (void)configureGetButton
{
    if(updatingLocation) {
        [self.getLocationButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [self.getLocationButton setTitle:@"Get location" forState:UIControlStateNormal];
    }
}

- (NSString *)stringFromPlaceMark:(CLPlacemark *)aplacemark
{
    return  [NSString stringWithFormat:@"%@ %@\n%@ %@ %@",aplacemark.subThoroughfare, aplacemark.thoroughfare, aplacemark.locality, aplacemark.administrativeArea, aplacemark.postalCode];
}
@end
