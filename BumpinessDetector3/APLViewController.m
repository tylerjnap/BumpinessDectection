//
//  APLViewController.m
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/7/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import "APLViewController.h"
#import "APLAccelerometer.h"
#import "APLFFT.h"
#import <CoreMotion/CoreMotion.h>
#import <Accelerate/Accelerate.h>

@interface APLViewController ()

@property (strong, nonatomic) APLAccelerometer* accel;
@property (strong, nonatomic) APLFFT* fft;
@property (assign, nonatomic) BOOL accelRunning;
@property (assign, nonatomic) BOOL FFTRunning;

@end

@implementation APLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _accel = [[APLAccelerometer alloc] init];
    _fft = [[APLFFT alloc] init];
    _accelRunning = NO;
    
    //begin collection button
    self.buttonBeginCollection = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonBeginCollection.frame = CGRectMake(50, 200, 200, 44);
    [self.buttonBeginCollection setTitle:@"Begin Taking Data" forState:UIControlStateNormal];
    [self.buttonBeginCollection addTarget:self action:@selector(beginCollectionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonBeginCollection];
    
    //empty array button
    self.buttonEmptyArray = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonEmptyArray.frame = CGRectMake(50, 300, 200, 44);
    [self.buttonEmptyArray setTitle:@"Empty Array" forState:UIControlStateNormal];
    [self.buttonEmptyArray addTarget:self action:@selector(beginEmptyArrayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonEmptyArray];
    
    //begin fft button
    self.buttonBeginFFT = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonBeginFFT.frame = CGRectMake(50, 400, 200, 44);
    [self.buttonBeginFFT setTitle:@"Perform FFT" forState:UIControlStateNormal];
    [self.buttonBeginFFT addTarget:self action:@selector(beginFFTButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonBeginFFT];

}


- (void) beginCollectionButtonPressed:(UIButton *) sender
{
    if ([sender isEqual:self.buttonBeginCollection]) {
        if (!_accelRunning) {
            //begin collection
            [_accel start];
            _accelRunning = YES;
            [self.buttonBeginCollection setTitle:@"Stop" forState:UIControlStateNormal];
            _statusIndicator.text = @"Collecting...";
        } else {
            [_accel stop];
            _accelRunning = NO;
            [self.buttonBeginCollection setTitle:@"Begin Taking Data" forState:UIControlStateNormal];
            //NSUInteger *arraySize = [_accel.accelerationArray count];
            NSString *arraySize = [NSString stringWithFormat:@"%d", [_accel.accelerationArray count]];
            _statusIndicator.text = arraySize;
        }
    }
}

- (void) beginEmptyArrayButtonPressed:(UIButton *)sender
{
    if ([sender isEqual:self.buttonEmptyArray]){
        if ([_accel.accelerationArray count]<1)
            _statusIndicator.text = @"Array is already empty";
        else {
            [_accel emptyArray];
            _statusIndicator.text = @"Array successfully emptied";
        }
    }
    
}

- (void) beginFFTButtonPressed:(UIButton *) sender
{
    if ([sender isEqual:self.buttonBeginFFT]) {
        //begin FFT
        [_fft performFFT:_accel.accelerationArray];
        NSString *arraySize = [NSString stringWithFormat:@"%d and performed FFT", [_accel.accelerationArray count]];
        _statusIndicator.text = arraySize;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
