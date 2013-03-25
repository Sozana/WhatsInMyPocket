//
//  OptionTableCell.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/22/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Option.h"

@interface OptionTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *checkMark;
@property (strong, nonatomic, readonly) Option *option;

- (void)toggleSelected;
- (void)setOption:(Option *)option;

@end
