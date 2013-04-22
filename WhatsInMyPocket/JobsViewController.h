//
//  JobsViewController.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/22/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JobsViewControllerDelegate;

@interface JobsViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet id <JobsViewControllerDelegate>delegate;
@property (nonatomic, weak) IBOutlet UIView *noJobsView;
- (IBAction)addJob:(UIBarButtonItem *)sender;

@end



@protocol JobsViewControllerDelegate <NSObject>



@end