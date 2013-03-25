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
