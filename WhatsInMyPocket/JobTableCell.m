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

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.0f];
    

    CGRect frm = self.contentView.frame;
    for (UIView *subview in self.subviews) {
        NSString *className = NSStringFromClass([subview class]);
        if ([className isEqualToString:@"UITableViewCellDeleteConfirmationControl"]) {
            CGRect newFrame = subview.frame;
            newFrame.origin.x = frm.size.width - 60;
            subview.frame = newFrame;
        }else if ([className isEqualToString:@"UITableViewCellEditControl"]) {
            CGRect newFrame = subview.frame;
            newFrame.origin.x = 100;
            subview.frame = newFrame;
        }else if ([className isEqualToString:@"UITableViewCellReorderControl"]) {
            CGRect newFrame = subview.frame;
            newFrame.origin.x = 200;
            subview.frame = newFrame;
        }
    }
    [UIView commitAnimations];
}

- (void)setJob:(Job *)job;
{
    _job = job;
    _label.text = _job.name;
}

- (void)toggleSelected;
{
    [self _setSelected:(_isSelected) ? NO : YES];
}

- (void)setIsSelected:(BOOL)selected;
{
    NSLog(@"%@ _setSelected %d %d",self.job.name, self.job.isSelected, selected);
    
    NSString *name = (selected) ? @"MinusImage" : @"PlusImage";
    self.indicatorImage.image = [UIImage imageNamed:name];
}

- (void)_setSelected:(BOOL)selected;
{
    NSLog(@"%@ _setSelected %d",self.job.name, selected);
    _isSelected = selected;
   // _job.isSelected = selected;
    NSString *name = (_isSelected) ? @"MinusImage" : @"PlusImage";
    
//    [self _setImageWithName:name];
     self.indicatorImage.image = [UIImage imageNamed:name];
}


- (void)_setImageWithName:(NSString *)name;
{
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
