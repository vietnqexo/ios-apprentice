//
//  SearchResultCell.h
//  StoreSearch
//
//  Created by Nguyen Quoc Viet on 7/24/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *artworkImageView;
@end
