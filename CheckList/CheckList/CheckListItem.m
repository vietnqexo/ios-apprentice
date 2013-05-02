//
//  CheckListItem.m
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "CheckListItem.h"

@implementation CheckListItem
@synthesize text, checked;

-(void)toggleCheck
{
    self.checked = !self.checked;
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
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}

@end
