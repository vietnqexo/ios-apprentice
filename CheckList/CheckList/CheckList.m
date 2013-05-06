//
//  CheckList.m
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/4/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "CheckList.h"
#import "CheckListItem.h"
@implementation CheckList
@synthesize name, items, iconName;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init])) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

- (id)initWithName:(NSString *)aName
{
    if((self = [super init])) {
        self.name = aName;
        self.items = [[NSMutableArray alloc]initWithCapacity:20];
        self.iconName = @"Folder";
    }
    return self;
}

- (int)countUnCheckedItems
{
    int count = 0;
    for(CheckListItem *item in self.items) {
        if(!item.checked) {
            count++;
        }
    }
    return count;
}

- (NSComparisonResult)compare:(CheckList *)otherCheckList
{
    return [self.name localizedCaseInsensitiveCompare:otherCheckList.name];
}
@end
