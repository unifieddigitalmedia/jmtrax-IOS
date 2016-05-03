//
//  HomePageViewController.h
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"


@interface HomePageViewController :  UIViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *calulatorbtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *accountbtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *helpbtn;
- (IBAction)goToCalAction:(id)sender;
- (IBAction)goToHelpAction:(id)sender;
- (IBAction)goToAccountAction:(id)sender;

@end
