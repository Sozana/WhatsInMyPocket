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

- (BOOL)hasRequiredEntries;
{
    BOOL hasEntries = YES;
    for (Option *o in _options) {
        NSLog(@"%@ %@", o.name, o.value);
        
        if (o.type < OptionTypeCount && nil == o.value) {
            hasEntries = NO;
            break;
        }
    }
    return hasEntries;
}
/*
 
 OptionTypeMonthlyBase,
 OptionTypeNumberOfMonths,
 
 
 OptionTypeHours,
 OptionTypeHourlyRate,
 

 OptionTypeYearlySalary,
 
 
 OptionTypeTotalWholeSale,
 OptionTypePercentage,
 
 OptionTypeAfterTax,
 OptionTypeBeforeTax,
 OptionTypeTaxReturn,
 
 */


- (NSNumber *)calculate;
{
    NSNumber *result = @0;
    // either monthly or hourly????
    CGFloat totalMonthly = [self _totalMonthly];
    CGFloat totalHourly = [self _totalHourly];
    
    
    NSString *totalWholeSale = [(Option *)[_options objectAtIndex:OptionTypeTotalWholeSale] value];
    NSString *percentage = [(Option *)[_options objectAtIndex:OptionTypePercentage] value];
    
    NSString *yearSalary = [(Option *)[_options objectAtIndex:OptionTypeYearlySalary] value];
    NSString *afterTax = [(Option *)[_options objectAtIndex:OptionTypeAfterTax] value];
    NSString *beforeTax = [(Option *)[_options objectAtIndex:OptionTypeBeforeTax] value];
    NSString *taxReturn = [(Option *)[_options objectAtIndex:OptionTypeTaxReturn] value];
    
    return [NSNumber numberWithFloat:totalMonthly];
}

- (CGFloat)_totalMonthly;
{
    NSString *monthlyBase = [(Option *)[_options objectAtIndex:OptionTypeMonthlyBase] value];
    NSString *noOfMonths = [(Option *)[_options objectAtIndex:OptionTypeNumberOfMonths] value];
    CGFloat totalMonthly = [monthlyBase floatValue] * [noOfMonths floatValue];
    return totalMonthly;
}

- (CGFloat)_totalHourly;
{
    NSString *hours = [(Option *)[_options objectAtIndex:OptionTypeHours] value];
    NSString *hourRate = [(Option *)[_options objectAtIndex:OptionTypeHourlyRate] value];
    CGFloat totalHourly = [hours floatValue] * [hourRate floatValue];
    return totalHourly;
}

- (NSString *)description;
{
    
    return [NSString stringWithFormat:@"(%@) %@",[super description], _name];
}

@end
