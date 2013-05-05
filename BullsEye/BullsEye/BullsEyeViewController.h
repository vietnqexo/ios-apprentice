//
//  BullsEyeViewController.h
//  BullsEye
//
//  Created by Nguyen Quoc Viet on 4/18/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BullsEyeViewController : UIViewController <UIAlertViewDelegate>
@property(nonatomic, strong) IBOutlet UISlider *slider;
@property(nonatomic, strong) IBOutlet UILabel *targetLabel;
@property(nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property(nonatomic, strong) IBOutlet UILabel *roundLabel;
- (IBAction)showAlert;
- (IBAction)sliderMoved:(UISlider *)slider;
- (IBAction)startOver;
- (IBAction)showInfo;
@end
