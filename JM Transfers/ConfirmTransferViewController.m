//
//  ConfirmTransferViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"
#import "HomePageViewController.h"
#import "ConfirmTransferViewController.h"
#import "DashboardViewController.h"
#import "SelectPayTableViewController.h"
#import "URLRequests.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"
#import "KeychainItemWrapper.h"
@interface ConfirmTransferViewController ()

@end

@implementation ConfirmTransferViewController

UITextView *error;
UISwitch *uksms;
UISwitch *ngnsms;
UISwitch *compliance;
UITextField *cgbp;
UITextField *cfee;
UITextField *cngn;
UITextField *ctotal;

UITextView *CAMOUNTPAIDLABEL;
UITextView *CAMOUNTLABEL;
UITextView *CTOTALLABEL;
UITextView *CFEELABEL;
UITextView *CGBPLABEL;

NSString *Cfullurl;


@synthesize gbpTEXT;

@synthesize feeTEXT;

@synthesize ngnTEXT;

@synthesize totalTEXT;





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
    
    
    [self.view  addSubview:SignUpTable];
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpTable.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
    
    SignUpTable.tableFooterView = footer;

    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)
        
    {
        
        
        return 5;
        
    }
    
    return 15;
    
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
            
            [tcalheading setText:@"TRANSFER CALCULATOR"];
            
            [tcalheading setEditable:false];
            
            [tcalheading setTextAlignment:NSTextAlignmentCenter];
            
             UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
   
            [tcalheading setTextColor:myColor];
            
            tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
            
            [cell.contentView addSubview:tcalheading];
            
          
                
                return cell;
            
            break;
            
            
        }
        case 1:
            
        {
            
            cgbp = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [cgbp setPlaceholder:@"GBP £"];
            
            cgbp.tag = indexPath.row ;
            
            cgbp.delegate = self;
            
            cgbp.text = gbpTEXT ;
            
            [cgbp setBorderStyle:UITextBorderStyleRoundedRect];
            
            [cgbp setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
            
            [cell.contentView addSubview:cgbp];
            
            
          
                
                return cell;
            
            break;
        }
        case 2:
            
        {
            
            cfee = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [cfee setPlaceholder:@"FEE £"];
            
            [cfee setBorderStyle:UITextBorderStyleRoundedRect];
            
            cfee.text = feeTEXT ;
            
            cfee.delegate = self;
            
            [cfee setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
            [cell.contentView addSubview:cfee];
            
            
          
                
                return cell;
            
            
            break;
            
            
        }
        case 3:
            
        {
            
            cngn = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [cngn setPlaceholder:@"NGN £"];
            
            cngn.tag = indexPath.row  ;
            
            cngn.text = ngnTEXT;
            
            [cngn setBorderStyle:UITextBorderStyleRoundedRect];
            
            cngn.delegate = self;
            
            [cngn setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
           
            
            [cell.contentView addSubview:cngn];
            
            
          
                
                return cell;
            break;
            
        }
        case 4:
            
        {
            
             ctotal = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [ctotal setPlaceholder:@"TOTAL DUE £"];
            
             ctotal.tag = indexPath.row ;
            
            ctotal.text = totalTEXT;
            
            [ctotal setBorderStyle:UITextBorderStyleRoundedRect];
            
            ctotal.delegate = self;
            
            [ctotal setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
           
            
            [cell.contentView addSubview:ctotal];
            
            
          
                
                return cell;
            break;
            
            
        }
            
        case 5:
        {
            
            
            UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [tcalheading setText:@"TRANSFER SUMMARY"];
            
            [tcalheading setEditable:false];
            
            [tcalheading setTextAlignment:NSTextAlignmentLeft];
            
             UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
   
            [tcalheading setTextColor:myColor];
            
            tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
            
            [cell.contentView addSubview:tcalheading];
            
          
                
                return cell;
            
            break;
            
            
        }
        case 6:
        {
            
            
            CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                    cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Amount we will send";
            
            [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
            
            CGBPLABEL.text = gbpTEXT ;
            
            cell.accessoryView = CGBPLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
          
                
                return cell;
            
            break;
            
            
        }
        case 7:
        {
            
            CFEELABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                    0, 0, 100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Transfer fee";
            
            [CFEELABEL setTextAlignment:NSTextAlignmentRight];
            
            CFEELABEL.text = feeTEXT ;
            
            
            cell.accessoryView = CFEELABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
            
            
            
          
                
                return cell;
            
            break;
            
            
        }
        case 8:
        {
            
            
            
            CTOTALLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                      cell.textLabel.frame.size.width, 0,100,cell.frame.size.height)];
            
            cell.textLabel.text = @"Total price";
            
            [CTOTALLABEL setTextAlignment:NSTextAlignmentRight];
            
             CTOTALLABEL.text = totalTEXT ;
            
            
            cell.accessoryView = CTOTALLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            
            
            
            
          
                
                return cell;
            
            break;
            
            
        }
            
        case 9:
        {
            
            
            
            
            CAMOUNTPAIDLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                           cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
            
            [CAMOUNTPAIDLABEL setTextAlignment:NSTextAlignmentRight];
            
            CAMOUNTPAIDLABEL.text = ngnTEXT ;
            
            cell.textLabel.text = @"Amount paid to receiver";
            
            
            cell.accessoryView = CAMOUNTPAIDLABEL;
            
            [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
            

          
                
                return cell;
            
            break;
            
            
        }
               case 10:
        {
            
            error = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width,cell.frame.size.height)];
            
            
            [error setTextAlignment:NSTextAlignmentCenter];
            
            [error setTextColor:[UIColor redColor]];
            
            [cell.contentView addSubview:error];
            
          
                return  cell;
            
                break;
        
        

            
        }
        case 11:
        {
          
            
            cell.textLabel.text =  @"Receive sms confirmation";
            
            
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
            
            cell.textLabel.font = cellFont;
            
            uksms = [[UISwitch alloc] initWithFrame:CGRectMake(
                                                                    0, 0, 30, 30)];
            
            
            cell.textLabel.numberOfLines = 0;
            
            cell.accessoryView = uksms;
            
            [cell.accessoryView setFrame:CGRectMake(0, 0, 30, 30)];
            return  cell;
            
            break;
        }
        case 12:
        {
          
            
            cell.textLabel.text =  @"Send confirmation to recipients";
            
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
            
            cell.textLabel.numberOfLines = 0;
            
            cell.textLabel.font = cellFont;
            
            ngnsms = [[UISwitch alloc] initWithFrame:CGRectMake(
                                                                    0, 0, 30, 30)];
            
            
            
            cell.accessoryView = ngnsms;
            
            [cell.accessoryView setFrame:CGRectMake(0, 0, 30, 30)];
            
            return  cell;
            
            break;
            
        }
        case 13:
        {
          
            
            
            cell.textLabel.text =  @"I agree with the Money Laundering Statement";
            
            cell.textLabel.numberOfLines = 0;
            
            UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
            
            cell.textLabel.font = cellFont;
            
            compliance = [[UISwitch alloc] initWithFrame:CGRectMake(
                                                                    0, 0, 30, 30)];
            
            
            
            cell.accessoryView = compliance;
            
            [cell.accessoryView setFrame:CGRectMake(0, 0, 30, 30)];
            return  cell;
            
            break;
        }
            
        case 14:
        {
          
            UIButton *tcalheading = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            tcalheading.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
            
            [tcalheading setTitle:@"GET STARTED" forState:UIControlStateNormal];
            
            [tcalheading setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
             UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
            
            [tcalheading setBackgroundColor:myColor];
            
            [tcalheading addTarget:self action:@selector(confirmT:) forControlEvents:UIControlEventTouchUpInside];
            
            [tcalheading setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            [cell.contentView addSubview:tcalheading];
            
            
          
                
                return cell;
            
            break;

            
        }
  
            
            
    }
    
  
                
                return cell;
    
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
        return 44;
    
}



- (IBAction)confirmT:(id)sender {
    
    if([cgbp.text isEqualToString: @""] || [cfee.text isEqualToString: @""]  ||[cngn.text isEqualToString: @""]  ||[ctotal.text isEqualToString: @""]   )
        
    {
        
        
        error.text = @"All fields are required";
        
    }
    else
    {
        
        
        if(compliance.isOn != 0)
            
        {
            
            
            
            if(uksms.isOn != 0)
                
            {
                
                _transfer.uksms = @"on";
                
            }
            
            
            if(ngnsms.isOn != 0)
                
            {
                
                _transfer.ngnsms = @"on";
                
            }
            
            
            _transfer.GBP = cgbp.text;
            
            _transfer.FEE = cfee.text;
            
            _transfer.NGN = cngn.text;
            
            _transfer.TOTAL = ctotal.text;
            
            
            SelectPayTableViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"selectpay"];
            
            [account setTransfer:_transfer];
            
            [self.navigationController pushViewController:account animated:YES];
            
            
            
        }
        else
        {
            
            
            
            
            error.text = @"You need to agree to our terms";
            
            
        }
        

        
        
    }
    
    
    
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self doCalculation:textField.tag withString:textField.text ];
    
    [textField resignFirstResponder];
    
    return YES;
    
}


- (void)doCalculation:(int)i withString:(NSString *)string {
    
    
    if (i == 1) {
        
        
        Cfullurl = [NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/gbp.php?amount=%@",string];
        
    }
    
    else if (i == 3){
        
        Cfullurl = [NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/ngn.php?amount=%@",string];
        
        
        
    }
    
    else if(i == 4)
        
        
    {
        
        Cfullurl = [NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/gbpdue.php?amount=%@",string];
        
        
        
    }
    
    
    Cfullurl = [Cfullurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    
    NSArray *validation = [[URLRequests alloc] makeurlrequest:Cfullurl];
    
    cgbp.text = [validation[0] objectForKey:@"GBP"];
    
    gbpTEXT = [validation[0] objectForKey:@"GBP"];
    
    cfee.text = [validation[0] objectForKey:@"COMM"];
    
    feeTEXT = [validation[0] objectForKey:@"COMM"];

    cngn.text = [validation[0] objectForKey:@"NGN"];
    
    ngnTEXT = [validation[0] objectForKey:@"NGN"];
    
    ctotal.text = [validation[0] objectForKey:@"DUE"];
    
    totalTEXT = [validation[0] objectForKey:@"DUE"];
    
    CAMOUNTPAIDLABEL.text = [validation[0] objectForKey:@"NGN"];
    
    CTOTALLABEL.text = [validation[0] objectForKey:@"DUE"];
    
    CFEELABEL.text = [validation[0] objectForKey:@"COMM"];
    
    CGBPLABEL.text = [validation[0] objectForKey:@"GBP"];
    
    _transfer.RATE = [validation[0] objectForKey:@"RATE"];
    
    
    
    
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
