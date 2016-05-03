//
//  ViewController.m
//  JM Transfers
//
//  Created by Machel Slack on 26/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"
#import "KeychainItemWrapper.h"
#import "ViewController.h"
#import "HomePageViewController.h"
#import "HomePageBackgroundView.h"
@interface ViewController ()

@end

@implementation ViewController


UIImageView *imageView;


- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
    
    UIView *viewWithSpinner = [[UIView alloc] initWithFrame:CGRectMake(110, 106, 100, 100)];
    
    [viewWithSpinner.layer setCornerRadius:15.0f];
    
  
    [viewWithSpinner setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0,100,100)];

    
  //  UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
   
    
    viewWithSpinner.center = self.view.center;
    
    //spinner.center = viewWithSpinner.center;
    
     UIColor *myColor = [UIColor colorWithRed:0.0f/255.0f green:127.0f/255.0f blue:18.0f/255.0f alpha:1.0f];
    
    //WithFrame:CGRectMake(135,140,50,50)
    
    
    spinner.color = myColor;
    
    [viewWithSpinner addSubview:spinner];
    
    [self.view addSubview:viewWithSpinner];
    
    [spinner startAnimating];
    
    
   // [self.view addSubview:spinner];
    
    double delayInSeconds = 3.0;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // lots of code run in the background
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // stop and remove the spinner on the main thread when done
                [spinner removeFromSuperview];
                
                 [self performSegueWithIdentifier:@"gotohome" sender:self];
            });
        });

       
    
    });
    
    
   
}


- (IBAction)start:(id)sender {
    
    
    
    HomePageViewController *help = [self.storyboard instantiateViewControllerWithIdentifier:@"homecontroller"];
    
    [self.navigationController pushViewController:help animated:YES];
    
    
    
}



- (void)viewDidLoad {
   [super viewDidLoad];
    
    
   
    
    UIImage *yourImage = [UIImage imageNamed:@"logocopy.png"];
    
    
    imageView = [[UIImageView alloc] initWithImage:yourImage];
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotpassword:)];
    
    [imageView setUserInteractionEnabled:YES];
    
    [imageView addGestureRecognizer:gestureRecognizer];
    
    
    [self.view addSubview:imageView];
   
    
    CGSize superviewSize = imageView.superview.frame.size;
    
    imageView.center = CGPointMake((superviewSize.width / 2), (superviewSize.height / 2));
    
    
 
    HomePageBackgroundView *gradientLayer = [HomePageBackgroundView new];
    
    gradientLayer.frame = self.view.bounds;
    
    [self.view.layer addSublayer:gradientLayer];
    
    
}



- (IBAction)forgotpassword:(id)sender {
    
    
    
    HomePageViewController *help = [self.storyboard instantiateViewControllerWithIdentifier:@"homecontroller"];
    
    [self.navigationController pushViewController:help animated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
