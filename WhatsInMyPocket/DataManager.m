//
//  DataManager.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "DataManager.h"
#import "Option.h"
#import "Job.h"

@interface DataManager ()
{
    NSArray *_allOptions;
    NSArray *_allJobs;
}

@end
@implementation DataManager

+ (DataManager *)sharedManager;
{
    static DataManager *sharedInstance = nil;
    static dispatch_once_t pred;
    
    if(sharedInstance){
    	return sharedInstance;
    }
    
    dispatch_once(&pred, ^{
        sharedInstance = [DataManager alloc];
        sharedInstance = [sharedInstance init];
    });
    
    return sharedInstance;
}

- (id)init;
{
    if (self = [super init]) {
        [self _loadOptions];
        [self _loadJobs];
        if ([_allJobs count]) {
            self.currentJob = [_allJobs objectAtIndex:0];
        }
        
        NSLog(@"%@", _currentJob);
    }
    return self;
}

- (void)_loadOptions;
{
   NSArray *opts = @[
                         //                         @"Job Name",
                         //              @"Date",
                         @"Monthly Base",
                         @"Number of Months",
                         @"Hours",
                         @"Hoerly Rate",
                         @"Total Wholesale",
                         @"Percentage",
                         @"Yearly Salary",
                         @"After Tax",
                         @"Before Tax",
                         @"Tax Return"];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[opts count]];
    for (NSString *s in opts) {
        Option *o = [[Option alloc] initWithName:s];
        [arr addObject:o];
    }
    NSLog(@"%@", arr);
    _allOptions = arr;
}

- (void)_loadJobs;
{
    NSArray *dummyJobs = @[@"Apple", @"CBS", @"Ikea"];
    //NSArray *dummyJobs = @[];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[dummyJobs count]];
    for (NSString *name in dummyJobs) {
        Job *job = [[Job alloc] initWithName:name];
        job.options = _allOptions;
        [arr addObject:job];
    }
    _allJobs = arr;
}

//- (Job *)currentJob;
//{
//    Job *job = [[Job alloc] init];
//    job.options = [self options];
//    job.name = @"Default Job";
//    return job;
//}

- (NSArray *)options;
{
    NSLog(@"%@", _allOptions);
    
    return _allOptions;
}

- (NSArray *)jobs;
{
    // name
    // options
    
    return _allJobs;
}
@end
