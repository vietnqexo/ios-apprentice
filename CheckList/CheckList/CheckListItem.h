//
//  CheckListItem.h
//  CheckList
//
//  Created by vietnq on 4/26/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckListItem : NSObject <NSCoding>
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;
- (void)toggleCheck;
- (id) initWithText:(NSString *)text withCheckedState:(BOOL)checked;
@end
