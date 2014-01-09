//
//  APLAccelerometer.m
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/7/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import "APLAccelerometer.h"
#import <CoreMotion/CoreMotion.h>

@interface APLAccelerometer ()

@property (strong, nonatomic) CMMotionManager* manager;
@property (strong, nonatomic) NSOperationQueue* queue;
@property (strong, nonatomic) NSNotificationCenter* notifications;
@property (strong, nonatomic) NSUserDefaults* defaults;

@end

@implementation APLAccelerometer

- (id)init {
    _manager = [[CMMotionManager alloc] init];
    _queue = [[NSOperationQueue alloc] init];
    
    float interval = 0.1; //Can change this to see what works best
    
    _manager.accelerometerUpdateInterval = interval;
    
    _enabled = YES;//[_defaults boolForKey:kSPLSimUserDefault_Accelerometer_State];
    
    _accelerationArray = [[NSMutableArray alloc] init];

    return self;
}

- (void)start {

    float interval = 0.1;//will figure out how to assign from "init"
    _manager.accelerometerUpdateInterval = interval;

    NSLog(@"Accelerometer: Enabled and Started");
    [_manager startAccelerometerUpdatesToQueue:_queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        // TODO: drop in a High Pass filter here
        //put stuff here like add to array
        //NSUInteger data = accelerometerData.acceleration.z;
        [self putAccelerationsIntoArray:accelerometerData.acceleration];
        //[_bluetooth updateAccelData:[NSData dataWithBytes:&data length:sizeof(NSUInteger)]];
    }];
}

- (void)putAccelerationsIntoArray:(CMAcceleration)acceleration
{
    //if (_accelerationArray.count > 0 && _accelerationArray.count != 1024) {
      //  NSLog(@"Data is already collected, empty to start again");
    //} else {
//        while (_accelerationArray.count<1024) {
            NSNumber* num = [NSNumber numberWithDouble:acceleration.z];
            [_accelerationArray addObject:num];
            NSLog(@"Accel Data: %0.2f [%d]", acceleration.z, _accelerationArray.count);
//        }
    //}
    if (_accelerationArray.count>=256) {
        [self stop];
    }
}

- (void)emptyArray{
    [_accelerationArray removeAllObjects];
}

- (void)stop {
    NSLog(@"Accelerometer: Stopped");
    [_manager stopAccelerometerUpdates];
}


@end