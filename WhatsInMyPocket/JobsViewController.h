//
//  JobsViewController.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/22/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JobsViewControllerDelegate;

@interface JobsViewController : UITableViewController

@property (nonatomic, weak) IBOutlet id <JobsViewControllerDelegate>delegate;


@end



@protocol JobsViewControllerDelegate <NSObject>


- (void)bababoi;

@end