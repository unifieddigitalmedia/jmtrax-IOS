//
//  ConfirmTransferViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "Transfer.h"

@interface ConfirmTransferViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>



{
    
    NSString* gbpTEXT;
    
    NSString* feeTEXT;
    
    NSString* ngnTEXT;
    
    NSString* totalTEXT;
    
    
    
    
    
    
    
}

@property (nonatomic, strong) Transfer *transfer;

@property(nonatomic,retain) NSString* gbpTEXT;

@property(nonatomic,retain) NSString* feeTEXT;

@property(nonatomic,retain) NSString* ngnTEXT;

@property(nonatomic,retain) NSString* totalTEXT;




@end
