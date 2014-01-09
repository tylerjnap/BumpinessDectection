//
//  APLAccelerometer.h
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/7/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APLAccelerometer : NSObject

@property (assign, nonatomic) BOOL enabled;
@property (strong, nonatomic) NSMutableArray* accelerationArray;

- (void) start;
- (void) stop;
- (void) emptyArray;


@end
