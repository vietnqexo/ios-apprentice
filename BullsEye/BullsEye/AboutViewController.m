//
//  AboutViewController.m
//  BullsEye
//
//  Created by Nguyen Quoc Viet on 4/18/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)close
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
