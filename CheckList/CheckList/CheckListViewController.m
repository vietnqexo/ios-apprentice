//
//  CheckListViewController.m
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "CheckListViewController.h"
#import "CheckListItem.h"
#import "AddItemViewController.h"
@interface CheckListViewController ()
- (void)configureCheckForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item;
- (void)configureTextForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item;
@end

@implementation CheckListViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder])) {
        [self loadCheckListItems];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"File path: %@", [self filePath]);
    NSLog(@"%d", [self.items count]);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Load and Save data to file
- (void) loadCheckListItems
{
    NSString *filePath = [self filePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        self.items = [unarchiver decodeObjectForKey:@"CheckListItems"];
        [unarchiver finishDecoding];
    } else {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

- (void) saveCheckListItems
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *keyArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [keyArchiver encodeObject:self.items forKey:@"CheckListItems"];
    [keyArchiver finishEncoding];
    [data writeToFile:[self filePath] atomically:YES];
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
    [self saveCheckListItems];
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
    [self saveCheckListItems];

    NSArray *deletedRows = [NSArray arrayWithObject:indexPath];
    [self.tableView deleteRowsAtIndexPaths:deletedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CheckListItem *item = [self.items objectAtIndex:indexPath.row];
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

- (NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (NSString *)filePath
{
    return [[self documentDirectory] stringByAppendingPathComponent:@"CheckList.plist"];
}
#pragma mark prepare for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *navigationController = segue.destinationViewController;
    AddItemViewController *controller = (AddItemViewController *)navigationController.topViewController;
    controller.delegate = self;

    if([segue.identifier isEqualToString:@"EditItem"]) {
        controller.editedItem = sender;
    }
}


#pragma markd AddItemViewController delegate methods
- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(CheckListItem *)item
{
    int newRowIndex = [self.items count];
    
    [self.items addObject:item];
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *addedRows = [NSArray arrayWithObject:newIndexPath];
    [self.tableView insertRowsAtIndexPaths:addedRows withRowAnimation:UITableViewRowAnimationAutomatic];
   
    [self saveCheckListItems];
    NSLog(@"nb:%d",[self.items count]);

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewController:(AddItemViewController *)controller didFinishEditingItem:(CheckListItem *)item
{
    int index = [self.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withCheckListItem:item];
    
    [self saveCheckListItems];

    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
