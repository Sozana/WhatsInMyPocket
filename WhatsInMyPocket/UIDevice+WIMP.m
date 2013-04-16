//
//  UIDevice+WIMP.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 4/15/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "UIDevice+WIMP.h"

@implementation UIDevice (WIMP)

+ (UIDeviceResolution)resolution
{
    UIDeviceResolution resolution = UIDeviceResolutionUndefined;
    UIScreen *ms = [UIScreen mainScreen];
    CGFloat scale = ([ms respondsToSelector:@selector(scale)] ? ms.scale : 1.0f);
    CGFloat height = (CGRectGetHeight(ms.bounds) * scale);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if (scale == 2.0f) {
            if (height == 960.0f)
                resolution = UIDeviceResolutioniPhoneRetina4;
            else if (height == 1136.0f)
                resolution = UIDeviceResolutioniPhoneRetina5;
            
        } else if (scale == 1.0f && height == 480.0f)
            resolution = UIDeviceResolutioniPhoneStandard;
        
    } else {
        if (scale == 2.0f && height == 2048.0f) {
            resolution = UIDeviceResolutioniPadRetina;
            
        } else if (scale == 1.0f && height == 1024.0f) {
            resolution = UIDeviceResolutioniPadStandard;
        }
    }
    return resolution;
}


- (NSString *)sizeName;
{
    NSString *string = nil;
    switch ([UIDevice resolution]) {
        case UIDeviceResolutionUndefined:       string = @"Undefined";  break;
        case UIDeviceResolutioniPhoneStandard:  string = @"320x480";    break;
        case UIDeviceResolutioniPhoneRetina4:   string = @"640x960";    break;
        case UIDeviceResolutioniPhoneRetina5:   string = @"640x1136";   break;
        case UIDeviceResolutioniPadStandard:    string = @"1024x768";   break;
        case UIDeviceResolutioniPadRetina:  string = @"2048x1536";      break;
        default:    string = @"Undefined";  break;
    }
    return string;
}

@end
