//
//  Option.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "Option.h"

@implementation Option

- (id)initWithName:(NSString *)name;
{
    if (self = [super init]) {
        [self setName:name];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder;
{
    if (self = [super init]) {
        _ID = [decoder decodeObjectForKey:@"ID"];
        _name = [decoder decodeObjectForKey:@"value"];
        _value = [decoder decodeObjectForKey:@"value"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder;
{
    [encoder encodeObject:_ID forKey:@"ID"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_value forKey:@"value"];
}



- (void)setName:(NSString *)name;
{
    _name = name;
    _ID = [NSString stringWithFormat:@"%lu", (unsigned long)[_name hash]];
}

- (NSString *)description;
{
    return _name;
}
@end
