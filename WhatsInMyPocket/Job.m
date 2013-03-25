//
//  Job.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "Job.h"
#import "Option.h"

@implementation Job

- (id)initWithName:(NSString *)name;
{
    if (self = [super init]) {
        [self setName:name];
    }
    return self;
}

- (void)setName:(NSString *)name;
{
    _name = name;
    _ID = [NSString stringWithFormat:@"%lu", (unsigned long)[_name hash]];
}

- (void)addOption:(Option *)option;
{
    
}

- (void)reimoveOption:(Option *)option;
{
    
}

- (NSString *)description;
{
    return [NSString stringWithFormat:@"%@ - %@",_name, _options];
}

@end
