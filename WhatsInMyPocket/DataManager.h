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

@property (nonatomic, strong) Job *currentJob;

+ (DataManager *)sharedManager;
- (void)setUsername:(NSString *)username;
- (NSString *)username;
- (void)save;
- (NSArray *)options;
- (NSArray *)jobs;
- (Job *)currentJob;
- (Job *)addJobNamed:(NSString *)name;
- (void)deleteJob:(Job *)job;
- (NSDictionary *)whatsInMyPocket;

@end
