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

@interface APLViewController : UIViewController

- (IBAction)beginCollectionButtonPressed:(id)sender;
@property (weak, nonatomic) UIButton *buttonBeginCollection;

- (IBAction)beginFFTButtonPressed:(id)sender;
@property (weak, nonatomic) UIButton *buttonBeginFFT;

- (IBAction)beginEmptyArrayButtonPressed:(id)sender;
@property (weak, nonatomic) UIButton *buttonEmptyArray;

//- (void) beginFFT:(UIButton *) sender;
//- (void) beginCollection:(UIButton *) sender;

@property (strong, nonatomic) IBOutlet UILabel *acceleration;

@property (strong, nonatomic) IBOutlet UILabel *statusIndicator;


@end
