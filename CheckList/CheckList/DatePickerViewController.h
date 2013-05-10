//
//  DatePickerViewController.h
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/10/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DatePickerViewController;

@protocol DatePickerViewControllerDelegate
- (void)datePicker:(DatePickerViewController *)controller didFinishPickingDate:(NSDate *)date;
- (void)datePickerDidCancel:(DatePickerViewController *)controller;
@end

@interface DatePickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *picker;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, weak) id<DatePickerViewControllerDelegate> delegate;

-(IBAction)done;
-(IBAction)cancel;
-(IBAction)dateChanged;
@end
