//
//  DataManager.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "DataManager.h"
#import "Constants.h"
#import "NSUserDefaults+WIMP.h"
#import "Option.h"
#import "Job.h"

@interface DataManager ()
{
    NSArray *_allOptions;
    NSArray *_allJobs;
}

@end

NSString *const kDataKey_Username = @"Username";
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
        [self _loadData];
        if ([_allJobs count]) {
            self.currentJob = [_allJobs objectAtIndex:0];
        }
        
        NSLog(@"%@", _currentJob);
    }
    return self;
}

- (void)setUsername:(NSString *)username;
{
    [NSUserDefaults saveObjects:@[username] withKeys:@[kDataKey_Username]];
}

- (NSString *)username;
{
    return [NSUserDefaults objectForKey:kDataKey_Username];
}

- (NSArray *)_options;
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:OptionTypeCount];
    for (int i=0; i<OptionTypeCount; i++) {
        Option *o = [Option optionWithType:i];
        [arr insertObject:o atIndex:i];
    }
    return arr;
}

- (NSArray *)_jobs;
{
    NSArray *dummyJobs = @[@"Apple", @"CBS", @"Ikea"];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[dummyJobs count]];
    for (NSString *name in dummyJobs) {
        Job *job = [[Job alloc] initWithName:name];
        job.options = [self _options];
        [arr addObject:job];
    }
    return arr;
}

- (NSDictionary *)whatsInMyPocket;
{
    CGFloat result = 0.0f;
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *incomplete = [NSMutableArray array];
    BOOL isIncomplete = NO;
    for (Job *j in _allJobs) {
        
        if (j.includeInCalculation) {
            if (NO == [j hasRequiredEntries]) {
                [incomplete addObject:j.name];
                isIncomplete = YES;
                continue;
            }
            NSNumber *num = [j calculate];
            NSDictionary *currentResult = @{@"Result" : num, @"JobName" : j.name};
            [arr addObject:currentResult];
            result += [num floatValue];
        }
    }
    if (isIncomplete) {
        [self _alertForIncompleteJobEntriesInJobs:incomplete];
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    NSDictionary *dict = @{@"Results" : arr,
                           @"Total" : [NSNumber numberWithFloat:result],
                           @"Date" : dateString,};
    return dict;
}

- (void)_alertForIncompleteJobEntriesInJobs:(NSArray *)jobs;
{
    NSString *str = [jobs componentsJoinedByString:@", "];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete Jobs"
                                                    message:[NSString stringWithFormat:@"Required values missing for: %@", str]
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (Job *)addJobNamed:(NSString *)name;
{
    for (Job *job in _allJobs){
        if ([job.name isEqualToString:name]) {
            return nil;
        }
    }
    Job *job = [[Job alloc] initWithName:name];
    job.options = [self _options];
    NSMutableArray *arr = (nil == _allJobs) ? [NSMutableArray array] : [_allJobs mutableCopy];
    [arr addObject:job];
    _allJobs = arr;
    NSDictionary *change = @{kNotificationKey_JobAdded : job};
    [[NSNotificationCenter defaultCenter] postNotificationName:kJobsUpdatedNotification object:change];
    [self save];    
    return job;
}

- (void)deleteJob:(Job *)job;
{    
    NSMutableArray *arr = [_allJobs mutableCopy];
    [arr removeObjectIdenticalTo:job];
    _allJobs = arr;
    NSDictionary *change = @{kNotificationKey_JobDeleted : job};
    [[NSNotificationCenter defaultCenter] postNotificationName:kJobsUpdatedNotification object:change];
    [self save];
}

- (NSArray *)options;
{

    return _allOptions;
}

- (NSArray *)jobs;
{
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
}

- (void)_saveData;
{
    if (nil == _allJobs || nil == _allOptions) {
        return;
    }
    NSDictionary *data = @{kDataKey_Jobs : _allJobs, kDataKey_Options : _allOptions};
    [NSKeyedArchiver archiveRootObject:data toFile:[self _dataFilePath]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerDidSaveNotification object:nil];
}

@end
