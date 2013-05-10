//
//  DataModel.m
//  CheckList
//
//  Created by Nguyen Quoc Viet on 5/5/13.
//  Copyright (c) 2013 vietnq. All rights reserved.
//

#import "DataModel.h"
#import "CheckList.h"
#import "CheckListItem.h"
@implementation DataModel
@synthesize lists;

- (id)init
{
    if((self = [super init])) {
        [self loadCheckLists];
        [self sortCheckList];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}
- (void)saveCheckLists
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"CheckLists"];
    [archiver finishEncoding];
    [data writeToFile:[self filePath] atomically:YES];
}

- (void)loadCheckLists
{
    NSString *filePath = [self filePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.lists = [unarchiver decodeObjectForKey:@"CheckLists"];
        [unarchiver finishDecoding];
        
    } else {
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
        
    }
}
- (NSString *)documentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (NSString *)filePath
{
    return [[self documentDirectory] stringByAppendingPathComponent:@"CheckLists.plist"];
}

- (void)sortCheckList
{
    [self.lists sortUsingSelector:@selector(compare:)];
}
#pragma mark helper methods for previous selected checklist index
- (int)getSelectedCheckListIndex
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"SelectedCheckListIndex"];
}

- (void)setSelectedCheckListIndex:(int)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"SelectedCheckListIndex"];
}

- (void)registerDefaults
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:-1],@"SelectedCheckListIndex",
                                [NSNumber numberWithBool:YES],@"FirstTimeRun",
                                [NSNumber numberWithInt:0],@"CheckListItemId",
                                nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void)handleFirstTime
{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTimeRun"];
    if(firstTime){
        CheckList *checklist = [[CheckList alloc]initWithName:@"To-do"];
        [self.lists addObject:checklist];
        [self setSelectedCheckListIndex:0];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTimeRun"];
    }
}
+ (int)nextCheckListItemId
{
    int currentId = [[NSUserDefaults standardUserDefaults] integerForKey:@"CheckListItemId"];
    [[NSUserDefaults standardUserDefaults] setInteger:currentId + 1 forKey:@"CheckListItemId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return currentId + 1;
}
@end
