//
//  HomePageViewController.m
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
#import "DashboardViewController.h"


@interface HomePageViewController ()

@end

@implementation HomePageViewController




UIScrollView *mainscroll;
UIPageControl *HomePagePageControl;
UIScrollView *features;




KeychainItemWrapper *keychainItem1;

- (void)viewDidLoad {
    
   [super viewDidLoad];
    
    
    
    
    keychainItem1 = [[KeychainItemWrapper alloc] initWithIdentifier:@"jmtransfers" accessGroup:nil];
    
    [keychainItem1 setObject: @"" forKey:(__bridge id)(kSecAttrCreator)];
    
    [keychainItem1 setObject: @"" forKey:(__bridge id)(kSecAttrService)];
    
    [keychainItem1 setObject: @"" forKey:(__bridge id)(kSecAttrDescription)];
    
    
    UIButton *logoView = [[UIButton alloc] initWithFrame:CGRectMake(0,0,66,66)];
    
    [logoView setImage:[UIImage imageNamed:@"jmtrax"] forState:UIControlStateNormal];
    
    
    
    [logoView setUserInteractionEnabled:NO];
    
    self.navigationItem.titleView = logoView;
    
 
    self.navigationItem.hidesBackButton = YES;
    
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

    
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0,self.navigationController.navigationBar.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height/3)];
    
   [self.view addSubview:topview];
    
    
     NSArray *HomePageFeatures = [NSArray arrayWithObjects:@"USA_Street_Chicago",nil];
    
    features = [[UIScrollView alloc] init];
    
    features.frame = CGRectMake(0,0,topview.frame.size.width,topview.frame.size.height-80);
    
    
    for (int i = 0; i < [HomePageFeatures count]; i++) {
        
        
        CGRect frame;
        
        frame.origin.x = features.frame.size.width * i;
        
        frame.origin.y = 0;
        
        frame.size =  features.frame.size;
        
        UIImageView *feature = [[UIImageView alloc] initWithFrame:CGRectMake((features.frame.size.width * i)+10,10,features.frame.size.width-20,features.frame.size.height-10)];
        
        feature.image = [UIImage imageNamed:[HomePageFeatures objectAtIndex:i]];
                
        
        [ features addSubview:feature];
        
        
        
    }
    
    HomePagePageControl = [[UIPageControl alloc] init];
    
    HomePagePageControl.frame = CGRectMake(0,topview.frame.size.height-80,topview.frame.size.width,topview.frame.size.height/4);
    
    [HomePagePageControl setTintColor:[UIColor blackColor]];
    
    [HomePagePageControl setCurrentPageIndicatorTintColor:myColor];
    
    HomePagePageControl.numberOfPages = [HomePageFeatures count];
    
    HomePagePageControl.currentPage = 0;
    
    [topview addSubview:HomePagePageControl];
    
    
    features.contentSize = CGSizeMake( features.frame.size.width * [HomePageFeatures count],features.frame.size.height);
    
    [features setShowsHorizontalScrollIndicator:NO];
    
    [features setShowsVerticalScrollIndicator:NO];
    
    [features setPagingEnabled:YES];
    
    features.delegate =self;
    
    [topview  addSubview:features];
    

    
    
    

    

    
    UITableView *SignUpTable;
    
    SignUpTable = [[UITableView alloc] initWithFrame:CGRectMake(0,topview.frame.size.height,self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStylePlain];
    
    //SignUpTable. .contentInset = UIEdgeInsetsMake(20,0,20, 0);
    
    
     SignUpTable.delegate = self;
    
    [SignUpTable registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"StaticCell"];
    
    [SignUpTable registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"StaticCell"];
    
    SignUpTable.dataSource = self;
    
    SignUpTable.bounces = NO;
    
    SignUpTable.scrollEnabled = YES;
    
    //SignUpTable.clipsToBounds = YES;
    
    
    [self.view  addSubview:SignUpTable];
    
   
    //SignUpTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    SignUpTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(SignUpTable.frame.size.height+self.navigationController.navigationBar.frame.size.height,self.view.frame.size.height,self.view.bounds.size.width,self.navigationController.navigationBar.frame.size.height)];
    
    
   
    
    SignUpTable.tableFooterView = footer;
    

    
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    
    CGFloat pageWidth = features.frame.size.width;
    
    int page = floor((features.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    HomePagePageControl.currentPage = page;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 1)
        
    {
        
        
        return 5;
        
    }
    
    
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    if(indexPath.section == 0)
    {
        
    UIButton *cell8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    cell8.frame = CGRectMake(10,10,cell.frame.size.width - 20 ,cell.frame.size.height - 10);
    
    [cell8 setTitle:@"LOG IN / REGISTER" forState:UIControlStateNormal];
    
    [cell8 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIColor *myColor = [UIColor colorWithRed:96.0f/255.0f green:147.0f/255.0f blue:197.0f/255.0f alpha:1.0f];
        
    [cell8 setBackgroundColor:myColor];
  
        
    [cell8 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        

    [cell8 addTarget:self action:@selector(gotosignup:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.contentView addSubview:cell8];
    
      
                
                return cell;
        
      
    
    }
    
    else if(indexPath.section == 1)
    {
        
         NSString *cellIdentifier = @"StaticCell";
        
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



@end
