//
//  TransfersTableViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "Transfer.h"

@interface TransfersTableViewController :  UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) Transfer *transfer;



@end
