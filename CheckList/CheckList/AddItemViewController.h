//
//  AddItemViewController.h
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *inputItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
- (IBAction)cancel;
- (IBAction)done;
@end
