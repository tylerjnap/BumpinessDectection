//
//  APLGraphViewController.h
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/9/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APLAccelerometer.h"
#import "APLFFT.h"


@interface APLGraphViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *graphLabel;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end
