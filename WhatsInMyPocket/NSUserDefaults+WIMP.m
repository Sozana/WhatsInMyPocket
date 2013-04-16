//
//  NSUserDefaults+WIMP.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 4/15/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "NSUserDefaults+WIMP.h"

@implementation NSUserDefaults (WIMP)

+ (void)saveObjects:(NSArray *)objects withKeys:(NSArray *)keys;
{
    NSInteger oCnt = [objects count];
    NSInteger kCnt = [keys count];
    if (oCnt != kCnt) {
        NSLog(@"Unequal number of objects for keys");
        return;
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    for (int i=0; i<oCnt; i++){
        id obj = [objects objectAtIndex:i];
        NSString *key = [keys objectAtIndex:i];
        if (key != nil && obj != nil) {
            [ud setObject:obj forKey:key];
        }
    }
    [ud synchronize];
}

+ (void)saveBool:(BOOL)bol forKey:(NSString *)key;
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:bol forKey:key];
    [ud synchronize];
}

+ (id)objectForKey:(NSString *)key;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (BOOL)boolForKey:(NSString *)key;
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


@end
