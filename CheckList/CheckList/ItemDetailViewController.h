//
//  AddItemViewController.h
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"
@class CheckListItem;
@class ItemDetailViewController;

@protocol ItemDetailViewControllerDelegate <NSObject>
- (void) addItemViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void) addItemViewController:(ItemDetailViewController *)controller didFinishAddingItem:(CheckListItem *)item;
- (void) addItemViewController:(ItemDetailViewController *)controller didFinishEditingItem:(CheckListItem *)item;
@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate, DatePickerViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) CheckListItem *editedItem;
@property (nonatomic, weak) id<ItemDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UILabel *duedateLabel;
@property (nonatomic, strong) IBOutlet UISwitch *remindSwitch;
- (IBAction)cancel;
- (IBAction)done;
@end
