//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Nguyen Quoc Viet on 4/18/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import "BullsEyeViewController.h"
#import "AboutViewController.h"
@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController {
    int currentValue;
    int targetValue;
    int score;
    int nbOfRound;
}
@synthesize slider;
@synthesize targetLabel;
@synthesize roundLabel;
@synthesize scoreLabel;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startOver];
    [self updateLabels];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.slider = nil;
    self.targetLabel = nil;
    self.scoreLabel = nil;
    self.roundLabel = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) startNewRound
{
    currentValue = 50;
    targetValue = 1 + arc4random() % 100;
    self.slider.value = currentValue;
    
}
- (void) updateLabels
{
    self.targetLabel.text = [NSString stringWithFormat:@"%d", targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d",nbOfRound];
}
- (void)showAlert
{
    int diff = abs(currentValue - targetValue);
    int points = 100 - diff;
    score += points;
    nbOfRound++;
    NSString *message = [NSString stringWithFormat:@"You got %d points", points];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self startNewRound];
    [self updateLabels];
}
- (void)sliderMoved:(UISlider *)sender
{
    currentValue = lroundf(sender.value);
}
- (void)startOver
{
    score = 0;
    nbOfRound = 0;
    [self startNewRound];
    [self updateLabels];
    
}
- (void)showInfo
{
    AboutViewController *aboutView = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    aboutView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:aboutView animated:YES completion:nil];
}
@end
