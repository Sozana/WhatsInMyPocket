//
//  InputTableCell.h
//  WhatsInMyPocket
//
//  Created by sawsan altammar on 2/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Option;

@interface OptionInputCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UILabel *label;

- (void)setOption:(Option *)option;
@end
