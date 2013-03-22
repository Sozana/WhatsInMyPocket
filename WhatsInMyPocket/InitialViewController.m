//
//  InitialViewController.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/22/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController


- (id)initWithCoder:(NSCoder *)aDecoder
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"CalculateTableViewController"]
                            leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"JobsViewController"]
                           rightViewController:[storyboard instantiateViewControllerWithIdentifier:@"SelectionViewController"]];
    [self setLeftSize:150.0];
    [self setRightSize:150.0];
    
    if (self) {
        // Add any extra init code here
    }
    return self;
}

@end
