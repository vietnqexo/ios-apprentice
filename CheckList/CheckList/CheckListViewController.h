//
//  CheckListViewController.h
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"
#import "CheckList.h"
@interface CheckListViewController : UITableViewController <ItemDetailViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) CheckList *checklist;
-(void)addItem;
@end
