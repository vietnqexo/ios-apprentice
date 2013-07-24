//
//  SearchResultCell.m
//  StoreSearch
//
//  Created by Nguyen Quoc Viet on 7/24/13.
//  Copyright (c) 2013 Nguyen Quoc Viet. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell
@synthesize nameLabel = _nameLabel;
@synthesize artistNameLabel = _artistNameLabel;
@synthesize artworkImageView = _artworkImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableCellGradient"]];
    self.backgroundView = bgImageView;
    
    UIImageView *selectedBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SelectedTableCellGradient"]];
    self.selectedBackgroundView = selectedBgImageView;
}
@end
