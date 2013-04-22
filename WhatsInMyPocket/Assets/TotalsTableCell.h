//
//  TotalsTableCell.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 4/21/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Job.h"

@interface TotalsTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *totalsLabel;
@property (nonatomic, strong) Job *job;
- (void)calculateForLabelText;

@end
