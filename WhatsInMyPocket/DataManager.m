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

NSString *const kDataKey_Jobs = @"Jobs";
NSString *const kDataKey_Options = @"Options";


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
//        [self _loadOptions];
//        [self _loadJobs];
        [self _loadData];
        if ([_allJobs count]) {
            self.currentJob = [_allJobs objectAtIndex:0];
        }
        
        NSLog(@"%@", _currentJob);
    }
    return self;
}

- (NSArray *)_options;
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
//    NSLog(@"%@", arr);
    return arr;
}

- (NSArray *)_jobs;
{
    NSArray *dummyJobs = @[@"Apple", @"CBS", @"Ikea"];
    //NSArray *dummyJobs = @[];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[dummyJobs count]];
    for (NSString *name in dummyJobs) {
        Job *job = [[Job alloc] initWithName:name];
        job.options = _allOptions;
        [arr addObject:job];
    }
    return arr;
}

//- (Job *)currentJob;
//{
//    Job *job = [[Job alloc] init];
//    job.options = [self options];
//    job.name = @"Default Job";
//    return job;
//}
- (Job *)addJobNamed:(NSString *)name;
{
    for (Job *job in _allJobs){
        if ([job.name isEqualToString:name]) {
            return nil;
        }
    }
    Job *job = [[Job alloc] initWithName:name];
    job.options = [self options];
    NSMutableArray *arr = (nil == _allJobs) ? [NSMutableArray array] : [_allJobs mutableCopy];
    [arr addObject:job];
    _allJobs = arr;
    NSLog(@"%@", _allJobs);
    
    [self save];
    return job;
}

- (void)deleteJob:(Job *)job;
{
    NSMutableArray *arr = [_allJobs mutableCopy];
    [arr removeObjectIdenticalTo:job];
    _allJobs = arr;
    [self save];
}

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

- (void)save;
{
    [self _saveData];
}

- (NSString *)_dataFilePath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"data.txt"];
    return filePath;
}

- (void)_loadData;
{
    NSDictionary *data = [NSKeyedUnarchiver unarchiveObjectWithFile:[self _dataFilePath]];
    if (nil == data) {
        _allOptions = [self _options];
    }else{
        _allJobs = [data objectForKey:kDataKey_Jobs];
        _allOptions = [data objectForKey:kDataKey_Options];
    }
    NSLog(@"data %@", data);
}

- (void)_saveData;
{
    if (nil == _allJobs || nil == _allOptions) {
        return;
    }
    NSDictionary *data = @{kDataKey_Jobs : _allJobs, kDataKey_Options : _allOptions};
    NSLog(@"data %@", data);
    [NSKeyedArchiver archiveRootObject:data toFile:[self _dataFilePath]];
}

@end
