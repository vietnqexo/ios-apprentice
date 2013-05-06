//
//  AllListViewController.h
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/4/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "DataModel.h"
@interface AllListViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) DataModel *dataModel;
@property (nonatomic, strong) IBOutlet UIImage *iconImage;
- (void)saveData;
@end
