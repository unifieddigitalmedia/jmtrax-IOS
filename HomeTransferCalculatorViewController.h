//
//  HomeTransferCalculatorViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface HomeTransferCalculatorViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>


{
    
    NSString* cgbpTEXT;
    
    NSString* cfeeTEXT;
    
    NSString* cngnTEXT;
    
    NSString* ctotalTEXT;
    
    
    
    
    
    
    
}


@property(nonatomic,retain) NSString* cgbpTEXT;

@property(nonatomic,retain) NSString* cfeeTEXT;

@property(nonatomic,retain) NSString* cngnTEXT;

@property(nonatomic,retain) NSString* ctotalTEXT;




- (void)doCalculation:(int)i withString:(NSString *)string ;
    
    
@end
