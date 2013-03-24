//
//  JobTableCell.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "JobTableCell.h"

@interface JobTableCell ()
{
    BOOL _isSelected;
}

@end

@implementation JobTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib;
{
    [self _setImageWithName:@"CheckMarkUnchecked"];
}

- (void)toggleSelected;
{
    _isSelected = !_isSelected;
    NSString *name = (_isSelected) ? @"CheckMarkChecked" : @"CheckMarkUnchecked";
    [self _setImageWithName:name];
}

- (void)_setImageWithName:(NSString *)name;
{
    self.checkMark.image = [UIImage imageNamed:name];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
