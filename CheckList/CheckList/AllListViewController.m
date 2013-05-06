//
//  AllListViewController.m
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/4/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "AllListViewController.h"
#import "CheckList.h"
#import "CheckListViewController.h"
#import "ListDetailViewController.h"
@interface AllListViewController ()

@end

@implementation AllListViewController@synthesize dataModel;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder])) {
        self.dataModel = [[DataModel alloc] init];
    }
    return self;
}

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    
    int index = [self.dataModel getSelectedCheckListIndex];
    if(index != -1) {
        CheckList *checklist = [self.dataModel.lists objectAtIndex:index];
        [self performSegueWithIdentifier:@"ShowCheckList" sender:checklist];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    CheckList *list = [self.dataModel.lists objectAtIndex:indexPath.row];
    cell.textLabel.text = list.name;
    cell.detailTextLabel.text = [self detailForCheckList:list];
    cell.imageView.image = [UIImage imageNamed:list.iconName];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckList *checklist = [self.dataModel.lists objectAtIndex:indexPath.row];
    [self.dataModel setSelectedCheckListIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowCheckList" sender:checklist];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *deletedRow = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:deletedRow withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowCheckList"]) {
        CheckListViewController *controller = segue.destinationViewController;
        controller.checklist = sender;
    } else if([segue.identifier isEqualToString:@"AddCheckList"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *listDetailViewController = (ListDetailViewController *)navigationController.topViewController;
        listDetailViewController.delegate = self;
        listDetailViewController.checklistToEdit = nil;
    } else {
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *listDetailViewController = (ListDetailViewController *)navigationController.topViewController;
        listDetailViewController.delegate = self;
        listDetailViewController.checklistToEdit = sender;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CheckList *list = [self.dataModel.lists objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditCheckList" sender:list];
}
#pragma mark ListDetailViewController delegate methods

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingList:(CheckList *)list
{
    [self.dataModel.lists addObject:list];
    [self.dataModel sortCheckList];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingList:(CheckList *)list
{
    [self.dataModel sortCheckList];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetaiViewControllerDidCancel:(ListDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UINavigationControllerDelegate methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self == viewController) {
        [self.dataModel setSelectedCheckListIndex:-1];
    }
}

#pragma mark helper methods
- (NSString *)detailForCheckList:(CheckList *)checklist
{
    NSString *detail;
    int count = [checklist countUnCheckedItems];
    if([checklist.items count] == 0) {
        detail = @"No item";
    } else if(count == 0) {
        detail = @"(All done)";
    } else if(count > 0) {
        detail = [NSString stringWithFormat:@"%d remaining", count];
    }
    return detail;
}
@end
