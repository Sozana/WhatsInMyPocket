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
    
    if (self = [super initWithCoder:aDecoder]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        self = [super initWithCenterViewController:[storyboard instantiateViewControllerWithIdentifier:@"CalculateTableViewController"]
                                leftViewController:[storyboard instantiateViewControllerWithIdentifier:@"OptionsViewController"]
                               rightViewController:[storyboard instantiateViewControllerWithIdentifier:@"JobsViewController"]];
        [self setLeftSize:115.0];
        [self setRightSize:115.0];
    }
    return self;
}

@end
