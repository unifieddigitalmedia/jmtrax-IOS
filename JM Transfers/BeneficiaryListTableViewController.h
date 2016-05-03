//
//  BeneficiaryListTableViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface BeneficiaryListTableViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>


@property (nonatomic, strong) NSString *username;


@property (nonatomic, assign) int senderID;


@end
