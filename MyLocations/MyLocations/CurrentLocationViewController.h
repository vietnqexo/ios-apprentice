//
//  FirstViewController.h
//  MyLocations
//
//  Created by Nguyen Quoc Viet on 5/11/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface CurrentLocationViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *tagButton;
@property (weak, nonatomic) IBOutlet UIButton *getLocationButton;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
- (IBAction)tagLocation:(id)sender;
- (IBAction)getLocation:(id)sender;

@end
