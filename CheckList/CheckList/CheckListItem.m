//
//  CheckListItem.m
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "CheckListItem.h"
#import "DataModel.h"
@implementation CheckListItem
@synthesize text, checked;
@synthesize dueDate, itemId, shouldRemind;

-(void)toggleCheck
{
    self.checked = !self.checked;
}

- (id) init
{
    if((self = [super init])) {
        self.itemId = [DataModel nextCheckListItemId];
    }
    return self;
}
- (id)initWithText:(NSString *)aText withCheckedState:(BOOL)aChecked
{
    if((self = [super init])) {
        self.text = aText;
        self.checked = aChecked;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"ItemId"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.itemId = [aDecoder decodeIntForKey:@"ItemId"];
    }
    return self;
}

- (void)scheduleNotification
{
    UILocalNotification *existingNotification = [self notificationOfThisItem];
    if(existingNotification) {
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    if(self.shouldRemind && ([self.dueDate compare:[NSDate date]] != NSOrderedAscending)) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        
        notification.userInfo = [NSDictionary dictionaryWithObject: [NSNumber numberWithInt:self.itemId] forKey:@"CheckListItemId"];
        notification.fireDate = self.dueDate;
        notification.alertBody = self.text;
        notification.timeZone = [NSTimeZone systemTimeZone];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        NSLog(@"scheduled notification for item: %@", self.text);
    }
}

- (UILocalNotification *)notificationOfThisItem
{
    NSArray *notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in notifications) {
        NSNumber *number = [notification.userInfo objectForKey:@"CheckListItemId"];
        if(number != nil && [number intValue] == self.itemId) {
            NSLog(@"found notification for item: %@", self.text);
            return notification;
        }
    }
    return nil;
}

- (void)dealloc
{
    UILocalNotification *notification = [self notificationOfThisItem];
    if(notification != nil) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}
@end
