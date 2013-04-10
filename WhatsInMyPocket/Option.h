//
//  Option.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Option : NSObject  <NSCoding>

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *value;

- (id)initWithName:(NSString *)name;
- (void)setName:(NSString *)name;

@end
