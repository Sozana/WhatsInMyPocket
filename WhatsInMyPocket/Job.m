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

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        _ID = [decoder decodeObjectForKey:@"ID"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.options = [decoder decodeObjectForKey:@"options"];
        _isSelected = [decoder decodeBoolForKey:@"isSelected"];
        _includeInCalculation = [decoder decodeBoolForKey:@"includeInCalculation"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_ID forKey:@"ID"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_options forKey:@"options"];
    [encoder encodeBool:_isSelected forKey:@"isSelected"];
    [encoder encodeBool:_includeInCalculation forKey:@"includeInCalculation"];
}

- (void)toggleSelected;
{
    _isSelected = !_isSelected;
}

- (void)setName:(NSString *)name;
{
    _name = name;
    _ID = [NSString stringWithFormat:@"%lu", (unsigned long)[_name hash]];
}



- (NSNumber *)calculate;
{
    NSNumber *result = @0;
    
    return result;
}

- (NSString *)description;
{
    
    return [NSString stringWithFormat:@"(%@) %@",[super description], _name];
}

@end
