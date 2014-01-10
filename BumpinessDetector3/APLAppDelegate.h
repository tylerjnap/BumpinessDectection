//
//  APLAppDelegate.h
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/7/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APLAccelerometer;
@class APLFFT;

@interface APLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) APLAccelerometer* accel;
//@property (strong, nonatomic) APLFFT* fft;

@end
