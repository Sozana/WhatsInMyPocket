//
//  InputTableCell.m
//  WhatsInMyPocket
//
//  Created by sawsan altammar on 2/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "OptionInputCell.h"
#import "DataManager.h"
#import "Option.h"

@interface OptionInputCell ()
{
    Option *_option;
}

@end
@implementation OptionInputCell

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
    self.contentView.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
}

- (void)setOption:(Option *)option;
{
    _option = option;
    _label.text = option.name;
    _inputField.text = option.value;
    self.contentView.backgroundColor = option.color;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    NSString *txt = (range.length == 1) ? [textField.text substringToIndex:[textField.text length] - 1] : textField.text;
    string = [NSString stringWithFormat:@"%@%@", txt, string];
    
    BOOL val = [_option setValueWithString:string];
    
    if (val) {
        [[DataManager sharedManager] save];
    }
    
    return val;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [textField resignFirstResponder];
    return YES;
}

@end
