//
//  EditViewController.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 5/7/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameField;

- (IBAction)done:(UIBarButtonItem *)sender;

@end
