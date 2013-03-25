//
//  InitialViewController.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/22/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "InitialViewController.h"
#import "CalculateTableViewController.h"
#import "OptionsViewController.h"
#import "JobsViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController


- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super initWithCoder:aDecoder]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"CalculateTableViewController"]
                                leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"JobsViewController"]];
        [self setLeftSize:50.0];
//        [self setRightSize:115.0];
        
        CalculateTableViewController *cvc = (CalculateTableViewController *)[(UINavigationController *)self.centerController topViewController];
        
//        OptionsViewController *ovc = (OptionsViewController *)[(UINavigationController *)self.leftController topViewController];
        JobsViewController *jvc = (JobsViewController *)[(UINavigationController *)self.rightController topViewController];
//        NSLog(@"ovc %@", ovc);
//        ovc.delegate = cvc;
        jvc.delegate = cvc;
    }
    return self;
}

@end
