//
//  CheckListViewController.m
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "CheckListViewController.h"
#import "CheckListItem.h"
@interface CheckListViewController ()
- (void)initItems;
- (void)configureCheckForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item;
- (void)configureTextForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item;
@end

@implementation CheckListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initItems];
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
    CheckListItem *item = [self.items objectAtIndex:indexPath.row];

    [self configureTextForCell:cell withCheckListItem:item];
    [self configureCheckForCell:cell withCheckListItem:item];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    CheckListItem *item = [self.items objectAtIndex:indexPath.row];
    [item toggleCheck];
    
    [self configureCheckForCell:cell withCheckListItem:item];
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.items removeObjectAtIndex:indexPath.row];
    NSArray *deletedRows = [NSArray arrayWithObject:indexPath];
    [self.tableView deleteRowsAtIndexPaths:deletedRows withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark Helper methods
- (void)initItems
{
    NSString *text;
    self.items = [[NSMutableArray alloc] initWithCapacity:20];
    for(int i = 0; i < 5; i++) {
        text = [NSString stringWithFormat:@"Item %d", i];
        [self.items addObject:[[CheckListItem alloc] initWithText:text withCheckedState:NO]];
    }
}
- (void)configureCheckForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item
{
    cell.accessoryType = (item.checked == YES) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}
- (void)configureTextForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item
{
    UILabel *label = (UILabel *) [cell viewWithTag:1000];
    label.text = item.text;
}
- (void)addItem
{
    int newRowIndex = [self.items count];
    
    CheckListItem *item = [[CheckListItem alloc] initWithText:@"I'm a new item" withCheckedState:NO];
    [self.items addObject:item];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *addedRows = [NSArray arrayWithObject:newIndexPath];
    [self.tableView insertRowsAtIndexPaths:addedRows withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
