//
//  APLViewController.m
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/7/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import "APLViewController.h"
#import "BarGraphView.h"
#import "APLAccelerometer.h"
#import "APLFFT.h"
#import <CoreMotion/CoreMotion.h>
#import <Accelerate/Accelerate.h>
#import "APLAppDelegate.h"

static const NSTimeInterval accelerometerMin = 0.01;

@interface APLViewController ()

@property (strong, nonatomic) APLAccelerometer* accel;
//@property (strong, nonatomic) APLFFT* fft;
@property (assign, nonatomic) BOOL accelRunning;
@property (assign, nonatomic) BOOL FFTRunning;
@property (weak, nonatomic) IBOutlet BarGraphView *bars;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSArray* result;

@end

@implementation APLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _accel = ((APLAppDelegate*)[UIApplication sharedApplication].delegate).accel;
    //_fft = ((APLAppDelegate*)[UIApplication sharedApplication].delegate).fft;
    //_result = [APLFFT performFFT:_accel.accelerationArray];
    _accelRunning = NO;
    
    //sliders
    
    //begin collection button
    self.buttonBeginCollection = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonBeginCollection.frame = CGRectMake(50, 380, 200, 44);
    [self.buttonBeginCollection setTitle:@"Begin Taking Data" forState:UIControlStateNormal];
    [self.buttonBeginCollection addTarget:self action:@selector(beginCollectionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.buttonBeginCollection aboveSubview:self.bars];
    
    //empty array button
//    self.buttonEmptyArray = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    self.buttonEmptyArray.frame = CGRectMake(50, 400, 200, 44);
//    [self.buttonEmptyArray setTitle:@"Empty Array" forState:UIControlStateNormal];
//    [self.buttonEmptyArray addTarget:self action:@selector(beginEmptyArrayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view insertSubview:self.buttonEmptyArray aboveSubview:self.bars];

    //begin fft button
    self.buttonBeginFFT = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonBeginFFT.frame = CGRectMake(50, 420, 200, 44);
    [self.buttonBeginFFT setTitle:@"Perform FFT" forState:UIControlStateNormal];
    [self.buttonBeginFFT addTarget:self action:@selector(beginFFTButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonBeginFFT];
    [self.view insertSubview:self.buttonBeginFFT aboveSubview:self.bars];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)updateGraph
{
    
    //NSMutableArray *a = [NSMutableArray array];
    
//    for (int i=0;i<256;i++)
//    {
//        int randomInt = arc4random() % 1000;
//        [a addObject:@(randomInt)];
//    }
    
    self.bars.maxValue = 0; //scale y to fit...
    
    //drop the highest frequency...
    NSArray *filtered = [_result subarrayWithRange:NSMakeRange(2, _result.count-2)];
    
    self.bars.values = filtered;
    
    //Put some values in the text view...
    
    NSMutableString *str = self.textView.textStorage.mutableString;
    [str setString:@""];
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"floatValue" ascending:NO];
    NSArray *sorted = [filtered sortedArrayUsingDescriptors:@[sd]];
    for (int i=0; i<5; i++)
    {
        NSInteger idx = [filtered indexOfObject:sorted[i]];
        [str appendFormat:@"%02ld: %.3f\n",(long)idx,[sorted[i] floatValue]];
    }
    
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
        self.result = [APLFFT performFFT:_accel.accelerationArray];
        
        NSLog(@"Result MAX: %@", [self.result valueForKeyPath:@"@max.floatValue"]);
        
        NSString *arraySize = [NSString stringWithFormat:@"%lu and performed FFT", (unsigned long)[_accel.accelerationArray count]];
        _statusIndicator.text = arraySize;
        [self updateGraph];
    }
}

- (void) seeGraphButtonPressed:(UIButton *) sender
{
    if ([sender isEqual:self.buttonSeeGraph]) {
        //change views to see the graph
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
