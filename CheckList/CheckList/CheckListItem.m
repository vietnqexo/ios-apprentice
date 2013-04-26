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
- (id)initWithText:(NSString *)text withCheckedState:(BOOL)checked
{
    if((self = [super init])) {
        self.text = text;
        self.checked = checked;
    }
    return self;
}
@end
