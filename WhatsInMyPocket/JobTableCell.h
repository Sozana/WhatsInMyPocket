//
//  JobTableCell.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"
#import "Constants.h"

@interface JobTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorImage;
@property (strong, nonatomic, readonly) Job *job;

- (void)toggleSelected;
- (void)setJob:(Job *)job;
- (void)setIsSelected:(BOOL)selected;

@end
