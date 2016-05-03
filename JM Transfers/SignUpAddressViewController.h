//
//  SignUpAddressViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 01/12/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface SignUpAddressViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    
    
    
   NSString *sender_ID;
    
  NSString *postcodeTEXT;
    
   NSString *townTEXT;
    
    NSString *firstlineTEXT;
    
    NSString *secondlineTEXT;
    
   NSString *countyTEXT;
    
}

@property (nonatomic, strong) NSString *sender_ID;

@property (nonatomic, strong) NSString *postcodeTEXT;

@property (nonatomic, strong) NSString *townTEXT;

@property (nonatomic, strong) NSString *firstlineTEXT;

@property (nonatomic, strong) NSString *secondlineTEXT;

@property (nonatomic, strong) NSString *countyTEXT;



@end
