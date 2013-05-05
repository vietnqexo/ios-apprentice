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

@implementation ItemDetailViewController
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
        [self.textField setText:editedItem.text];
    } else {
        self.title = @"Add Item";
        self.doneBarButton.enabled = NO;
    }
    [self.textField becomeFirstResponder];
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
        editedItem.text = self.textField.text;
        [self.delegate addItemViewController:self didFinishEditingItem:editedItem];
    } else {
        CheckListItem *item = [[CheckListItem alloc]initWithText:self.textField.text withCheckedState:NO];
        [self.delegate addItemViewController:self didFinishAddingItem:item];
    }
    
}
@end
