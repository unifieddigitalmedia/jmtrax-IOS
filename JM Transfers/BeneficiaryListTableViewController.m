//
//  BeneficiaryListTableViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "BeneficiaryListTableViewController.h"
#import "HomePageViewController.h"
#import "BeneficiaryDetailsViewController.h"
#import "Transfer.h"

#import "URLRequests.h"
#import "KeychainItemWrapper.h"
#import "DashboardViewController.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"

@interface BeneficiaryListTableViewController ()

@end

@implementation BeneficiaryListTableViewController

NSArray *validation ;
Transfer *transfer;
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
    
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    UIBarButtonItem * playall = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(bdetails:) ];
    
    
    NSArray *actionButtonItems = @[playall];
    
    self.navigationItem.rightBarButtonItems = actionButtonItems;

 
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
    
    
    [self.view  addSubview:SignUpTable];
    
    
    
    [SignUpTable reloadData];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpTable.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
    
    SignUpTable.tableFooterView = footer;

    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"jmtransfers" accessGroup:nil];
    
    
    
    
    
   validation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/blist.php?username=%@",[keychainItem objectForKey:(id)kSecAttrCreator]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];


    transfer = [[Transfer alloc] init];

 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)
        
    {
        
        
        return 5;
        
    }
    
    return [validation[0] count];


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
  
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
   
    if(indexPath.section == 0)
        
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        cell.textLabel.text =  [NSString stringWithFormat:@"%@ %@",[validation[0][indexPath.row] objectForKey:@"RecipientsFirstName"],[validation[0][indexPath.row] objectForKey:@"RecipientsLastName"]];
        
        
         cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",[validation[0][indexPath.row] objectForKey:@"Bank"],[validation[0][indexPath.row] objectForKey:@"NigeriaBankAccount"]];
        
    }
    else if(indexPath.section == 1)
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
    

    
  
                
                return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
        
    {
        
        
        
        transfer.recreason = [validation[0][indexPath.row] objectForKey:@"ReasonForTransfer"];
        transfer.recpayment = [validation[0][indexPath.row] objectForKey:@"PaymentRef"];
        transfer.recaccount = [validation[0][indexPath.row] objectForKey:@"NigeriaBankAccount"];
        transfer.recbank = [validation[0][indexPath.row] objectForKey:@"Bank"];
        transfer.recphone = [validation[0][indexPath.row] objectForKey:@"RecipientsPhone"];
        transfer.reclastname = [validation[0][indexPath.row] objectForKey:@"RecipientsLastName"];
        transfer.recfirstname = [validation[0][indexPath.row] objectForKey:@"RecipientsFirstName"];
        transfer.recID = [[validation[0][indexPath.row] objectForKey:@"recipient_ID"] intValue];
        transfer.ShopAcc = [validation[0][indexPath.row] objectForKey:@"ShopAcc"];
        transfer.senderID =[[validation[0][indexPath.row] objectForKey:@"senders_ID"] intValue];
        
        
        
        BeneficiaryDetailsViewController *dash = [self.storyboard instantiateViewControllerWithIdentifier:@"bdetails"];
        
         [dash setTransfer:transfer];
        
        
        
        [self.navigationController pushViewController:dash animated:YES];
        
        
    }
    else
        
    {
        
        
        if(indexPath.section == 1)
            
        {
            
            if (indexPath.row == 0 ) {
                
                
                
                
                HomeTransferCalculatorViewController *calculator = [self.storyboard instantiateViewControllerWithIdentifier:@"hometransfercalculator"];
                
                [self.navigationController pushViewController:calculator animated:YES];
                
                
                
            } else if(indexPath.row == 1) {
                
                
                
                HomeAccountViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"homeaccount"];
                [self.navigationController pushViewController:account animated:YES];
                
                
            }
            else if (indexPath.row == 2) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.jmtrax.net/"]];
            }
            else if (indexPath.row == 3) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.jmtrax.com/money-laundering-statement/"]];
                
            }
            else if(indexPath.row == 4) {
                
                
                HomeHelpViewController *help = [self.storyboard instantiateViewControllerWithIdentifier:@"homehelp"];
                
                [self.navigationController pushViewController:help animated:YES];
                
                
            }
            
        }
        
    }
    
    

    
    
}

- (IBAction)bdetails:(id)sender {
    
    
    
    BeneficiaryDetailsViewController *dash = [self.storyboard instantiateViewControllerWithIdentifier:@"bdetails"];
    

    [dash setSenders_ID:[[validation[0][0] objectForKey:@"senders_ID"] intValue]];
    
    [self.navigationController pushViewController:dash animated:YES];
    
    
}




- (IBAction)goToCalAction:(id)sender {
    
    
    
    
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
         case 1:
            
            sectionName = @" ";
            
            break;





        case 0:
            
            sectionName = @"Select a beneficiary or add a new by selecting + top right";
            
            
            break;
            
    }
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 30;
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
 
    
    return 50;
    
}

@end
