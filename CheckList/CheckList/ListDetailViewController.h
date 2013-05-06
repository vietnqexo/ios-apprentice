//
//  ListDetailViewController.h
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/4/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class CheckList;
@protocol ListDetailViewControllerDelegate
- (void)listDetaiViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingList:(CheckList *)list;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingList:(CheckList *)list;
@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) CheckList *checklistToEdit;
- (IBAction)done;
- (IBAction)cancel;
@end
