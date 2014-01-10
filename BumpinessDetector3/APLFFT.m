//
//  APLFFT.m
//  BumpinessDetector3
//
//  Created by Tyler Nappy on 1/7/14.
//  Copyright (c) 2014 Tyler Nappy. All rights reserved.
//

#import "APLFFT.h"
#import <Accelerate/Accelerate.h>

@interface APLFFT ()

//make for accelerate framework  @property (strong, nonatomic) CMMotionManager* manager;

@end


@implementation APLFFT

+(NSArray *)performFFT:(NSMutableArray*)array {
//    NSInteger log2n = 7; //7 --> 128 data points that this can handle (2^7 = 128)
//    FFTSetup setup;
//    vDSP_create_fftsetup(log2n, 0); //128 data points -- this can do
//    vDSP_fft_zrip(setup, small_set, 1, 7, FFT_FORWARD);
    
    NSUInteger c = array.count;
    
    float* farray = malloc(sizeof(float) * c);
    float* head = farray;
    
    for (NSNumber* n in array) {
        *farray = [n floatValue];
        farray++;
    }
    
    
    float *samples = head; // This is filled with samples, loaded from a file
    int numSamples = 256;  // The number of samples
    
    // Setup the length
    vDSP_Length log2n = log2f(numSamples);
    
    // Calculate the weights array. This is a one-off operation.
    FFTSetup fftSetup = vDSP_create_fftsetup(log2n, FFT_RADIX2);
    
    // For an FFT, numSamples must be a power of 2, i.e. is always even
    int nOver2 = numSamples/2;
    
    // Populate *window with the values for a hamming window function
    float *window = (float *)malloc(sizeof(float) * numSamples);
    vDSP_hamm_window(window, numSamples, 0);
    // Window the samples
    vDSP_vmul(samples, 1, window, 1, samples, 1, numSamples);
    
    // Define complex buffer
    COMPLEX_SPLIT A;
    A.realp = (float *) malloc(nOver2*sizeof(float));
    A.imagp = (float *) malloc(nOver2*sizeof(float));
    
    // Pack samples:
    // C(re) -> A[n], C(im) -> A[n+1]
    vDSP_ctoz((COMPLEX*)samples, 2, &A, 1, numSamples/2);
    
    //Perform a forward FFT using fftSetup and A
    //Results are returned in A
    vDSP_fft_zrip(fftSetup, &A, 1, log2n, FFT_FORWARD);
    
    //Convert COMPLEX_SPLIT A result to magnitudes
    
    NSMutableArray *results = [NSMutableArray array];
    
    //float amp[numSamples];
    
    float value = A.realp[0]/(numSamples*2);
    results[0] = isnan(value)?@(0):@(value);
    for(int i=1; i<numSamples; i++) {
        
        value = A.realp[i]*A.realp[i]+A.imagp[i]*A.imagp[i]; //removed the squaroot I put in
        results[i]=isnan(value)?@(0):@(value);
        //NSLog(@"%f index: %d ",amp[i], i);
    }
    
    
    return [NSArray arrayWithArray:results];
}


@end
