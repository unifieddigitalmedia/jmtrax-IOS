//
//  HomeTransferCalculatorViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"


#import "HomePageViewController.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"
#import "KeychainItemWrapper.h"
#import "URLRequests.h"
#import "DashboardViewController.h"
@interface HomeTransferCalculatorViewController ()

@end

@implementation HomeTransferCalculatorViewController

UIToolbar *TransferPageToolbar;

UIButton *TransferPageCalButton;

UIButton *TransferPageAccountButton;

UIButton *TransferPageHelpButton ;

UITextField *GBP;

UITextField *FEE;

UITextField *NGN;

UITextField *TOTAL;

NSString *fullurl;

UIScrollView *calscroll;


UITextView *AMOUNTPAIDLABEL;
UITextView *AMOUNTLABEL;
UITextView *TOTALLABEL;
UITextView *FEELABEL;
UITextView *GBPLABEL;
                                                           

@synthesize cgbpTEXT;

@synthesize cfeeTEXT;

@synthesize cngnTEXT;

@synthesize ctotalTEXT;

                                                           

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
    
    SignUpTable.contentInset = UIEdgeInsetsMake(20,0,20, 0);
    
    
    SignUpTable.delegate = self;
    
    SignUpTable.backgroundColor = [UIColor clearColor];

    
    [SignUpTable registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"StaticCell"];
    
    SignUpTable.dataSource = self;
    
    SignUpTable.bounces = NO;
   
    SignUpTable.scrollEnabled = YES;
    
    SignUpTable.clipsToBounds = YES;
    
    SignUpTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
   
    SignUpTable.separatorStyle = UITableViewCellSeparatorStyleNone;
  

    
    [self.view  addSubview:SignUpTable];


    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpTable.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
    
    SignUpTable.tableFooterView = footer;
    
    
     //[self.view  addSubview:footer];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)gotosignup:(id)sender {
    
    
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




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)

    {
        
        
         return 5;
        
    }
    
    return 12;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
        
   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    cell.backgroundColor = [UIColor clearColor];
    
        if(indexPath.section == 0)
            
            
        {
            
            
            
            
            [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

            
            
            switch (indexPath.row) {
                    
                case 0:
                {
                    
                    cell.textLabel.text = @"TRANSFER CALCULATOR";
                    
                
                  
                
                return cell;
                    
                    break;
                    
                    
                }
                case 1:
                    
                    
                {
                    
                    
                    cell.textLabel.text = @"Enter an amount and press enter";
                    
                    
                  
                
                return cell;
                    
                    break;
                    

                    
                }
                case 2:
                    
                {
                    
                    GBP = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                    
                    [GBP setPlaceholder:@"GBP £"];
                    
                    GBP.delegate = self;
                    
                    GBP.text = cgbpTEXT;
                    
                    GBP.tag = indexPath.row;
                    
                    [GBP setBorderStyle:UITextBorderStyleRoundedRect];
                    
                    
                    [GBP setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
     
                    
                    
                    [cell.contentView addSubview:GBP];
                    
                    
                  
                
                return cell;
                    
                    
                }
                case 3:
                    
                {
                    
                    FEE = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                    
                    [FEE setPlaceholder:@"FEE £"];
                    
                    FEE.delegate = self;
                    
                     FEE.text = cfeeTEXT;
                    
                    [FEE setBorderStyle:UITextBorderStyleRoundedRect];
                    
                    [FEE setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    

                    [cell.contentView addSubview:FEE];
                    
                    
                  
                
                return cell;
                    
                    
                    
                    
                    
                }
                case 4:
                    
                {
                    
                    NGN = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                    
                    [NGN setPlaceholder:@"NGN £"];
                    
                    NGN.delegate = self;
                    
                    [NGN setBorderStyle:UITextBorderStyleRoundedRect];
                    
                    NGN.tag = indexPath.row;
                    
                     NGN.text = cngnTEXT;
                    
                    [NGN setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    
                    
                    [cell.contentView addSubview:NGN];
                    
                    
                  
                
                return cell;
                    
                    
                }
                case 5:
                    
                {
                    
                    TOTAL = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                    
                    [TOTAL setPlaceholder:@"TOTAL DUE £"];
                    
                    TOTAL.delegate = self;
                    
                    TOTAL.tag = indexPath.row;
                    
                    TOTAL.text = ctotalTEXT;
                    
                    [TOTAL setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    
                    
                    
                    [TOTAL setBorderStyle:UITextBorderStyleRoundedRect];
                    
                    [cell.contentView addSubview:TOTAL];
                    
                    
                  
                
                return cell;
                    
                    
                    
                }
                    
                case 6:
                {
                    
                    
                    UITextView *cell2 = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                    
                    [cell2 setText:@"TRANSFER SUMMARY"];
                    
                    [cell2 setEditable:false];
                    
                    [cell2 setTextAlignment:NSTextAlignmentLeft];
                    
                    [cell2 setTextColor:[UIColor blackColor]];
                    
                    cell2.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
                    
                    [cell.contentView addSubview:cell2];
                    
                  
                
                return cell;
                    
                    break;
                    
                    
                }
                case 7:
                {
                    
                   
                    GBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                          cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                    
                    cell.textLabel.text = @"Amont we will send";
                    
                    [GBPLABEL setTextAlignment:NSTextAlignmentRight];
                    
                    cell.accessoryView = GBPLABEL;
                    
                    GBPLABEL.text = cgbpTEXT ;
                    
                    [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                    
                    
                  
                
                return cell;
                    
                    break;
                    
                    
                }
                case 8:
                {
                    
                     FEELABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                 0, 0, 100,cell.frame.size.height)];
                    
                    cell.textLabel.text = @"Transfer fee";
                    
                    [FEELABEL setTextAlignment:NSTextAlignmentRight];
                
                     FEELABEL.text = cfeeTEXT ;
                    
                    cell.accessoryView = FEELABEL;
                    
                    [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                    
                    
 
                    
                    
                  
                
                return cell;
                    
                    break;
                    
                    
                }
                case 9:
                {
                    
                    
                    
                    TOTALLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                          cell.textLabel.frame.size.width, 0,100,cell.frame.size.height)];
                    
                    cell.textLabel.text = @"Total price";
                    
                    [TOTALLABEL setTextAlignment:NSTextAlignmentRight];
                    
                    TOTALLABEL.text = ctotalTEXT ;

                    
                    cell.accessoryView = TOTALLABEL;
                    
                    [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                    

                    
                    
                  
                
                return cell;
                    
                    break;
                    
                    
                }
               
                case 10:
                {
                    
                    
                 
                    
                    AMOUNTPAIDLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                               cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                    
                    [AMOUNTPAIDLABEL setTextAlignment:NSTextAlignmentRight];
                    
                    cell.textLabel.text = @"Amont paid to receiver";
                    
                     AMOUNTPAIDLABEL.text = cngnTEXT ;
                    
                    cell.accessoryView = AMOUNTPAIDLABEL;
                    
                    [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                    
                    
                    
                    
                    
                    
                  
                
                return cell;
                    
                    break;
                    
                    
                }
                case 11:
                {
                    
                    
                    UIButton *cell8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    
                    cell8.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
                    
                    [cell8 setTitle:@"GET STARTED" forState:UIControlStateNormal];
                    
                    [cell8 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
                    
                    [cell8 setBackgroundColor:myColor];
                    
                    [cell8 addTarget:self action:@selector(gotosignup:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [cell8 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                    
                    [cell.contentView addSubview:cell8];
                    
                    
                  
                
                return cell;
                    
                    break;
                    
                    
                }
                    
                    
            }
            
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



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self doCalculation:textField.tag withString:textField.text ];

    [textField resignFirstResponder];
    
    return YES;
    
}


- (void)doCalculation:(int)i withString:(NSString *)string {
    
    
    if (i == 2) {
        
        
        fullurl = [NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/gbp.php?amount=%@",string];
        
        
    }
    
    else if (i == 4){
        
        fullurl = [NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/ngn.php?amount=%@",string];
        
        
        
    }
    
    else if(i == 5)
        
        
    {
        
        fullurl = [NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/gbpdue.php?amount=%@",string];
        
        
        
    }
    
    
    fullurl = [fullurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
 
    
    NSArray *validation = [[URLRequests alloc] makeurlrequest:fullurl];
    

    
    GBP.text = [validation[0] objectForKey:@"GBP"];
    
    cgbpTEXT = [validation[0] objectForKey:@"GBP"];

    FEE.text = [validation[0] objectForKey:@"COMM"];
    
    cfeeTEXT = [validation[0] objectForKey:@"COMM"];
    
    NGN.text = [validation[0] objectForKey:@"NGN"];
    
    cngnTEXT = [validation[0] objectForKey:@"NGN"];
    
    TOTAL.text = [validation[0] objectForKey:@"DUE"];
    
    ctotalTEXT = [validation[0] objectForKey:@"DUE"];
    
    AMOUNTPAIDLABEL.text = [validation[0] objectForKey:@"NGN"];
    
    TOTALLABEL.text = [validation[0] objectForKey:@"DUE"];
    
    FEELABEL.text = [validation[0] objectForKey:@"COMM"];
    
    GBPLABEL.text = [validation[0] objectForKey:@"GBP"];
    
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
            
            sectionName = @" ";
            
            break;
            
    }
    return sectionName;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if(indexPath.section == 1)
        
    {
        
        if (indexPath.row == 0 ) {
            
            
            
            
            HomeTransferCalculatorViewController *calculator = [self.storyboard instantiateViewControllerWithIdentifier:@"hometransfercalculator"];
            
            [self.navigationController pushViewController:calculator animated:YES];
            
            
            
        } else if(indexPath.row == 1) {
            
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

@end
