//
//  SelectionViewController.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/22/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OptionsViewControllerDelegate;

@interface OptionsViewController : UITableViewController

@property (nonatomic, weak) IBOutlet id <OptionsViewControllerDelegate>delegate;
@end


@protocol OptionsViewControllerDelegate <NSObject>



@end