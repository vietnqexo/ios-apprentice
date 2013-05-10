//
//  DataModel.h
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/5/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property (nonatomic,strong) NSMutableArray *lists;
- (void)saveCheckLists;
- (void)setSelectedCheckListIndex:(int)index;
- (int)getSelectedCheckListIndex;
- (void)sortCheckList;
+ (int)nextCheckListItemId;
@end
