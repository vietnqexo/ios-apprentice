//
//  SearchResult.m
//  StoreSearch
//
//  Created by Nguyen Quoc Viet on 7/24/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult
@synthesize name = _name;
@synthesize artistName = _artistName;
@synthesize artworkURL60 = _artworkURL60;
@synthesize artworkURL100 = _artworkURL100;
@synthesize storeURL = _storeURL;
@synthesize kind = _kind;
@synthesize currency = _currency;
@synthesize price = _price;
@synthesize genre = _genre;

- (NSComparisonResult)compareName:(SearchResult *)other
{
    return [self.name localizedCaseInsensitiveCompare:other.name];
}
@end
