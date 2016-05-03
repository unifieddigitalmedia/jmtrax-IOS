//
//  SignUpViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 01/12/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "SignUpViewController.h"
#import "HomePageViewController.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"
#import "KeychainItemWrapper.h"
#import "DashboardViewController.h"
#import "SignUpAddressViewController.h"
#import "URLRequests.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController


UITextField *username;

UITextField *password;

UITextField *cpassword;

UITextField *useremail;

 UITableView *SignUpTable;

UITextField *phone;

UITextField *fname;

UITextField *lname;

UITextView *signuperror;



@synthesize usernameTEXT;

@synthesize passwordTEXT;

@synthesize cpasswordTEXT;

@synthesize useremailTEXT;

@synthesize phoneTEXT;

@synthesize fnameTEXT;

@synthesize lnameTEXT;


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
    
    
    
      [HomePageCalButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    [HomePageToolbar addSubview:HomePageCalButton];
    
    
    UIButton *HomePageAccountButton = [[UIButton alloc] initWithFrame:CGRectMake(HomePageCalButton.frame.size.width,0,self.view.frame.size.width/2,self.navigationController.navigationBar.frame.size.height )];
    
    
    [HomePageAccountButton setTitle:@"2 ADDRESS" forState:UIControlStateNormal];
    
    
    [HomePageAccountButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    
     [HomePageToolbar addSubview:HomePageAccountButton];
   
    
    
    
   
    
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
    
    SignUpTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    [self.view  addSubview:SignUpTable];
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpTable.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
    
    SignUpTable.tableFooterView = footer;
    
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)
        
    {
        
        
        return 5;
        
    }
    
    
    return 10;
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
                
                
                username = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [username setPlaceholder:@"Please choose an username"];
                
                username.text = usernameTEXT;
                
                [username setBorderStyle:UITextBorderStyleRoundedRect];
                
                [username setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                username.tag = indexPath.row ;
                
                username.delegate = self;
                
                [cell.contentView addSubview:username];
                
                
                
              
                
                return cell;
                
                
                
            }
            case 2:
                
            {
                
                
                
                password = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [password setPlaceholder:@"Please choose a password"];
                
                password.text = passwordTEXT;
                
                [password setBorderStyle:UITextBorderStyleRoundedRect];
                [password setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                password.tag = indexPath.row;
                
                password.secureTextEntry = YES;
                
                password.delegate = self;
                
                [cell.contentView addSubview:password];
                
               
                
              
                
                return cell;
                
                
                
                
            }
            case 3:
            {
                
                cpassword = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [cpassword setPlaceholder:@"Please confirm you password"];
                
                cpassword.text = cpasswordTEXT;
                
                
                [cpassword setBorderStyle:UITextBorderStyleRoundedRect];
                
                [cpassword setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                cpassword.tag = indexPath.row ;
                
                cpassword.secureTextEntry = YES;
                
                cpassword.delegate = self;
                
                [cell.contentView addSubview:cpassword];
              
                
              
                
                return cell;
                
                
                
                
            }
            case 4:
            {
                
                
                
                useremail = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [useremail setPlaceholder:@"What is your email"];
                
                useremail.text = useremailTEXT;
                
                [useremail setBorderStyle:UITextBorderStyleRoundedRect];
               
                [useremail setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                useremail.tag = indexPath.row;
                
                useremail.delegate = self;
                
                [cell.contentView addSubview:useremail];
                
                
               
              
                
                return cell;
                
                
                
            }
            case 5:
            {
                
                
                UITextView *phoneplaceholder = [[UITextView alloc] initWithFrame:CGRectMake(0,0,cell.frame.size.width/4 ,cell.frame.size.height)];
                
                phoneplaceholder.text = @"+44";
                
                [phoneplaceholder setTextAlignment:NSTextAlignmentCenter];
                
                [cell.contentView addSubview:phoneplaceholder];
                
                
                phone = [[UITextField alloc] initWithFrame:CGRectMake(10+phoneplaceholder.frame.size.width,10,(cell.frame.size.width/4)*3-20,cell.frame.size.height-10)];
                
                [phone setPlaceholder:@"What is your phone"];
                
                [phone setBorderStyle:UITextBorderStyleRoundedRect];
               
                [phone setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                phone.text = phoneTEXT;
                
                phone.tag = indexPath.row ;
                
                phone.delegate = self;
                
                [cell.contentView addSubview:phone];
                
                
                
                             
                
                return cell;
                
                
                
            }
            case 6:
            {
                
                fname = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [fname setPlaceholder:@"What is your firstname"];
                
                fname.text = fnameTEXT;
                
                [fname setBorderStyle:UITextBorderStyleRoundedRect];
                
                [fname setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                fname.tag = indexPath.row ;
                
                 fname.delegate = self;
                
                [cell.contentView addSubview:fname];
                
              
                
              
                
                return cell;
                
                
                
            }
            case 7:
            {
                
                lname = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [lname setPlaceholder:@"What is your lastname"];
                
                lname.text = lnameTEXT;
                
                lname.tag = indexPath.row ;
                
                [lname setBorderStyle:UITextBorderStyleRoundedRect];
                
                [lname setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                lname.delegate = self;
                
                [cell.contentView addSubview:lname];

                
              
                
                return cell;
                
                
                
            }
            case 8:
            {
                signuperror = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
        
                [signuperror setTextAlignment:NSTextAlignmentCenter];
                
                
                [signuperror setTextColor:[UIColor redColor]];
                
                
                [cell.contentView addSubview:signuperror];

                
              
                
                return cell;
                
                
                
            }
            case 9:
            {
                
                
                UIButton *tcalheading = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                tcalheading.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
                
                [tcalheading setTitle:@"CONTINUE" forState:UIControlStateNormal];
                
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
    
    BOOL stricterFilter = YES;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    

    
    if([username.text isEqualToString: @""] || [useremail.text isEqualToString: @""]  ||[password.text isEqualToString: @""]  ||[cpassword.text isEqualToString: @""] ||[fname.text isEqualToString: @""] ||[lname.text isEqualToString: @""]   )
        
    {
        
        
        signuperror.text = @"All fields are required";
        
    }
    else if ([phone.text length] < 10 || [phone.text length]  > 10)
        
        
    {
        
        
        signuperror.text = @"Phone must be UK format without the zero";
        
        
        
        
    }
    else if ([emailTest evaluateWithObject:useremail.text] != YES )
        
    {
        
        
         signuperror.text = @"Please check your email";
        
    }
    else if ([password.text length ] < 8)
        
    {
        
        
        signuperror.text = @"Passwords must be atleast 8 characters in length";
        
    }
    else if (![password.text isEqualToString:cpassword.text] )
        
    {
        
        
        signuperror.text = @"Passwords do not match";
        
    }
  
    
    else
    {
        
        
        NSArray *validation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/signup.php?firstname=%@&lastname=%@&phone=%@&username=%@&password=%@&email=%@",fname.text,lname.text,phone.text,username.text,password.text,useremail.text] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        
        
        if([[validation[0] objectForKey:@"ERROR"] length ] == 0 )
        {
            
            
            
            
            SignUpAddressViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"signupaddress"];
            
            
            [account setSender_ID:[validation[0] objectForKey:@"senders_ID"] ];
            
            [self.navigationController pushViewController:account animated:YES];
            
        }else{
            
            signuperror.text = [validation[0] objectForKey:@"ERROR"];
            
            
        }
        
        
        
    }
    
    
    
    
  
    
    
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}


-(void)textFieldDidEndEditing:(UITextField*)textField {

    if(textField.tag == 1)



    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        usernameTEXT = t.text;
        
    }
    else if(textField.tag == 2)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        passwordTEXT = t.text;
        
    }
    else if(textField.tag == 3)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        cpasswordTEXT = t.text;
        
    }
    else if(textField.tag == 4)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        useremailTEXT = t.text;
        
    }else if(textField.tag == 5)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        phoneTEXT = t.text;
        
    }else if(textField.tag == 6)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        fnameTEXT = t.text;
        
    }else if(textField.tag == 7)
        
        
        
    {
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        lnameTEXT = t.text;
        
    }

}



@end
