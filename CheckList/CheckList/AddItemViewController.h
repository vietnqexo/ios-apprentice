//
//  AddItemViewController.h
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CheckListItem;
@class AddItemViewController;

@protocol AddItemViewControllerDelegate <NSObject>
- (void) addItemViewControllerDidCancel:(AddItemViewController *)controller;
- (void) addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(CheckListItem *)item;
- (void) addItemViewController:(AddItemViewController *)controller didFinishEditingItem:(CheckListItem *)item;
@end

@interface AddItemViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *inputItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) CheckListItem *editedItem;
@property (nonatomic, weak) id<AddItemViewControllerDelegate> delegate;
- (IBAction)cancel;
- (IBAction)done;
@end
