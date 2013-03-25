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
    [self _setSelected:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_jobDidChange:)
                                                 name:kJobSelectedNotification
                                               object:nil];
}

- (void)setJob:(Job *)job;
{
    _job = job;
    _label.text = _job.name;
}

- (void)toggleSelected;
{
    [self _setSelected:(_isSelected) ? NO : YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kJobSelectedNotification object:_job];
}

- (void)_setSelected:(BOOL)selected;
{
    NSLog(@"%@ _setSelected %d",self.job.name, selected);
    _isSelected = selected;
    _job.isSelected = selected;
    NSString *name = (_isSelected) ? @"MinusImage" : @"PlusImage";
    
//    [self _setImageWithName:name];
     self.indicatorImage.image = [UIImage imageNamed:name];
}

- (void)_jobDidChange:(NSNotification *)notification;
{
    Job *job = (Job *)notification.object;
    if (NO == [job isEqual:_job]) {
        [self _setSelected:NO];
    }

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
