//
//  SignUpViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 01/12/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface SignUpViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

{
   
     NSString* usernameTEXT;
    
     NSString* passwordTEXT;
    
     NSString* cpasswordTEXT;
    
     NSString* useremailTEXT;
    
     NSString* phoneTEXT;
    
     NSString* fnameTEXT;
    
     NSString* lnameTEXT;




}
@property(nonatomic,retain) NSString* usernameTEXT;

@property(nonatomic,retain) NSString* passwordTEXT;

@property(nonatomic,retain) NSString* cpasswordTEXT;

@property(nonatomic,retain) NSString* useremailTEXT;

@property(nonatomic,retain) NSString* phoneTEXT;

@property(nonatomic,retain) NSString* fnameTEXT;

@property(nonatomic,retain) NSString* lnameTEXT;




@end
