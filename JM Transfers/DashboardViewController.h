//
//  DashboardViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface DashboardViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarbutton;



@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *identification;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *limit;

@end
