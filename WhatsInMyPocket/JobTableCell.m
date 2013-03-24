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

static NSString *kSelectNotification = @"DidSelectJobObjectNotification";

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
    [self _setSelected:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_jobDidChange:)
                                                 name:kSelectNotification
                                               object:nil];
}

- (void)toggleSelected;
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectNotification object:self];
    

}

- (void)_setSelected:(BOOL)selected;
{
    _isSelected = selected;
    NSString *name = (_isSelected) ? @"CheckMarkChecked" : @"CheckMarkUnchecked";
    NSLog(@"name %@", name);
    
//    [self _setImageWithName:name];
     self.checkMark.image = [UIImage imageNamed:name];
}

- (void)_jobDidChange:(NSNotification *)notification;
{
    JobTableCell *cell = (JobTableCell *)notification.object;
    [self _setSelected:([cell isEqual:self])];
}

- (void)_setImageWithName:(NSString *)name;
{
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
