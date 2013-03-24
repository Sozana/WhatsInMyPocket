//
//  DataManager.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Job;

@interface DataManager : NSObject

+ (DataManager *)sharedManager;
- (NSArray *)options;
- (NSArray *)jobs;
- (Job *)currentJob;

@end
