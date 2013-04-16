//
//  UIDevice+WIMP.h
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 4/15/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    UIDeviceResolutionUndefined,            // Undefined
    UIDeviceResolutioniPhoneStandard,       // 320x480px
    UIDeviceResolutioniPhoneRetina4,        // 640x960px
    UIDeviceResolutioniPhoneRetina5,        // 640x1136px
    UIDeviceResolutioniPadStandard,         // 1024x768px
    UIDeviceResolutioniPadRetina,           // 2048x1536px
} UIDeviceResolution;

@interface UIDevice (WIMP)

+ (UIDeviceResolution)resolution;
+ (NSString *)sizeName;

@end

