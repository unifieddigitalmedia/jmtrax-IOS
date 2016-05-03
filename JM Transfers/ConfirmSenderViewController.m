//
//  ConfirmSenderViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"
#import "HomePageViewController.h"
#import "ConfirmSenderViewController.h"
#import "ConfirmTransferViewController.h"
#import "URLRequests.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"
#import "KeychainItemWrapper.h"
#import "DashboardViewController.h"
@interface ConfirmSenderViewController ()

@end

@implementation ConfirmSenderViewController

UITextView *scalheading;

NSArray *confirmvalidation;

UITextField *sendercountry;

UITextField *sendertown;

UITextField *senderfirst;

UITextField *senderpostcode;

UITextField *senderemail;

UITextField *senderphone;

UITextField *senderlastname;

UITextField *senderfirstname;

@synthesize sendererrorText;


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

    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"jmtransfers" accessGroup:nil];


    
     confirmvalidation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/settings.php?username=%@",[keychainItem objectForKey:(id)kSecAttrCreator]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
   
    
    _transfer.sendercountry = [confirmvalidation[0] objectForKey:@"County"];
    
    _transfer.sendertown = [confirmvalidation[0] objectForKey:@"Town"];
    
   _transfer.senderfirst = [confirmvalidation[0] objectForKey:@"Line1"];
    
    _transfer.senderpostcode = [confirmvalidation[0] objectForKey:@"Postcode"];
    
    _transfer.senderemail = [confirmvalidation[0] objectForKey:@"Email"];
    
    _transfer.senderphone = [confirmvalidation[0] objectForKey:@"Phone"];
    
    _transfer.senderlastname = [confirmvalidation[0] objectForKey:@"LastName"];
    
    _transfer.senderfirstname = [confirmvalidation[0] objectForKey:@"FirstName"];
    
    sendererrorText = @"Address details";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)
        
    {
        
        
        return 5;
        
    }
    
    return 11;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    if(indexPath.section == 0)
        
    {
    
    switch (indexPath.row) {
            
        case 0:
        {
            
            
            UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [tcalheading setText:@"Profile Information"];
            
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
            
            
            
        senderfirstname = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            senderfirstname.text = [confirmvalidation[0] objectForKey:@"FirstName"];
            
            senderfirstname.delegate = self;
            
            [senderfirstname setBorderStyle:UITextBorderStyleRoundedRect];
           
            
              [senderfirstname setPlaceholder:@"First Name"];
            
            
            [senderfirstname setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
            [cell.contentView addSubview:senderfirstname];
            
            
            return  cell;
            
            break;
            
            
        }
        case 2:
            
        {
            
           senderlastname = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            senderlastname.text = [confirmvalidation[0] objectForKey:@"LastName"];
            [senderlastname setBorderStyle:UITextBorderStyleRoundedRect];
            
            
            [senderlastname setPlaceholder:@"Last Name"];
            
            [senderlastname setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
            senderlastname.delegate = self;
            
            
            [cell.contentView addSubview:senderlastname];
            
            
            return  cell;
            
            break;
            
            
            
            
        }
        case 3:
            
        {
            
            
            UITextView *phoneplaceholder = [[UITextView alloc] initWithFrame:CGRectMake(0,0,cell.frame.size.width/4 ,cell.frame.size.height)];
            
            phoneplaceholder.text = @"+44";
            
            [phoneplaceholder setTextAlignment:NSTextAlignmentCenter];
            
            [cell.contentView addSubview:phoneplaceholder];
            
            
            senderphone = [[UITextField alloc] initWithFrame:CGRectMake(10+phoneplaceholder.frame.size.width,10,(cell.frame.size.width/4)*3-20,cell.frame.size.height-10)];            
            
            [senderphone setPlaceholder:@"Phone"];
            
            senderphone.delegate = self;
            
            [senderphone setBorderStyle:UITextBorderStyleRoundedRect];
            
            [senderphone setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
            senderphone.text = [confirmvalidation[0] objectForKey:@"Phone"];
            
            [cell.contentView addSubview:senderphone];
            
        
            
            return  cell;
            
            break;
            
            
        }
        case 4:
            
        {
            
            senderemail = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [senderemail setPlaceholder:@"Email"];
            
            senderemail.delegate = self;
            
             senderemail.text = [confirmvalidation[0] objectForKey:@"Email"];
            
            [senderemail setBorderStyle:UITextBorderStyleRoundedRect];
            
            [senderemail setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
            [cell.contentView addSubview:senderemail];
            
          
                
                return cell;
            
            break;
            
            
            
        }
            
        case 5:
        {
            
            
            scalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
          
            
            scalheading.text = sendererrorText ;
            
            [scalheading setEditable:false];
            
            [scalheading setTextAlignment:NSTextAlignmentCenter];
            
            [scalheading setTextColor:[UIColor redColor]];
            
            
            scalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
            
            [cell.contentView addSubview:scalheading];
            
          
                
                return cell;
            
            break;
            
            
        }
        case 6:
        {
            
            
           senderpostcode = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [senderpostcode setPlaceholder:@"Postcode"];
            
            senderpostcode.delegate = self;
            
            [senderpostcode setBorderStyle:UITextBorderStyleRoundedRect];
           
            [senderpostcode setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
             senderpostcode.text = [confirmvalidation[0] objectForKey:@"Postcode"];
            
            [cell.contentView addSubview:senderpostcode];
            
            
          
                
                return cell;
            break;
            
            
        }
        case 7:
        {
            
            
       
            
            senderfirst = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [senderfirst setPlaceholder:@"1st Line"];
            
            senderfirst.delegate = self;
            
            
            [senderfirst setBorderStyle:UITextBorderStyleRoundedRect];
           
            [senderfirst setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
             senderfirst.text = [confirmvalidation[0] objectForKey:@"Line1"];
            
            [cell.contentView addSubview:senderfirst];
            
            
          
                
                return cell;
            break;
            
            
        }
        case 8:
        {
            
            
            
           
            
            sendertown = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [sendertown setPlaceholder:@"Town"];
            
            sendertown.delegate = self;
            
             sendertown.text = [confirmvalidation[0] objectForKey:@"Town"];
            
            [sendertown setBorderStyle:UITextBorderStyleRoundedRect];
            
            [sendertown setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            
            
            [cell.contentView addSubview:sendertown];
            
            
          
                
                return cell;
            
            break;
            
            
        }
        case 9:
        {
            
            sendercountry = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
            [sendercountry setPlaceholder:@"Country"];
            
            sendercountry.delegate = self;
            
             sendercountry.text = [confirmvalidation[0] objectForKey:@"County"];
            
            [sendercountry setBorderStyle:UITextBorderStyleRoundedRect];
            
            [sendercountry setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            

            [cell.contentView addSubview:sendercountry];
            
            
          
                
                return cell;
            
          
            
            break;
            
            
        }
        case 10:
        {
            
       
            UIButton *tcalheading = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            tcalheading.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
            
            [tcalheading setTitle:@"CONFIRM SENDER" forState:UIControlStateNormal];
            
            [tcalheading setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
             UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
            
            [tcalheading setBackgroundColor:myColor];
            
            [tcalheading addTarget:self action:@selector(confirms:) forControlEvents:UIControlEventTouchUpInside];
            
            [tcalheading setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
           
            
            [cell.contentView addSubview:tcalheading];
            
            
            return  cell;
            
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




- (IBAction)confirms:(id)sender {
    
    
    
  
    
    if([sendercountry.text isEqualToString: @""] || [sendertown.text isEqualToString: @""]  ||[senderfirst.text isEqualToString: @""]  ||[senderpostcode.text isEqualToString: @""] ||[senderemail.text isEqualToString: @""] ||[senderphone.text isEqualToString: @""] ||[senderlastname.text isEqualToString: @""] ||[senderfirstname.text isEqualToString: @""]  )
    
    {
        
        
        sendererrorText = @"All fields are required";
        
    }
    else if ([senderphone.text length] < 10 || [senderphone.text length]  > 10)
        
        
    {
        
        
        sendererrorText = @"Phone must be UK format without the zero";
        
        
        
        
    }
    else
        
    {
        
        
       
        NSArray *confirmvalidation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/updateSender.php?username=%@&firstname=%@&lastname=%@&phone=%@&email=%@&postcode=%@&town=%@&firstline=%@&county=%@",_username,senderfirstname.text,senderlastname.text ,senderphone.text ,senderemail.text ,senderpostcode.text ,sendertown.text,senderfirst.text,sendercountry.text] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
      
        
        if([[confirmvalidation[0] objectForKey:@"ERROR"] length ] == 0 )
            
        {
            ConfirmTransferViewController *dash = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmtransfer"];
            [dash setTransfer:_transfer];
            [self.navigationController pushViewController:dash animated:YES];
            
            
            
        }
        else
        {
            
              sendererrorText =[confirmvalidation[0] objectForKey:@"ERROR"];
            
            
        }
        
        

        
        
    }

    
    
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
