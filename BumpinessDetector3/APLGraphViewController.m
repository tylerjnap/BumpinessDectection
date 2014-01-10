//
//  APLGraphViewController.m
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/9/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import "APLGraphViewController.h"
#import "APLAccelerometer.h"
#import "APLFFT.h"
#import <CoreMotion/CoreMotion.h>
#import <Accelerate/Accelerate.h>
#import "APLAppDelegate.h"


@interface APLGraphViewController ()

@property (strong, nonatomic) APLAccelerometer* accel;
//@property (strong, nonatomic) APLFFT* fft;

@end

@implementation APLGraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _accel = ((APLAppDelegate*)[UIApplication sharedApplication].delegate).accel;
    //_fft = ((APLAppDelegate*)[UIApplication sharedApplication].delegate).fft;
    NSArray *result = [APLFFT performFFT:_accel.accelerationArray];
    
    NSString *arraySize = [NSString stringWithFormat:@"%@", _accel.accelerationArray[0]];
   _graphLabel.text = arraySize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
