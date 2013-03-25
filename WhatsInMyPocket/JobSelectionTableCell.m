//
//  JobSelectionTableCell.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/24/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "JobSelectionTableCell.h"
@interface JobSelectionTableCell ()
{
    BOOL _isSelected;
}

@end
@implementation JobSelectionTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)toggleSelected;
{
    _isSelected = !_isSelected;
    self.accessoryType = (_isSelected) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
