//
//  Option.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    OptionTypeMonthlyBase,
    OptionTypeNumberOfMonths,
    OptionTypeHours,
    OptionTypeHourlyRate,
    OptionTypeTotalWholeSale,
    OptionTypePercentage,
    OptionTypeYearlySalary,
    OptionTypeNumberOfYears,
    //OptionTypeAfterTax,
    //OptionTypeBeforeTax,
    OptionTypeTaxReturn,
    OptionTypeExpenses,
    OptionTypeAdditionalIncome,
    
    OptionTypeCount,
    
} OptionType;

@interface Option : NSObject  <NSCoding>

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, readonly) NSString *value;
@property OptionType type;
@property (nonatomic, strong) NSString *validationSelectorString;
@property (nonatomic, strong) UIColor *color;

+ (Option *)optionWithType:(OptionType)type;
- (id)initWithName:(NSString *)name;
- (void)setName:(NSString *)name;
- (BOOL)setValueWithString:(NSString *)string;

@end
