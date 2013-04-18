//
//  Option.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "Option.h"

@interface Option ()
{
    SEL _validatingSelector;
}

@end
@implementation Option


/*
 NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
 
 if ([aString rangeOfCharacterFromSet:set].location != NSNotFound) {
 NSLog(@"This string contains illegal characters");
 }
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
 */

+ (Option *)optionWithType:(OptionType)type;
{
    NSString *name = nil;
    NSString *selector = nil;
    switch (type) {
        case OptionTypeMonthlyBase:
            name = @"Monthly Base";
            selector = @"MonthlyBase";
            break;
        case OptionTypeNumberOfMonths:
            name = @"Number of Months";
            selector = @"NumberOfMonths";
            break;
        case OptionTypeHours:
            name = @"Hours";
            selector = @"Hours";
            break;
        case OptionTypeHourlyRate:
            name = @"Hourly Rate";
            selector = @"HourlyRate";
            break;
        case OptionTypeTotalWholeSale:
            name = @"Total Wholesale";
            selector = @"TotalWholesale";
            break;
        case OptionTypePercentage:
            name = @"Percentage";
            selector = @"Percentage";
            
            break;
        case OptionTypeYearlySalary:
            name = @"Yearly Salary";
            selector = @"YearlySalary";
            break;
        case OptionTypeAfterTax:
            name = @"After Tax";
            selector = @"AfterTax";
            break;
        case OptionTypeBeforeTax:
            name = @"Before Tax";
            selector = @"BeforeTax";
            break;
        case OptionTypeTaxReturn:
            name = @"Tax Return";
            selector = @"TaxReturn";
            break;
            
        default:
            break;
    }
    Option *option = [[Option alloc] initWithName:name];
    option.type = type;
    option.name = name;
    option.validationSelectorString = [NSString stringWithFormat:@"_validate%@WithString:", selector];
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
        _type = (OptionType)[decoder decodeIntegerForKey:@"type"];
        _validationSelectorString = [decoder decodeObjectForKey:@"validationSelectorString"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder;
{
    [encoder encodeObject:_ID forKey:@"ID"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_value forKey:@"value"];
    [encoder encodeInteger:_type forKey:@"type"];
    [encoder encodeObject:_validationSelectorString forKey:@"validationSelectorString"];

}

- (BOOL)setValueWithString:(NSString *)string;
{
    NSLog(@"_validationSelectorString %@", _validationSelectorString);
    BOOL isValid = YES;
    SEL selector = NSSelectorFromString(_validationSelectorString);
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        isValid = (BOOL)[self performSelector:selector withObject:string];
#pragma clang diagnostic pop
    }
    if (isValid) {
        _value = string;
    }
    
    return isValid;
}

- (void)setName:(NSString *)name;
{
    _name = name;
    _ID = [NSString stringWithFormat:@"%lu", (unsigned long)[_name hash]];
}


#pragma mark - Private Validating methods

- (BOOL)_validateMonthlyBaseWithString:(NSString *)string
{
    return YES;
}

- (BOOL)_validateNumberOfMonthsWithString:(NSString *)string
{
    return [self _validateNumericString:string withMinVaue:0 maxValue:12];
}

- (BOOL)_validateHoursWithString:(NSString *)string
{
    return [self _validateNumericString:string withMinVaue:0 maxValue:24];
}

- (BOOL)_validateHourlyRateWithString:(NSString *)string
{
    return [self _validateNumericString:string withMinVaue:0 maxValue:5000];
}

- (BOOL)_validatePercentageWithString:(NSString *)string
{
    return [self _validateNumericString:string withMinVaue:0 maxValue:100];
}

#pragma mark - Helpers

- (BOOL)_validateNumericString:(NSString *)string withMinVaue:(NSInteger)min maxValue:(NSInteger)max;
{
    BOOL isValid = NO;
    NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([string rangeOfCharacterFromSet:set].location == NSNotFound){
        NSInteger val = [string integerValue];
        isValid = (val > max || val < min) ? NO : YES;
    }
    return isValid;
}

- (NSString *)description;
{
    return _name;
}
@end
