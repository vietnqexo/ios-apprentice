//
//  IconPickerViewController.m
//  CheckList
//
//  Created by vietnq on 5/6/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController {
    NSMutableArray *iconNameArray;
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
    
    iconNameArray = [NSMutableArray arrayWithObjects:@"Appointments",
                     @"Birthdays",
                     @"Chores",
                     @"Drinks",
                     @"Folder",
                     @"Groceries",
                     @"Inbox",
                     @"Photos",
                     @"Trips",
                     @"No Icon",nil];
    
    self.title = @"Icon Picker";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [iconNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IconPickerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *iconName = [iconNameArray objectAtIndex:indexPath.row];
    cell.textLabel.text = iconName;
    cell.imageView.image = [UIImage imageNamed:iconName];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iconName = [iconNameArray objectAtIndex:indexPath.row];
    [self.delegate iconPickerViewController:self didFinishSelectingIcon:iconName];
}

@end
