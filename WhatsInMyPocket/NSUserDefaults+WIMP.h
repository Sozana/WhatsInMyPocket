//
//  NSUserDefaults+WIMP.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 4/15/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (WIMP)

+ (void)saveObjects:(NSArray *)objects withKeys:(NSArray *)keys;
+ (void)saveBool:(BOOL)bol forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;

@end
