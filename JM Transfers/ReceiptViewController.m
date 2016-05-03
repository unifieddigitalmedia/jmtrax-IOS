//
//  ReceiptViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "ReceiptViewController.h"
#import "DashboardViewController.h"
#import "KeychainItemWrapper.h"
#import "URLRequests.h"
#import "HomeAccountViewController.h"
#import "HomeTransferCalculatorViewController.h"
#import "HomeHelpViewController.h"
#import "HomePageViewController.h"
@interface ReceiptViewController ()

@end

@implementation ReceiptViewController

NSString *currentDate;
UITextView *pcalheading;
UITableView *SignUpTableRec;
NSArray *bnkacc;

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
    
    
    
    
    SignUpTableRec = [[UITableView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    //SignUpTable. .contentInset = UIEdgeInsetsMake(20,0,20, 0);
    
    
    SignUpTableRec.delegate = self;
    
    SignUpTableRec.dataSource = self;
    
    SignUpTableRec.bounces = NO;
    
    SignUpTableRec.scrollEnabled = YES;
    
    SignUpTableRec.clipsToBounds = YES;
    
    SignUpTableRec.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    SignUpTableRec.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SignUpTableRec.allowsSelection = NO;
    
    SignUpTableRec.estimatedRowHeight = 44.0;
    
    SignUpTableRec.rowHeight = UITableViewAutomaticDimension;
    
    
    [SignUpTableRec registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"StaticCell"];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpTableRec.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
    
    SignUpTableRec.tableFooterView = footer;

     [self.view  addSubview:SignUpTableRec];
    
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss"];
    
    currentDate = [dateFormatter stringFromDate:[NSDate date]];
    
 
     bnkacc = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://www.jmtrax.net/app_php_files/getsortcode.php?shopacc=%@",_transfer.ShopAcc]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
   }

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [SignUpTableRec reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)
        
    {
        
        
        return 5;
        
    }
    
    
    return 36;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    static NSString *cellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if(cell == nil)
        
    {
        
        
    }

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    if(indexPath.section == 0)
        
    {

        switch (indexPath.row) {
                
            case 0:
            {
                
                
                UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [tcalheading setText:@"YOUR ALMOST FINISHED"];
                
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
                
                cell.textLabel.text = @"To complete the transaction please follow the steps below";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                cell.textLabel.numberOfLines = 0;
                
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
                
                cell.textLabel.font = cellFont;
                
                return cell;
                
                 break;
                
            }
            case 2:
                
            {
                
                
                cell.textLabel.text = @"Complete the transaction within the next 14 days or it will be cancelled";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                cell.textLabel.numberOfLines = 0;
                
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
                
                cell.textLabel.font = cellFont;
                
                
                
                
                
                return cell;
                
                 break;
                
                
                
            }
            case 3:
                
            {
                
                UITextView *tcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [tcalheading setText:@"YOUR RECEIPT"];
                
                [tcalheading setEditable:false];
                
                [tcalheading setTextAlignment:NSTextAlignmentLeft];
                
                UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
                
                [tcalheading setTextColor:myColor];
                
                tcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
                
                [cell.contentView addSubview:tcalheading];
                
                
                
                
                
                return cell;
                
                 break;
            }
            case 4:
                
            {
                
                pcalheading = [[UITextView alloc] initWithFrame:CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10)];
                
                [pcalheading setText:@"Payment instructions"];
                
                [pcalheading setEditable:false];
                
                [pcalheading setTextAlignment:NSTextAlignmentLeft];
                
                UIColor *myColor = [UIColor colorWithRed:166.0f/255.0f green:166.0f/255.0f blue:166.0f/255.0f alpha:1.0f];
                
                [pcalheading setTextColor:myColor];
                
                pcalheading.font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
                
                [cell.contentView addSubview:pcalheading];
                
                
                
                
                
                return cell;
                
                 break;
                
            }
                
            case 5:
            {
                
                
                cell.textLabel.text = @"1. Log into your bank account";
                
                 cell.textLabel.numberOfLines = 0;
                
                
                return cell;
                
                
                break;
                
                
            }
            case 6:
            {
                
                
                
                cell.textLabel.text = @"2. Transfer the total amount due to your bank account";
                
                
            
                cell.textLabel.numberOfLines = 0;
                
                
                return cell;
                
                
                break;
                
                
            }
            case 7:
            {
                
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Amount";
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                
                CGBPLABEL.text = _transfer.GBP;
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 8:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Beneficiary name";
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                CGBPLABEL.text = [NSString stringWithFormat:@"%@ %@ ",_transfer.recfirstname,_transfer.reclastname];
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 9:
            {
                
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Sort Code";
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                CGBPLABEL.text =  [bnkacc[0] objectForKey:@"sortcode"];
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 10:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Account number";
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                CGBPLABEL.text =  [bnkacc[0] objectForKey:@"account"];
                
                cell.accessoryView = CGBPLABEL;
                
                
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 11:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Payment Reference";
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                CGBPLABEL.text =  [bnkacc[0] objectForKey:@"ref"];
                
                cell.accessoryView = CGBPLABEL;
                
                
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                
                return cell;
                
                break;
                
                
            }
                
            case 12:
            {
                
                
                cell.textLabel.text = @"3.Your money will be avaible after we receive your payment";
                
                
                cell.textLabel.numberOfLines = 0;
                
                
                return cell;
                
                break;
                
                
            }
            case 13:
            {
                
                
                
                cell.textLabel.text = @"TRANSACTION DETAILS" ;
                
                
                
                return cell;
                
                break;
                
                
            }
            case 14:
            {
                
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Sender";
                
                CGBPLABEL.text = _transfer.senderfirstname;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 15:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Address";
                
                
                CGBPLABEL.text = _transfer.senderfirst;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 16:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"City";
                
                
                CGBPLABEL.text = _transfer.sendertown;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 17:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Postal Code";
                
                
                CGBPLABEL.text = _transfer.senderpostcode;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 18:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Country";
                
                CGBPLABEL.text = _transfer.sendercountry;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 19:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Purpose of transactions";
                
                
                CGBPLABEL.text = _transfer.recreason;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 20:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Deleivery Method";
                
                CGBPLABEL.text = _transfer.payment_method;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 21:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Money Will Be Available";
                
                CGBPLABEL.text = @"1 - 2 business days ";
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }case 22:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Transaction Date";
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                
                
                cell.accessoryView = CGBPLABEL;
                
                
                CGBPLABEL.text = currentDate;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 23:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Payment Method";
                
                CGBPLABEL.text = _transfer.payment_method;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 24:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Transfer Amount";
                
                
                CGBPLABEL.text = _transfer.GBP;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 25:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Transfer Fee";
                
                CGBPLABEL.text = _transfer.FEE;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 26:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Total";
                
                
                CGBPLABEL.text = _transfer.TOTAL;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 27:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Total To Receiver";
                
                
                
                CGBPLABEL.text = _transfer.NGN;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 28:
            {
                
                
                UITextView * CGBPLABEL = [[UITextView alloc] initWithFrame:CGRectMake(
                                                                                      cell.textLabel.frame.size.width, 0, 100,cell.frame.size.height)];
                
                cell.textLabel.text = @"Exchange Rate";
                
                
                CGBPLABEL.text = _transfer.RATE;
                
                [CGBPLABEL setTextAlignment:NSTextAlignmentRight];
                
                cell.accessoryView = CGBPLABEL;
                
                [cell.accessoryView setFrame:CGRectMake(cell.textLabel.frame.size.width, 0,100, cell.frame.size.height)];
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 29:
            {
                
                
                
                cell.textLabel.text = @"Contact Us";
                
                
                
                return cell;
                
                break;
                
                
            }
            case 30:
            {
                
                cell.textLabel.text = @"82 High St London SE25 6EA 020 8771 5353";
                
                cell.textLabel.numberOfLines = 0;
                
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
                
                cell.textLabel.font = cellFont;
                
                
                
                return cell;
                
                break;
                
                
            }
            case 31:
            {
                
                
                
                
                cell.textLabel.text = @"1 FX gains apply may be different to a transaction already paid if the receiver chooses to pick up funds in a curency other than the one choosen by the sender";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                cell.textLabel.numberOfLines = 0;
                
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
                
                cell.textLabel.font = cellFont;
                
                
                
                return cell;
                
                break;
                
                
            }
            case 32:
            {
                
                
                cell.textLabel.text = @"2 Funds availble subject to terms and conditions of the service.Additional restrictions may apply. See online terms for details.";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                cell.textLabel.numberOfLines = 0;
                
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
                
                cell.textLabel.font = cellFont;
                
                
                
                return cell;
                
                break;
                
                
            }
            case 33:
            {
                
                
                
                
                cell.textLabel.text =@"3 Please note if the name in your JM Transfers profile and the name used on your bank account don't match, we'll reget this transaction. You'll get a refund within several business days";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                cell.textLabel.numberOfLines = 0;
                
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
                
                cell.textLabel.font = cellFont;
                
                
               
                
                return cell;
                
                break;
                
                
            }
            case 34:
            {
                
                
                cell.textLabel.text = @"4 FX rates apply";
                
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                
                cell.textLabel.numberOfLines = 0;
                
                UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:12.0];
                
                cell.textLabel.font = cellFont;
                
                
                
                
                
                
                
                
                return cell;
                
                break;
                
                
            }
            case 35:
            {
                
                
                
                UIButton *tcalheading = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                tcalheading.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
                
                [tcalheading setTitle:@"SEND NEW TRANSACTIONS" forState:UIControlStateNormal];
                
                [tcalheading setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
                
                [tcalheading setBackgroundColor:myColor];
                
                [tcalheading addTarget:self action:@selector(confirmT:) forControlEvents:UIControlEventTouchUpInside];
                
                [tcalheading setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
                
                [cell.contentView addSubview:tcalheading];
                
                
                return  cell;
                
                break;
                
                
            }
                

        }
        
    }
    
    else
        
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
 
    

    
    
   
  
                
                return cell;
    
}


- (IBAction)confirmT:(id)sender {
    
    
    
    NSArray *validation = [[URLRequests alloc] makeurlrequest:[[NSString stringWithFormat:@"http://jmtrax.net/app_php_files/transfer.php?amount=%@&recID=%d&senderID=%d&uksms=%@&nigeriasms=%@&pay=%@&currentDateTimeString=%@",_transfer.GBP,_transfer.recID,_transfer.senderID,_transfer.uksms,_transfer.ngnsms,_transfer.payment_method,currentDate] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
   
    
    if([[validation[0] objectForKey:@"ERROR"] length ] == 0)
        
    {
        
        
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"jmtransfers" accessGroup:nil];
        
       [keychainItem setObject: [validation[0] objectForKey:@"BALANCE"]  forKey:(__bridge id)(kSecAttrService)];
        
        DashboardViewController *account = [self.storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
        [self.navigationController pushViewController:account animated:YES];
        
    }
    else
    {
        
       
        pcalheading.text = [validation[0] objectForKey:@"ERROR"] ;

        
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



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 29 || indexPath.row == 30 || indexPath.row == 31 || indexPath.row == 32 || indexPath.row == 6 || indexPath.row == 11) {
        
        
       
        return 80;
        
    }
    else if (indexPath.row == 1 || indexPath.row == 2 )
        
    {
        
        
         return 30;
        
    }
   
    return 44;

}


@end
