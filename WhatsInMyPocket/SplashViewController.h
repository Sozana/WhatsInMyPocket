//
//  SplashViewController.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 4/1/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SplashViewControllerDelegate;

@interface SplashViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id<SplashViewControllerDelegate>delegate;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UIImageView *titleImage;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *logoImage;
@property (nonatomic, weak) IBOutlet UIView *entryView;
@property (nonatomic, weak) IBOutlet UIView *logoView;
@property (nonatomic, weak) IBOutlet UITextField *nameField;

- (IBAction)start:(UIButton *)sender;
- (void)showNameFieldIfNeeded;

@end



@protocol SplashViewControllerDelegate <NSObject>

- (void)splashViewControllerShouldBeRemoved:(SplashViewController *)vc;

@end