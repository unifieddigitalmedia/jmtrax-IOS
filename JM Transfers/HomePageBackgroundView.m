//
//  HomePageBackgroundView.m
//  JM Transfers
//
//  Created by Machel Slack on 05/12/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "HomePageBackgroundView.h"

@implementation HomePageBackgroundView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setNeedsDisplay];
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    
    size_t gradLocationsNum = 2;
    
    CGFloat gradLocations[2] = {0.0f, 1.0f};
    
  
    //CGFloat gradColors[8] = {86.0f/ 255.0f,70.0f/ 255.0f,13.0f/ 255.0f,0.0f/ 255.0f,0.0f/ 255.0f,0.0f/ 255.0f,0.0f/ 255.0f,0.5f/ 255.0f};
   
    CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.5f};
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    
    CGColorSpaceRelease(colorSpace);
    
    CGPoint gradCenter= CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    float gradRadius = MIN(self.bounds.size.width , self.bounds.size.height) ;
    
    CGContextDrawRadialGradient (ctx, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
    
    
    CGGradientRelease(gradient);
    
    
    }

@end
