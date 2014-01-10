//
//  APLViewController.h
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/7/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APLAccelerometer.h"
#import "APLFFT.h"
#import "BarGraphView.h"

@interface APLViewController : UIViewController


- (IBAction)beginCollectionButtonPressed:(id)sender;
@property (weak, nonatomic) UIButton *buttonBeginCollection;

- (IBAction)beginFFTButtonPressed:(id)sender;
@property (weak, nonatomic) UIButton *buttonBeginFFT;

- (IBAction)beginEmptyArrayButtonPressed:(id)sender;
@property (weak, nonatomic) UIButton *buttonEmptyArray;

- (IBAction)seeGraphButtonPressed:(id)sender;
@property (weak, nonatomic) UIButton *buttonSeeGraph;

//- (void) beginFFT:(UIButton *) sender;
//- (void) beginCollection:(UIButton *) sender;

@property (strong, nonatomic) IBOutlet UILabel *acceleration;

@property (strong, nonatomic) IBOutlet UILabel *statusIndicator;

@property (weak, nonatomic) IBOutlet UILabel *accelUpdateRate;
@property (weak, nonatomic) IBOutlet UISlider *sliderAccelUpdateRate;

@property (weak, nonatomic) IBOutlet UILabel *sampleSize;
@property (weak, nonatomic) IBOutlet UIPickerView *sampleSizeSelector;


@end
