//
//  CheckListViewController.h
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"

@interface CheckListViewController : UITableViewController <AddItemViewControllerDelegate>
@property (nonatomic, retain) NSMutableArray *items;
-(void)addItem;
@end
