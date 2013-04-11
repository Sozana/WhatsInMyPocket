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
//    BOOL _isSelected;
}

@end
@implementation JobSelectionTableCell


- (void)toggleSelected;
{
    BOOL isSelected = !_isSelected;
    NSLog(@"_isSelected %d", isSelected);
    [self setIncluded:isSelected];
}

- (void)setIncluded:(BOOL)included;
{
    _isSelected = included;
    self.accessoryType = (included) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
