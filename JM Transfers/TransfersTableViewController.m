//
//  TransfersTableViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"
#import "HomePageViewController.h"
#import "TransfersTableViewController.h"
#import "URLRequests.h"
#import "KeychainItemWrapper.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"
#import "KeychainItemWrapper.h"
#import "DashboardViewController.h"
@interface TransfersTableViewController ()

@end

@implementation TransfersTableViewController

- (IBAction)logout:(id)sender {
    
    
    
    HomePageViewController *help = [self.storyboard instantiateViewControllerWithIdentifier:@"homecontroller"];
    
    [self.navigationController pushViewController:help animated:YES];
    
    
    
}

- (void)viewDidLoad {
   [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jmtrax"]];
 
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logout:)];
    
    [ self.navigationItem.titleView setUserInteractionEnabled:YES];
    
    [ self.navigationItem.titleView addGestureRecognizer:gestureRecognizer];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
 
    

    
    UIToolbar * HomePageToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.navigationController.navigationBar.frame.size.height )];
    
    
    UIColor *myColor = [UIColor colorWithRed:0.0f/255.0f green:127.0f/255.0f blue:18.0f/255.0f alpha:1.0f];
    
    HomePageToolbar.tintColor = [UIColor blackColor];
    
    HomePageToolbar.barTintColor = myColor;
    
    
    [self.view addSubview:HomePageToolbar];
    
    
    UIButton *HomePageCalButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width/3,self.navigationController.navigationBar.frame.size.height )];
    
    
    
    
    [HomePageCalButton setTitle:@"Send Money" forState:UIControlStateNormal];
    
    [HomePageCalButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
    
    HomePageCalButton.titleLabel.font = cellFont;
    
    [HomePageCalButton addTarget:self action:@selector(goToCalAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[HomePageCalButton layer] setBorderWidth:0.5f];
    [[HomePageCalButton layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [HomePageCalButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:HomePageCalButton];
    
    
    UIButton *HomePageAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageCalButton.frame.size.width,0,self.view.frame.size.width/3,self.navigationController.navigationBar.frame.size.height )];
    
    
    [HomePageAccountButton addTarget:self action:@selector(goToAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[HomePageAccountButton layer] setBorderWidth:0.5f];
    [[HomePageAccountButton layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [HomePageAccountButton setTitle:@"Account" forState:UIControlStateNormal];
    
    
    
    HomePageAccountButton.titleLabel.font = cellFont;
    
    
    
    [HomePageAccountButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:HomePageAccountButton];
    
    UIButton *HomePageHelpButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageAccountButton.frame.origin.x + HomePageAccountButton.frame.size.width,0,self.view.frame.size.width/3,self.navigationController.navigationBar.frame.size.height )];
    
    [HomePageHelpButton setTitle:@"Help" forState:UIControlStateNormal];
    
    
    
    HomePageHelpButton.titleLabel.font = cellFont;
    
    [[HomePageHelpButton layer] setBorderWidth:0.5f];
    
    [[HomePageHelpButton layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [HomePageHelpButton addTarget:self action:@selector(goToHelpAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [HomePageHelpButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:HomePageHelpButton];
    
    
    
    
    UITableView *SignUpTable;
    
    SignUpTable = [[UITableView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    //SignUpTable. .contentInset = UIEdgeInsetsMake(20,0,20, 0);
    
    
     SignUpTable.delegate = self;
    
    [SignUpTable registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"StaticCell"];
    
    SignUpTable.dataSource = self;
    
    SignUpTable.bounces = NO;
    
    SignUpTable.scrollEnabled = YES;
    
    SignUpTable.clipsToBounds = YES;
    
    SignUpTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    SignUpTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SignUpTable.allowsSelection = NO;
    
    SignUpTable.estimatedRowHeight = 44.0;
    
    SignUpTable.rowHeight = UITableViewAutomaticDimension;
    
    
    
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpTable.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
    
    SignUpTable.tableFooterView = footer;
    
    [self.view  addSubview:SignUpTable];
    
    
   
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)
        
    {
        
        
        return 5;
        
    }
    
    
    return 9;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    
   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if(indexPath.section == 1)
    {
        
       static NSString *cellIdentifier = @"StaticCell";
    
        
        CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        
        switch (indexPath.row)
        
        
        
        {
                
            case 0:
            {
                
               cell.textLabel.text = @"Fee Calculator";

                 cell.textLabel.textColor = [UIColor whiteColor];
              
                
              
                
                return cell;
                
                
                
            }
            case 1:
            {
                
                
                 cell.textLabel.text = @"Log in or register";
                
                cell.textLabel.textColor = [UIColor whiteColor];
                
                
              
                
                return cell;
                
                
                
            }
            case 2:
                
            {
                
                cell.textLabel.text = @"Website";
                cell.textLabel.textColor = [UIColor whiteColor];
                
                
              
                
                return cell;
                
                
                
                
            }
            case 3:
            {
                
                
                cell.textLabel.text = @"Terms and Conditions";
                cell.textLabel.textColor = [UIColor whiteColor];
                
                
              
                
                return cell;
                
                
                
                
            }
            case 4:
            {
                
                
                cell.textLabel.text = @"Contact Us";
                cell.textLabel.textColor = [UIColor whiteColor];
                
              
                
                return cell;
                
                
                
            }
                
                
                
                
        }
        
        
    }
    
    
    
    switch (indexPath.row) {
            
        case 0:
        {
            
            
            UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [tcalheading setText:@"Status"];
            
            [tcalheading setEditable:false];
            
            [tcalheading setTextAlignment:NSTextAlignmentLeft];
            
            UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
            
            [tcalheading setTextColor:myColor];
            
            tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
            
            [cell.contentView addSubview:tcalheading];
            
          
                
                return cell;
            
            break;
            
            
        }
        case 1:
            
        {
            
            UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                  cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = _transfer.recaccount;
            
            [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
            
            
            CGBPLABEL.text = _transfer.recbank;
            
            cell.accessoryView = CGBPLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
  
            
          
                
                return cell;
            
            
        }
        case 2:
            
        {
            UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                  cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Payment reference";
            
            [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
            
            
             CGBPLABEL.text = _transfer.recpayment;
            
            cell.accessoryView = CGBPLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
            
          
                
                return cell;
            
            
            
            
            
        }
        case 3:
            
        {
            UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                  cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Reason for transfer";
            
            [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
            
             CGBPLABEL.text = _transfer.recreason;
            
            cell.accessoryView = CGBPLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
            
            
          
                
                return cell;
            
            
        }
        case 4:
            
        {
            
            
            UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [tcalheading setText:@"Transfer Summary"];
            
            [tcalheading setEditable:false];
            
            [tcalheading setTextAlignment:NSTextAlignmentLeft];
            
            UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
            
            [tcalheading setTextColor:myColor];
            
            tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
            
            [cell.contentView addSubview:tcalheading];
            
            
          
                
                return cell;
            
            
            
        }
            
        case 5:
        {
            
            
            UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                  cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Amount we will send";
            
            [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
            
            
            CGBPLABEL.text = _transfer.GBP;
            
            cell.accessoryView = CGBPLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
            
          
                
                return cell;
            
            
            break;
            
            
        }
        case 6:
        {
            
            
            UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                  cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Transfer fee";
            
            [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
            
            CGBPLABEL.text = _transfer.FEE;
            cell.accessoryView = CGBPLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
            
          
                
                return cell;
            
            
            break;
            
            
        }
        case 7:
        {
            
            
            
            UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                  cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Total price";
            
            [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
            
            
                 CGBPLABEL.text = _transfer.TOTAL;
            
            
            cell.accessoryView = CGBPLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
            
          
                
                return cell;
            
            break;
            
            
        }
        case 8:
        {
            
            UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                  cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Amount paid to receiver";
            
                 CGBPLABEL.text = _transfer.NGN;
            
            [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
            
            cell.accessoryView = CGBPLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
            
            
            
          
                
                return cell;
            
            break;
            
            
        }
    
            
            
    }
    
  
                
                return cell;
    
}



- (IBAction)goToCalAction:(id)sender {
    
    
    
    
    // [self performSegueWithIdentifier:@"gotocal" sender:self];
    
    
    HomeTransferCalculatorViewController *calculator = [self.storyboard instantiateViewControllerWithIdentifier:@"hometransfercalculator"];
    
    [self.navigationController pushViewController:calculator animated:YES];
    
    
}
- (IBAction)goToHelpAction:(id)sender {
    
    
    HomeHelpViewController *help = [self.storyboard instantiateViewControllerWithIdentifier:@"homehelp"];
    
    [self.navigationController pushViewController:help animated:YES];
    
}

- (IBAction)goToAccountAction:(id)sender {
    
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"jmtransfers" accessGroup:nil];
    
    
    
    if([[keychainItem objectForKey:(id)kSecAttrCreator] length ] == 0 )
    {
        
        HomeAccountViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"homeaccount"];
        [self.navigationController pushViewController:account animated:YES];
        
        
    }
    else
    {
        
        DashboardViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
        [self.navigationController pushViewController:account animated:YES];
        
        
    }
    
}

@end
