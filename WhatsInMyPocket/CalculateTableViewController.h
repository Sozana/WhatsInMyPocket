//
//  CalculateTableViewController.h
//  WhatsInMyPocket
//
//  Created by sawsan altammar on 2/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashViewController.h"
#import "OptionsViewController.h"
#import "JobsViewController.h"

@interface CalculateTableViewController : UITableViewController <SplashViewControllerDelegate, UITextFieldDelegate, JobsViewControllerDelegate, OptionsViewControllerDelegate>

@property (nonatomic, weak) IBOutlet OptionsViewController *optionsViewController;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;
@property (nonatomic, weak) IBOutlet UIView *noJobsView;

- (IBAction)whatsInMyPocket:(UIButton *)sender;
- (IBAction)showJobs:(id)sender;

@end
