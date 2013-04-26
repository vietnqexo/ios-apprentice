//
//  CheckListViewController.h
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckListViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray *items;
-(void)addItem;
@end
