//
//  SplashViewController.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 4/1/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "SplashViewController.h"
#import "DataManager.h"
#import "UIDevice+WIMP.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)init
{
    NSString *nibName = [self _nibName];
    
    self = [super initWithNibName:nibName bundle:nil];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (NSString *)_nibName;
{
    
    NSString *nibName = nil;
    UIDeviceResolution res = [UIDevice resolution];
    if (res == UIDeviceResolutioniPhoneRetina5) {
        nibName = [NSString stringWithFormat:@"%@_4Inch", NSStringFromClass([self class])];
    }else{
        nibName = [NSString stringWithFormat:@"%@_3-5Inch", NSStringFromClass([self class])];
    }
    return nibName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)showNameFieldIfNeeded;
{
    DataManager *dm = [DataManager sharedManager];
    if (nil == [dm username]) {
        [self _showEntryView];
    }else{
        [self start:nil];
    }
    
}

- (void)_showEntryView;
{
    [UIView animateWithDuration:.5
                     animations:^(void){
                         CGRect frm = _logoView.frame;
                         frm.origin.y += 50;
                         _logoView.frame = frm;
                     }completion:^(BOOL finished){
                         [UIView animateWithDuration:.3 animations:^(void){
                             _entryView.alpha = 1.0f;
                         }completion:nil];
                         
                     }];
    
    
}

- (IBAction)start:(UIButton *)sender;
{
    if (_nameField.text.length < 3) {
        _usernameLabel.font = [UIFont boldSystemFontOfSize:15];
        _usernameLabel.textColor = [UIColor redColor];
        _usernameLabel.text = @"Please enter your user name";
        return;
    }
    [_delegate splashViewControllerShouldBeRemoved:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
{
    BOOL change = YES;
    if (textField.text.length > 25) {
        change = NO;
    }
    return change;
}

@end
