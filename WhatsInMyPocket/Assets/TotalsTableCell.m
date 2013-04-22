//
//  TotalsTableCell.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 4/21/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "TotalsTableCell.h"
#import "Constants.h"

@implementation TotalsTableCell

- (void)awakeFromNib
{
    self.contentView.backgroundColor = [UIColor orangeColor];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_dataManagerDidSave:)
                                                 name:kDataManagerDidSaveNotification
                                               object:nil];
    [self calculateForLabelText];
}

- (void)_dataManagerDidSave:(NSNotification *)notification;
{
    [self calculateForLabelText];
}

- (void)calculateForLabelText;
{
    NSLog(@"_job %@", [_job calculate]);
    
    _totalsLabel.text = [NSString stringWithFormat:@"Total: $%@", [_job calculate]];
}

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
