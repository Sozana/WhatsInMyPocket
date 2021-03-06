//
//  OptionTableCell.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/22/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "OptionTableCell.h"

@interface OptionTableCell ()
{
    BOOL _isSelected;
}

@end
@implementation OptionTableCell

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

- (void)setOption:(Option *)option;
{
    _option = option;
    _label.text = _option.name;
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



@end
