//
//  SignUpAddressViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 01/12/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "SignUpAddressViewController.h"
#import "SignUpViewController.h"
#import "HomePageViewController.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"
#import "KeychainItemWrapper.h"
#import "DashboardViewController.h"
#import "SignUpAddressViewController.h"
#import "URLRequests.h"

@interface SignUpAddressViewController ()

@end

@implementation SignUpAddressViewController

UITextField *postcode;

UITextField *town;

UITextField *firstline;

UITextField *secondline;


UITextField *county;


UITableView *SignUpTable1;

UITextView *signupaddresserror;



@synthesize sender_ID;

@synthesize postcodeTEXT;

@synthesize townTEXT;

@synthesize firstlineTEXT;

@synthesize secondlineTEXT;

@synthesize countyTEXT;


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
    
    
    UIButton *HomePageCalButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width/2,self.navigationController.navigationBar.frame.size.height )];
    
    
    [HomePageCalButton setTitle:@"1 DETAILS" forState:UIControlStateNormal];
    
    
     [HomePageCalButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    
    
    
    [HomePageToolbar addSubview:HomePageCalButton];
    
    
    UIButton *HomePageAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageCalButton.frame.size.width,0,self.view.frame.size.width/2,self.navigationController.navigationBar.frame.size.height )];
    
    
    [HomePageAccountButton setTitle:@"2 ADDRESS" forState:UIControlStateNormal];
    
     [HomePageAccountButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
     [HomePageToolbar addSubview:HomePageAccountButton];
    
    
    
    
    
    SignUpTable1 = [[UITableView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    //SignUpTable. .contentInset = UIEdgeInsetsMake(20,0,20, 0);
    
    [SignUpTable1 registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"StaticCell"];
    
    SignUpTable1.delegate = self;
    
    SignUpTable1.dataSource = self;
    
    SignUpTable1.bounces = NO;
    
    SignUpTable1.scrollEnabled = YES;
    
    SignUpTable1.clipsToBounds = YES;
    
    SignUpTable1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    SignUpTable1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SignUpTable1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    [self.view  addSubview:SignUpTable1];
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpTable1.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
    
    SignUpTable1.tableFooterView = footer;
    
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)
        
    {
        
        
        return 5;
        
    }
    
    
    return 7;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    
   cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if(indexPath.section == 0)
    {
        
        
        
        
        
        switch (indexPath.row)
        
        
        
        {
                
          
            case 0:
            {
                
                
                postcode = [[UITextField alloc] initWithFrame:CGRectMake(10,10,(cell.frame.size.width/3)-10 ,cell.frame.size.height-10)];
                
                [postcode setPlaceholder:@"Postcode"];
                
                postcode.delegate = self;
                
                postcode.text = postcodeTEXT;
                
                postcode.tag = 100  ;
                
                [postcode setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                [postcode setBorderStyle:UITextBorderStyleRoundedRect];
                
                town = [[UITextField alloc] initWithFrame:CGRectMake(cell.frame.size.width - ((cell.frame.size.width/3 )*2 ) + 10 ,10,(cell.frame.size.width/3 )*2 - 20,cell.frame.size.height - 10)];
                
                [town setPlaceholder:@"Town"];
                
                town.delegate = self;
                
                town.text = townTEXT;
                
                [town setBorderStyle:UITextBorderStyleRoundedRect];
                
                [town setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                postcode.tag = 200 ;
                
                
                [cell.contentView addSubview:town];
                
                [cell.contentView addSubview:postcode];
                
                
                
              
                
                return cell;
                
                
                
            }
            case 1:
            {
                
                UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [tcalheading setText:@"Address Details"];
                
                [tcalheading setEditable:false];
                
                [tcalheading setTextAlignment:NSTextAlignmentLeft];
                
                UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
                
                [tcalheading setTextColor:myColor];
                
                tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
                
                [cell.contentView addSubview:tcalheading];
                
              
                
                return cell;
                
                break;
                
                
                
                
            }
            case 2:
                
            {
                firstline = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [firstline setPlaceholder:@"First Line"];
                
                firstline.delegate = self;
                
                firstline.text = firstlineTEXT;
                
                firstline.tag = indexPath.row ;
                [firstline setBorderStyle:UITextBorderStyleRoundedRect];
                
                
                [firstline setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [cell.contentView addSubview:firstline];
                
                
                
              
                
                return cell;
                
                
                
                
            }
            case 3:
            {
                
                secondline = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [secondline setPlaceholder:@"Second Line"];
                
                secondline.delegate = self;
                
                secondline.text = secondlineTEXT;
                
                secondline.tag = indexPath.row ;
                [secondline setBorderStyle:UITextBorderStyleRoundedRect];
                
                
                [secondline setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                [cell.contentView addSubview:secondline];
                
                
              
                
                return cell;
                
                
                
                
            }
            case 4:
            {
                
                
                
                county = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [county setBorderStyle:UITextBorderStyleRoundedRect];
                
                county.text = countyTEXT;
                
                county.tag = indexPath.row ;
                
                [county setPlaceholder:@"Country"];
                
                county.delegate = self;
                [county setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [cell.contentView addSubview:county];
                
                
                
              
                
                return cell;
                
                
                
            }
            case 5:
            {
                
                
                
                signupaddresserror = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                
                [signupaddresserror setTextAlignment:NSTextAlignmentCenter];
                
                
                [signupaddresserror setTextColor:[UIColor redColor]];
                
                
                [cell.contentView addSubview:signupaddresserror];
                
                
                
              
                
                return cell;
                
                
                
            }
                       case 6:
            {
                
                
                UIButton *tcalheading = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                tcalheading.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
                
                [tcalheading setTitle:@"SIGN UP" forState:UIControlStateNormal];
                
                [tcalheading setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                 UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
            
            [tcalheading setBackgroundColor:myColor];
                
                [tcalheading addTarget:self action:@selector(continuesignup:) forControlEvents:UIControlEventTouchUpInside];
                
                [tcalheading setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                [cell.contentView addSubview:tcalheading];
                
                
              
                
                return cell;
                
                
                
                
                
                
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


- (IBAction)continuesignup:(id)sender {
    

    
    if([postcode.text isEqualToString: @""] || [town.text isEqualToString: @""]  ||[firstline.text isEqualToString: @""]  ||[secondline.text isEqualToString: @""] ||[county.text isEqualToString: @""]  )
        
    {
        
        
        signupaddresserror.text = @"All fields are required";
        
    }
    
    else
    {
        
        
        NSArray *validation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/signup_address.php?firstline=%@&secondline=%@&town=%@&county=%@&postcode=%@&sender_ID=%@",firstline.text,secondline.text,town.text,county.text,postcode.text,sender_ID] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
       
        
        if([[validation[0] objectForKey:@"ERROR"] length ] == 0 )
        {
            
            KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"jmtransfers" accessGroup:nil];
            
            
              [keychainItem setObject: [validation[0] objectForKey:@"username"]  forKey:(__bridge id)(kSecAttrCreator)];
            
            
            DashboardViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
            [self.navigationController pushViewController:account animated:YES];
            
        }else{
            
            signupaddresserror.text = [validation[0] objectForKey:@"ERROR"];
            
            
        }
        
        
        
    }
    
    
    
    
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}


- (IBAction)gotosignup:(id)sender {
    
    
    HomeAccountViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"homeaccount"];
    [self.navigationController pushViewController:account animated:YES];
    
    
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
    
    
    HomeAccountViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"homeaccount"];
    
    [self.navigationController pushViewController:account animated:YES];
    
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




-(void)textFieldDidEndEditing:(UITextField*)textField {
    
    if(textField.tag == 100)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        
        UITableViewCell* cell = [SignUpTable1 cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        postcodeTEXT = t.text;
        
    }
    else if(textField.tag == 200)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        
        UITableViewCell* cell = [SignUpTable1 cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        townTEXT = t.text;
        
    }
    else if(textField.tag == 2)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable1 cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        firstlineTEXT = t.text;
        
    }
    else if(textField.tag == 3)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable1 cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        secondlineTEXT = t.text;
        
    }
    else if(textField.tag == 4)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable1 cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        countyTEXT = t.text;
        
    }
    
}
@end
