//
//  EditViewController.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 5/7/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "EditViewController.h"
#import "DataManager.h"
#import "UIDevice+WIMP.h"
@interface EditViewController ()

@end

@implementation EditViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameField.text = [[DataManager sharedManager] username];
	// Do any additional setup after loading the view.
}

- (IBAction)done:(UIBarButtonItem *)sender;
{
    NSString *username = [self _username];
    if (nil == username) {
        return;
    }
    [[DataManager sharedManager] setUsername:_nameField.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSString *)_username;
{
    NSString *username = nil;
    if (_nameField.text.length < 2) {
        _usernameLabel.font = [UIFont boldSystemFontOfSize:15];
        _usernameLabel.textColor = [UIColor redColor];
        _usernameLabel.text = @"Please enter your name";
        
    }else{
        username = _nameField.text;
    }
    return username;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL isOk = NO;
    if ([self _username]) {
        isOk = YES;
        [textField resignFirstResponder];
        [self done:nil];
    }
    return isOk;
}
@end
