//
//  UIButton+ToolbarCategory.m
//  JM Transfers
//
//  Created by Machel Slack on 05/12/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "UIButton+ToolbarCategory.h"

@implementation UIButton (ToolbarCategory)




-(void) centerButtonAndImageWithSpacing:(CGFloat)spacing {
    
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);



}

@end
