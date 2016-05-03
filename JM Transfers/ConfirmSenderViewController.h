//
//  ConfirmSenderViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "Transfer.h"

@interface ConfirmSenderViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

{
    
 
    NSString* sendererrorText;
    
    
    
    
}

@property(nonatomic,retain) NSString* sendererrorText;



@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) Transfer *transfer;

@end
