//
//  HomeHelpViewController.m
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
#import "URLRequests.h"
#import "KeychainItemWrapper.h"
#import "DashboardViewController.h"

@interface HomeHelpViewController ()

@end

@implementation HomeHelpViewController



UITextField *email;
UITextField *subject;
UITextField *message;
UIToolbar *HelpPageToolbar;

UIButton *HelpPageCalButton;

UIButton *HelpPageAccountButton;

UIButton *HelpPageHelpButton ;


UITextView *helperrormessage;

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
                
                UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [tcalheading setText:@"Contact us"];
                
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
                
                
                UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [tcalheading setText:@"82 High St London SE25 6EA 020 8771 5353"];
                
                [tcalheading setEditable:false];
                
                [tcalheading setTextAlignment:NSTextAlignmentCenter];
                
                UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
                
                [tcalheading setTextColor:myColor];
                
                tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
                
                [tcalheading setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [cell.contentView addSubview:tcalheading];
                
              
                
                return cell;
                
                break;
                
                
            }
            case 2:
                
            {
                
                email = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [email setPlaceholder:@"What is your email"];
                
                [email setBorderStyle:UITextBorderStyleRoundedRect];
                [email setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                 email.delegate = self;
                
                [cell.contentView addSubview:email];
                
                
              
                
                return cell;
                
                
                
                
            }
            case 3:
            {
                
                
                subject = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                 [subject setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                [subject setPlaceholder:@"Subject"];
                
                [subject setBorderStyle:UITextBorderStyleRoundedRect];
                
                subject.delegate = self;
                
                [cell.contentView addSubview:subject];
                
                
              
                
                return cell;

                
                
                
                
            }
            case 5:
            {
                
                helperrormessage = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
            
        
                
                
                [helperrormessage setTextAlignment:NSTextAlignmentCenter];
                
                
                [helperrormessage setTextColor:[UIColor redColor]];
                
              
                
                return cell;
                
                
            }
            case 4:
            {
                
                message = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [message setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                [message setPlaceholder:@"Message"];
                
                [message setBorderStyle:UITextBorderStyleRoundedRect];
                
                message.tag = indexPath.row;
                
                message.delegate = self;
                
                [cell.contentView addSubview:message];
                
                
              
                
                return cell;
                
                
            }
            case 6:
            {
                
                UIButton *tcalheading = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                tcalheading.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
                
                [tcalheading setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [tcalheading setTitle:@"SEND" forState:UIControlStateNormal];
                
                [tcalheading setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                 UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
            
            [tcalheading setBackgroundColor:myColor];
                
                [tcalheading addTarget:self action:@selector(sendmessage:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [cell.contentView addSubview:tcalheading];
                
                
              
                
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






- (IBAction)sendmessage:(id)sender {
    
    BOOL stricterFilter = YES;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    
    
    
    
    if([email.text isEqualToString: @""] || [message.text isEqualToString: @""]  ||[subject.text isEqualToString: @""]    )
        
    {
        
        
        helperrormessage.text = @"All fields are required";
        
    }
    else if ([emailTest evaluateWithObject:email.text] != YES )

    {
        
        
          helperrormessage.text= @"A valid email is required" ;
        
    }
    else{
        
        
        
        NSArray *validation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://jmtrax.net/app_php_files/help.php?email=%@&subject=%@&message=%@",email.text,subject.text,message.text] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        
        if([[validation[0] objectForKey:@"ERROR"] length ] == 0)
            
        {
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        else
        {
            
            email.text= @"";
            
            subject.text = @"";
            
            message.text = @"";
            
             helperrormessage.text= [validation[0] objectForKey:@"ERROR"];
            
            
        }
        
        
        
        
        
    }
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [textField resignFirstResponder];
    
    return YES;
    
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


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 5 ) {
        
        
        
        return 80;
        
    }
    
    return 44;
    
}

- (IBAction) textFieldDidChange: (UITextField*) textField
{
    
    if(textField.tag == 5)
    {
        
        [UIView animateWithDuration:0.1 animations:^{
            [textField invalidateIntrinsicContentSize];
        }];
        
    }
    
}

@end
