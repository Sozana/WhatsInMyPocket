//
//  JobSelectionTableCell.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/24/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobSelectionTableCell : UITableViewCell

@property (readonly) BOOL isSelected;

- (void)toggleSelected;
- (void)setIncluded:(BOOL)included;

@end
