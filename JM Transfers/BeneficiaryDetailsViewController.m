//
//  BeneficiaryDetailsViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "BeneficiaryDetailsViewController.h"
#import "ConfirmSenderViewController.h"
#import "URLRequests.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"
#import "KeychainItemWrapper.h"
#import "DashboardViewController.h"
#import "Transfer.h"
#import "HomePageViewController.h"
@interface BeneficiaryDetailsViewController ()

@end

@implementation BeneficiaryDetailsViewController



@synthesize recerrorTEXT;

@synthesize recfirstnameTEXT;

@synthesize reclastnameTEXT;

@synthesize recphoneTEXT;

@synthesize recbankTEXT;

@synthesize recaccountTEXT;

@synthesize recpaymentrefTEXT;

@synthesize recpayeebankTEXT;

@synthesize recreasonfortransferTEXT;

UITextView *Breccalheading;
UITextField *Brecreason;
UITextField *Brecpayment;
UITextField *Brecaccount;
UITextField *Brecbank;
UITextField *Brecphone;
UITextField *Breclastname;
UITextField *Brecfirstname;
UITextField *Bbankrecpayment;
NSArray *Bpayrefarray;
NSArray *banklist;
NSArray *payeebanks;
NSArray *reasonarray;
UITableView *SignUpBenTable;
Transfer *newtransfer;

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
    
    
    Bpayrefarray = [NSArray arrayWithObjects:@"Bank",nil];
    
     reasonarray = [NSArray arrayWithObjects:@"Family assitance",@"Commercial",@"Help",@"Pret",@"Other",nil];
    
    
    banklist = [[URLRequests alloc] makeurlrequest:@"http://www.jmtrax.net/app_php_files/getbanks.php?"];
    
    
    
     payeebanks = [[URLRequests alloc] makeurlrequest:@"http://www.jmtrax.net/app_php_files/shop_acc.php?"];
    
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
    
    
   
    
    SignUpBenTable = [[UITableView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    //SignUpTable. .contentInset = UIEdgeInsetsMake(20,0,20, 0);
    
    
     SignUpBenTable.delegate = self;
    
    [SignUpBenTable registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"StaticCell"];
    
    SignUpBenTable.dataSource = self;
    
    SignUpBenTable.bounces = NO;
    
    SignUpBenTable.scrollEnabled = YES;
    
    SignUpBenTable.clipsToBounds = YES;
    
    SignUpBenTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    SignUpBenTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view  addSubview:SignUpBenTable];
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpBenTable.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
    
    SignUpBenTable.tableFooterView = footer;
    
    recfirstnameTEXT = _transfer.recfirstname;
    
    reclastnameTEXT = _transfer.reclastname;
    
    recphoneTEXT = _transfer.recphone;
    
    recbankTEXT = _transfer.recbank;
    
    recaccountTEXT = _transfer.recaccount;
    
    recpaymentrefTEXT = _transfer.recpayment ;
    
    recpayeebankTEXT= _transfer.ShopAcc;
    
    recreasonfortransferTEXT= _transfer.recreason;
    
    recerrorTEXT = @"Bank details requierments";
    
    newtransfer = [[Transfer alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=0) {
        scrollView.contentOffset = CGPointZero;
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
    
    return 15;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    
 
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /*if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }*/

    
    if(indexPath.section == 1)
    {
        
        
        
       static NSString *cellIdentifier = @"StaticCell";
    
        
        CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        
        if(indexPath.row == 0)
        {
            
            cell.textLabel.text = @"Fee Calculator";
            
            cell.textLabel.textColor = [UIColor whiteColor];
            
            return cell;

        }
        else if (indexPath.row == 1)
        {
            
            cell.textLabel.text = @"Log in or register";
            
            cell.textLabel.textColor = [UIColor whiteColor];
            
            
            
            
            return cell;
            
        }
        else if (indexPath.row == 2)
            
        {
            
            cell.textLabel.text = @"Website";
            cell.textLabel.textColor = [UIColor whiteColor];
        
            
            return cell;

            
        }
        
        else if (indexPath.row == 3)
            
        {
            
            
            cell.textLabel.text = @"Terms and Conditions";
            cell.textLabel.textColor = [UIColor whiteColor];
            
            
            
            
            return cell;
           
        }
        else if (indexPath.row == 4)
        {
            
            cell.textLabel.text = @"Contact Us";
            cell.textLabel.textColor = [UIColor whiteColor];
            
            
            
            return cell;
            
            
        }
        
    }
    
    else
        
    {
        
        switch (indexPath.row) {
                
            case 0:
            {
                
                
                UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [tcalheading setText:@"Beneficiary details"];
                
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
                
                
                Brecfirstname = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [Brecfirstname setPlaceholder:@"Firstname"];
                
                Brecfirstname.delegate = self;
                
                [Brecfirstname setBorderStyle:UITextBorderStyleRoundedRect];
                
                Brecfirstname.text = recfirstnameTEXT;
                
                Brecfirstname.tag = indexPath.row;
                
                [Brecfirstname setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [cell.contentView addSubview:Brecfirstname];
                
                
                
                
                return cell;
                
                 break;
            }
            case 2:
                
            {
                
                
                
                
                
                Breclastname = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [Breclastname setPlaceholder:@"Lastname"];
                
                Breclastname.text = reclastnameTEXT;
                
                Breclastname.delegate = self;
                
                Breclastname.tag = indexPath.row;
                
                [Breclastname setBorderStyle:UITextBorderStyleRoundedRect];
                
                [Breclastname setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [cell.contentView addSubview:Breclastname];
                
                
                
                
                return cell;
                
                
                 break;
                
                
            }
            case 3:
                
            {
                Brecphone = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [Brecphone setPlaceholder:@"Phone"];
                
                
                [Brecphone setBorderStyle:UITextBorderStyleRoundedRect];
                
                
                Brecphone.text = recphoneTEXT;
                
                Brecphone.tag = indexPath.row;
                
                Brecphone.delegate = self;
                
                [Brecphone setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [cell.contentView addSubview:Brecphone];
                
                
                
                
                return cell;
                 break;
                
            }
            case 4:
                
            {
                
                
                UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [tcalheading setText:@"Beneficiary bank details"];
                
                [tcalheading setEditable:false];
                
                [tcalheading setTextAlignment:NSTextAlignmentLeft];
                
                UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
                
                [tcalheading setTextColor:myColor];
                
                tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
                
                [tcalheading setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                
                [cell.contentView addSubview:tcalheading];
                
                
                
                return cell;
                
                break;
                
                
                
            }
                
                
            case 5:
            {
                
                
                Brecbank = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [Brecbank setPlaceholder:@"Select a Bank"];
                
                Brecbank.delegate = self;
                
                Brecbank.text = recbankTEXT;
                
                Brecbank.tag = indexPath.row;
                
                [Brecbank setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [Brecbank setBorderStyle:UITextBorderStyleRoundedRect];
                
                UIPickerView *bankpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height/3)];
                
                
                bankpicker.tag = 1;
                
                bankpicker.delegate = self;
                
                bankpicker.dataSource = self;
                
                [Brecbank setInputView:bankpicker];
                
                
                
                
                [cell.contentView addSubview:Brecbank];
                
                
                
                
                return cell;
                break;
                
                
            }
            case 6:
            {
                
                
                Brecaccount = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [Brecaccount setPlaceholder:@"Account number"];
                
                Brecaccount.delegate = self;
                
                Brecaccount.tag = indexPath.row;
                
                [Brecaccount setBorderStyle:UITextBorderStyleRoundedRect];
                
                Brecaccount.text = recaccountTEXT;
                
                
                [Brecaccount setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                
                [cell.contentView addSubview:Brecaccount];
                
                
                
                
                return cell;
                break;
                
                
            }
            case 7:
            {
                
                
                Breccalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                
                Breccalheading.text = recerrorTEXT;
                
               
                
                [Breccalheading setEditable:false];
                
                [Breccalheading setTextAlignment:NSTextAlignmentLeft];
                
                [Breccalheading setTextColor:[UIColor redColor]];
                
                [Breccalheading setTextAlignment:NSTextAlignmentCenter];
                
                
                
                Breccalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
                
                
                [cell.contentView addSubview:Breccalheading];
                
                
                
                return cell;
                
                break;
                
                
            }
            case 8:
            {
                
             
            cell.textLabel.text = @"Account number must be 10 characters in length";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                cell.textLabel.numberOfLines = 0;
                
                
                return cell;
                
                break;
                
                
            }
            case 9:
            {
                
                
                UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [tcalheading setText:@"Payment details"];
                
                [tcalheading setEditable:false];
                
                [tcalheading setTextAlignment:NSTextAlignmentLeft];
                
                UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
                
                [tcalheading setTextColor:myColor];
                
                tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
                
                [cell.contentView addSubview:tcalheading];
                
                
                
                return cell;
                
                break;
                
                
            }
                
            case 10:
            {
                
                
                Brecpayment = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [Brecpayment setPlaceholder:@"Select a Payment Reference"];
                
                Brecpayment.delegate = self;
                
                Brecpayment.tag = indexPath.row;
                
                Brecpayment.text = recpaymentrefTEXT;
                
                [Brecpayment setBorderStyle:UITextBorderStyleRoundedRect];
                
                
                
                [Brecpayment setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                UIPickerView *paymentpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height/3)];
                
                
                paymentpicker.tag = 0;
                
                paymentpicker.delegate = self;
                
                paymentpicker.dataSource = self;
                
                [Brecpayment setInputView:paymentpicker];
                
                
                [cell.contentView addSubview:Brecpayment];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 11:
            {
                
                
                Bbankrecpayment = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [Bbankrecpayment setPlaceholder:@"Select a Payee Bank"];
                
                Bbankrecpayment.delegate = self;
                
                Bbankrecpayment.tag = indexPath.row;
                
                
                Bbankrecpayment.text = recpayeebankTEXT;
                
                [Bbankrecpayment setBorderStyle:UITextBorderStyleRoundedRect];
                
                [Bbankrecpayment setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                UIPickerView *payeepicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height/3)];
                
                payeepicker.tag = 2;
                
                payeepicker.delegate = self;
                
                payeepicker.dataSource = self;
                
                [Bbankrecpayment setInputView:payeepicker];
                
                
                
                
                [cell.contentView addSubview:Bbankrecpayment];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 12:
            {
                
                
                
                Brecreason = [[UITextField alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [Brecreason setPlaceholder:@"Select a reason for transfer"];
                
                Brecreason.delegate = self;
                
                Brecreason.tag = indexPath.row;
                
                
                [Brecreason setBorderStyle:UITextBorderStyleRoundedRect];
                
                
                [Brecreason setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                Brecreason.text = recreasonfortransferTEXT;
                
                
                UIPickerView *reasonpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height/3)];
                
                
                reasonpicker.tag = 3;
                
                reasonpicker.delegate = self;
                
                reasonpicker.dataSource = self;
                
                [Brecreason setInputView:reasonpicker];
                
                
                
                
                [cell.contentView addSubview:Brecreason];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 13:
            {
                
                
                UIButton *tadd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                tadd.frame = CGRectMake(5,5,(cell.frame.size.width/2)-10 ,cell.frame.size.height -5 );
                
                
                
                
                [tadd setTitle:@"ADD" forState:UIControlStateNormal];
                
                [tadd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
                
                
                [tadd setBackgroundColor:myColor];
                
                [tadd addTarget:self action:@selector(addb:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [tadd setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [cell.contentView addSubview:tadd];
                
                
                UIButton *tupdate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                
                
                tupdate.frame = CGRectMake(tadd.frame.size.width+10,5,(cell.frame.size.width/2 )-10,cell.frame.size.height-5);
                
                
                [tupdate setTitle:@"UPDATE" forState:UIControlStateNormal];
                
                [tupdate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                
                [tupdate setBackgroundColor:myColor];
                
                [tupdate addTarget:self action:@selector(confirmb:) forControlEvents:UIControlEventTouchUpInside];
                [tupdate setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                
                [cell.contentView addSubview:tupdate];
                
                
                return  cell;
                
                break;
                
                
            }
            case 14:
                
            {
                
                
                
                
                UIButton *tadd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                tadd.frame = CGRectMake(5,5,(cell.frame.size.width/2)-10 ,cell.frame.size.height-5);
                
                
                
                
                
                [tadd setTitle:@"DELETE" forState:UIControlStateNormal];
                
                [tadd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
                
                
                [tadd setBackgroundColor:myColor];
                
                [tadd addTarget:self action:@selector(deleteb:) forControlEvents:UIControlEventTouchUpInside];
                
                [tadd setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                [cell.contentView addSubview:tadd];
                
                
                UIButton *tupdate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                tupdate.frame = CGRectMake(tadd.frame.size.width+10,5,(cell.frame.size.width/2 )-10,cell.frame.size.height-5);
                
                
                
                
                [tupdate setTitle:@"TRANSFER" forState:UIControlStateNormal];
                
                [tupdate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                
                
                [tupdate setBackgroundColor:myColor];
                
                [tupdate addTarget:self action:@selector(confirmb:) forControlEvents:UIControlEventTouchUpInside];
                
                [tupdate setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                [cell.contentView addSubview:tupdate];
                
                
                return  cell;
                
                break;
                
                
                
                
                
                
            }
                
                
        

        
    }
    
    
               }
                return cell;
    
}



- (IBAction)confirmb:(id)sender {
    
    
    
    
    
    if([Brecfirstname.text isEqualToString: @""] || [Breclastname.text isEqualToString: @""]  ||[Brecphone.text isEqualToString: @""]  ||[Brecbank.text isEqualToString: @""] ||[Brecaccount.text isEqualToString: @""] ||[Brecpayment.text isEqualToString: @""] ||[Brecreason.text isEqualToString: @""]  || [Bbankrecpayment.text isEqualToString:@""] )
        
    {
        
        
        recerrorTEXT = @"All fields are required";
        
    }
    else if ([Brecaccount.text length] < 10)
        
        
    {
        
        
        recerrorTEXT = @"Bank account number must be atleast 10 characters in length";
        
        
        
        
    }
    else
    {
        
        
        NSArray *validation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/updater.php?id=%d&firstname=%@&lastname=%@&phone=%@&bank=%@&account=%@&reference=%@&reason=%@&shopAcc=%@",_transfer.recID,Brecfirstname.text,Breclastname.text,Brecphone.text,Brecbank.text,Brecaccount.text,Brecpayment.text,Brecreason.text,Bbankrecpayment.text]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
       
        
        if([[validation[0] objectForKey:@"ERROR"] length ] == 0 )
        {
            
            
            
            
            _transfer.recreason = Brecreason.text;
            _transfer.recpayment = Brecpayment.text;
            _transfer.recaccount = Brecaccount.text;
            _transfer.recbank = Brecbank.text;
            _transfer.recphone = Brecphone.text ;
            _transfer.reclastname = Breclastname.text;
            _transfer.recfirstname = Brecfirstname.text;
            _transfer.recID = _transfer.recID;
            _transfer.ShopAcc = Bbankrecpayment.text;
           
            
            
            ConfirmSenderViewController *dash = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmsender"];
            [dash setTransfer:_transfer];
            [self.navigationController pushViewController:dash animated:YES];
            
            
        }else{
            
            recerrorTEXT = [validation[0] objectForKey:@"ERROR"];
        }
        
        
        
    }
    
    
    
    
    
}


- (IBAction)addb:(id)sender {
    
    
    
    if([Brecfirstname.text isEqualToString: @""] || [Breclastname.text isEqualToString: @""]  ||[Brecphone.text isEqualToString: @""]  ||[Brecbank.text isEqualToString: @""] ||[Brecaccount.text isEqualToString: @""] ||[Brecpayment.text isEqualToString: @""] ||[Brecreason.text isEqualToString: @""]|| [Bbankrecpayment.text isEqualToString:@""]    )
        
    {
        
        
        recerrorTEXT = @"All fields are required";
        
    }
    else if ([Brecaccount.text length] < 10)
        
        
    {
        
        
        recerrorTEXT = @"Bank account number must be atleast 10 characters in length";
        
        
    }
    else
    {
        
        
        
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"jmtransfers" accessGroup:nil];
        
      
       
        
        


        NSArray *validation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/add.php?id=%d&firstname=%@&lastname=%@&phone=%@&bank=%@&account=%@&reference=%@&reason=%@&shopAcc=%@&username=%@",_transfer.recID,Brecfirstname.text,Breclastname.text,Brecphone.text,Brecbank.text,Brecaccount.text,Brecpayment.text,Brecreason.text,Bbankrecpayment.text,[keychainItem objectForKey:(id)kSecAttrCreator]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        
        
        
        
        if([[validation[0] objectForKey:@"ERROR"] length ] == 0 )
        {
            
           
           
            
            newtransfer.recreason = Brecreason.text;
            newtransfer.recpayment = Brecpayment.text;
            newtransfer.recaccount = Brecaccount.text;
            newtransfer.recbank = Brecbank.text;
            newtransfer.recphone = Brecphone.text ;
            newtransfer.reclastname = Breclastname.text;
            newtransfer.recfirstname = Brecfirstname.text;
            newtransfer.recID = [[validation[0] objectForKey:@"RECID"] intValue];
            newtransfer.ShopAcc = Bbankrecpayment.text;
            newtransfer.senderID = _senders_ID;
            
            ConfirmSenderViewController *dash = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmsender"];
            
            
            [dash setTransfer:newtransfer];
           
            [self.navigationController pushViewController:dash animated:YES];
           
            
        }else{
            
            recerrorTEXT = [validation[0] objectForKey:@"ERROR"];
        }
        
        
        
    }
    
    
    
    
    
}


- (IBAction)deleteb:(id)sender {
    
    
    
    
    
   
        
        NSArray *validation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/deleteb.php?id=%d",_transfer.recID]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        
        
      
        if([[validation[0] objectForKey:@"ERROR"] length ] == 0 )
        {
            
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            
            recerrorTEXT = [validation[0] objectForKey:@"ERROR"];
        }
        
        
        
   
    
    
    
    
}


- (IBAction)transferb:(id)sender {
    
    
    
    
    
    ConfirmSenderViewController *dash = [self.storyboard instantiateViewControllerWithIdentifier:@"confirmsender"];
    [dash setTransfer:_transfer];
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

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
   
    if( pickerView.tag == 0)
    {
          return 1;
        
        
    }
    
    else if( pickerView.tag == 1)
        
    {
          return 1;
        
    }
   
    
      return 1;
    
  
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    
    
    
    if( pickerView.tag == 0)
    {
     return [Bpayrefarray count];
        
        
    }
    
    else if( pickerView.tag == 1)
        
    {
       return [banklist[0] count];
        
    }
   else if(pickerView.tag == 2)
       
   {
        return [payeebanks[0] count];
   
   }
    
    return [reasonarray count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component


{
    
    
    if( pickerView.tag == 0)
    {
         return [Bpayrefarray objectAtIndex:row];
        
        
    }
    
    else if( pickerView.tag == 1)
        
    {
        return [banklist[0] objectAtIndex:row];
        
    }
    else if(pickerView.tag == 2)
    {
        
         return [payeebanks[0] objectAtIndex:row];
        
    }
    
   
     return [reasonarray objectAtIndex:row];
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    
    if( pickerView.tag == 0)
    {
       
        
        Brecpayment.text = [Bpayrefarray objectAtIndex:row];
        
        [Brecpayment resignFirstResponder];

        
        
    }
    
    else if( pickerView.tag == 1)
        
    {
        Brecbank.text = [banklist[0] objectAtIndex:row];
        
        [Brecbank resignFirstResponder];

        
    }
    else if(pickerView.tag == 2)
        
    {
        
        
        
        Bbankrecpayment.text = [payeebanks[0] objectAtIndex:row];
        
        [Bbankrecpayment resignFirstResponder];
        
    }
   else
    {
        
        Brecreason.text = [reasonarray objectAtIndex:row];
        
        [Brecreason resignFirstResponder];
        
        
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
    

     if (indexPath.row == 8 )
        
    {
        
        
        return 50;
        
    }
    else if (indexPath.row == 7)
        
    {
        
        
        return 70;
        
    }
    
    return 50;
    
}



-(void)textFieldDidEndEditing:(UITextField*)textField {
    
    if(textField.tag == 1)
        
        
        
    {
    
       
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        recfirstnameTEXT = t.text;
        
        
    }
    if(textField.tag == 2)
        
        
        
    {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        reclastnameTEXT = t.text;
        
        
    }
    if(textField.tag == 3)
        
        
        
    {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        recphoneTEXT = t.text;
        
        
    }
    if(textField.tag == 5)
        
        
        
    {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        recbankTEXT = t.text;
        
        
    }
    if(textField.tag == 6)
        
        
        
    {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        recaccountTEXT = t.text;
        
        
    }
    if(textField.tag == 9)
        
        
        
    {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        recbankTEXT = t.text;
        
        
    }
    
    
    if(textField.tag == 10)
        
        
        
    {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        recpaymentrefTEXT = t.text;
        
        
    }
    
    if(textField.tag == 11)
        
        
        
    {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        recpayeebankTEXT = t.text;
        
        
    }
    if(textField.tag == 12)
        
        
        
    {
        
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        UITableViewCell* cell = [SignUpBenTable cellForRowAtIndexPath:indexPath];
        
        UITextField* t = (UITextField*)[cell viewWithTag:textField.tag];
        
        recreasonfortransferTEXT = t.text;
        
        
    }
}

@end
