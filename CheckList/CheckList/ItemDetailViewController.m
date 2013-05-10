//
//  AddItemViewController.m
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "CheckListItem.h"
@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController {
    NSDate *dueDate;
}
@synthesize delegate;
@synthesize editedItem;
@synthesize remindSwitch, duedateLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.editedItem) {
        self.title = @"Edit Item";
        self.doneBarButton.enabled = YES;
        [self.textField setText:editedItem.text];
        self.remindSwitch.on = self.editedItem.shouldRemind;
        dueDate = self.editedItem.dueDate;
    } else {
        self.title = @"Add Item";
        self.doneBarButton.enabled = NO;
        dueDate = [NSDate date];
        self.remindSwitch.on = NO;
    }
    [self updateDueDateLabel];
    [self.textField becomeFirstResponder];
}
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2) {
        return indexPath;
    } else {
        return nil;
    }
}
#pragma mark helper methods
- (void)updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.duedateLabel.text = [formatter stringFromDate:dueDate];
    
}

#pragma mark UITextFieldDelegate methods
-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

#pragma mark actions
-(void)cancel
{
    [self.delegate addItemViewControllerDidCancel:self];
}
- (void)done
{
    if(self.editedItem) {
        self.editedItem.text = self.textField.text;
        self.editedItem.shouldRemind = self.remindSwitch.on;
        self.editedItem.dueDate = dueDate;
        [self.editedItem scheduleNotification];
        [self.delegate addItemViewController:self didFinishEditingItem:editedItem];
    } else {
        CheckListItem *item = [[CheckListItem alloc]initWithText:self.textField.text withCheckedState:NO];
        item.shouldRemind = self.remindSwitch.on;
        item.dueDate = dueDate;
        [item scheduleNotification];
        [self.delegate addItemViewController:self didFinishAddingItem:item];
    }
}

#pragma mark DatePickerViewController delegate methods

- (void)datePickerDidCancel:(DatePickerViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)datePicker:(DatePickerViewController *)controller didFinishPickingDate:(NSDate *)date
{
    dueDate = date;
    [self updateDueDateLabel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PickDate"]) {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
}
@end
