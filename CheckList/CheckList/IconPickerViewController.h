//
//  IconPickerViewController.h
//  CheckList
//
//  Created by vietnq on 5/6/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate
- (void)iconPickerViewController:(IconPickerViewController *)controller didFinishSelectingIcon:(NSString *)iconName;
@end
@interface IconPickerViewController : UITableViewController
@property (nonatomic, weak) id<IconPickerViewControllerDelegate> delegate;
@end
