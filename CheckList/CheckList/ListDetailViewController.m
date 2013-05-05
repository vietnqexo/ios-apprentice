//
//  ListDetailViewController.m
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/4/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "ListDetailViewController.h"
#import "CheckList.h"
@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
@synthesize textField, doneBarButton, checklistToEdit, delegate;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if(self.checklistToEdit) {
        self.doneBarButton.enabled = YES;
        self.title = @"Edit List";
        self.textField.text = self.checklistToEdit.name;
    } else {
        self.doneBarButton.enabled = NO;
        self.title = @"Add List";
    }
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done
{
    if(self.checklistToEdit) {
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishEditingList:self.checklistToEdit];
    } else {
        CheckList *newList = [[CheckList alloc] initWithName:self.textField.text];
        [self.delegate listDetailViewController:self didFinishAddingList:newList];
    }
}

- (void)cancel
{
    [self.delegate listDetaiViewControllerDidCancel:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [self.textField.text stringByReplacingCharactersInRange:range withString:string];
    if([newText length] > 0) {
        self.doneBarButton.enabled = YES;
    } else {
        self.doneBarButton.enabled = NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    CheckList *newList = [[CheckList alloc] initWithName:self.textField.text];
    [self.delegate listDetailViewController:self didFinishAddingList:newList];
    return YES;
}

@end
