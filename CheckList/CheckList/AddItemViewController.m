//
//  AddItemViewController.m
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "AddItemViewController.h"
#import "CheckListItem.h"
@interface AddItemViewController ()

@end

@implementation AddItemViewController
@synthesize delegate;
@synthesize editedItem;
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
        [self.inputItem setText:editedItem.text];
    } else {
        self.title = @"Add Item";
        self.doneBarButton.enabled = NO;
    }
    [self.inputItem becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}
-(void)cancel
{
    [self.delegate addItemViewControllerDidCancel:self];
}
- (void)done
{
    if(self.editedItem) {
        editedItem.text = self.inputItem.text;
        [self.delegate addItemViewController:self didFinishEditingItem:editedItem];
    } else {
        CheckListItem *item = [[CheckListItem alloc]initWithText:self.inputItem.text withCheckedState:NO];
        [self.delegate addItemViewController:self didFinishAddingItem:item];
    }
    
}
@end
