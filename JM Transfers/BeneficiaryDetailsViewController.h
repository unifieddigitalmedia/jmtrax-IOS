//
//  BeneficiaryDetailsViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "Transfer.h"

@interface BeneficiaryDetailsViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

{
    
    NSString* recfirstnameTEXT;
    
    NSString* reclastnameTEXT;
    
    NSString* recphoneTEXT;
    
    NSString* recbankTEXT;
    
    NSString* recaccountTEXT;
    
    NSString* recpaymentrefTEXT;
    
    NSString* recpayeebankTEXT;
    
    NSString* recreasonfortransferTEXT;
    
    NSString* recerrorTEXT;
    
    
    
    
}

@property(nonatomic,retain) NSString* recfirstnameTEXT;

@property(nonatomic,retain) NSString* reclastnameTEXT;

@property(nonatomic,retain) NSString* recphoneTEXT;

@property(nonatomic,retain) NSString* recbankTEXT;

@property(nonatomic,retain) NSString* recaccountTEXT;

@property(nonatomic,retain) NSString* recpaymentrefTEXT;

@property(nonatomic,retain) NSString* recpayeebankTEXT;

@property(nonatomic,retain) NSString* recreasonfortransferTEXT;

@property(nonatomic,retain) NSString* recerrorTEXT;

@property(nonatomic,assign) int senders_ID;


@property (nonatomic, strong) Transfer *transfer;

@end
