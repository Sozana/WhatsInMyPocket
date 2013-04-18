//
//  Option.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "Option.h"

@implementation Option


+ (Option *)optionWithType:(OptionType)type;
{
    NSString *name = nil;
    switch (type) {
        case OptionTypeMonthlyBase:
            name = @"Monthly Base";
            break;
        case OptionTypeNumberOfMonths:
            name = @"Number of Months";
            break;
        case OptionTypeHours:
            name = @"Hours";
            break;
        case OptionTypeHoerlyRate:
            name = @"Hoerly Rate";
            break;
        case OptionTypeTotalWholeSale:
            name = @"Total Wholesale";
            break;
        case OptionTypePercentage:
            name = @"Percentage";
            break;
        case OptionTypeYearlySalary:
            name = @"Yearly Salary";
            break;
        case OptionTypeAfterTax:
            name = @"After Tax";
            break;
        case OptionTypeBeforeTax:
            name = @"Before Tax";
            break;
        case OptionTypeTaxReturn:
            name = @"Tax Return";
            break;
            
        default:
            break;
    }
    Option *option = [[Option alloc] initWithName:name];
    option.type = type;
    option.name = name;
    return option;
}

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
        _name = [decoder decodeObjectForKey:@"name"];
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


- (BOOL)setValueWithString:(NSString *)string;
{
    BOOL isOk = YES;
    
    return isOk;
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
