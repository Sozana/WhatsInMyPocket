//
//  Job.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Job : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, strong) NSArray *options;
@property (readonly) BOOL isSelected;
@property BOOL includeInCalculation;

- (void)toggleSelected;

- (id)initWithName:(NSString *)name;
- (void)setName:(NSString *)name;
- (NSNumber *)calculate;
- (BOOL)hasRequiredEntries;

@end
