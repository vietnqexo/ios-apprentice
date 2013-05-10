//
//  CheckListViewController.m
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "CheckListViewController.h"
#import "CheckListItem.h"
#import "ItemDetailViewController.h"
@interface CheckListViewController ()
- (void)configureCheckForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item;
- (void)configureTextForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item;
@end

@implementation CheckListViewController
@synthesize checklist;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = self.checklist.name;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView delegate methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckListItem"];
    CheckListItem *item = [self.checklist.items objectAtIndex:indexPath.row];

    [self configureTextForCell:cell withCheckListItem:item];
    [self configureCheckForCell:cell withCheckListItem:item];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    CheckListItem *item = [self.checklist.items objectAtIndex:indexPath.row];
    [item toggleCheck];
    [self configureCheckForCell:cell withCheckListItem:item];
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.checklist.items count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.checklist.items removeObjectAtIndex:indexPath.row];

    NSArray *deletedRows = [NSArray arrayWithObject:indexPath];
    [self.tableView deleteRowsAtIndexPaths:deletedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CheckListItem *item = [self.checklist.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:item];
}
#pragma mark Helper methods

- (void)configureCheckForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item
{
    UILabel *checkedLabel = (UILabel *) [cell viewWithTag:1001];
    if(item.checked){
        checkedLabel.text = @"√";
    } else {
        checkedLabel.text = @"";
    }
}
- (void)configureTextForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item
{
    UILabel *label = (UILabel *) [cell viewWithTag:1000];
    label.text = item.text;
}

#pragma mark prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
    controller.delegate = self;

    if([segue.identifier isEqualToString:@"EditItem"]) {
        controller.editedItem = sender;
    }
}


#pragma markd AddItemViewController delegate methods
- (void)addItemViewController:(ItemDetailViewController *)controller didFinishAddingItem:(CheckListItem *)item
{    
    [self.checklist.items addObject:item];
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewControllerDidCancel:(ItemDetailViewController *)controller
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(ItemDetailViewController *)controller didFinishEditingItem:(CheckListItem *)item
{
    [self.tableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
