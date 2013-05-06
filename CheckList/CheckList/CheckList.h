//
//  CheckList.h
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/4/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckList : NSObject <NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSString *iconName;
- (id)initWithName:(NSString *)aName;
- (int)countUnCheckedItems;
@end
