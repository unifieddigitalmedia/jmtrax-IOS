//
//  URLRequests.m
//  JM Transfers
//
//  Created by Machel Slack on 29/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import "URLRequests.h"

@implementation URLRequests 


- (NSArray *)makeurlrequest:(NSString*)filename;


{
    
    
        NSError *error = nil;
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:filename]];
        
        [request setHTTPMethod:@"POST"];
    
    
    /*  NSURLSession *session = [NSURLSession sharedSession];
    
     [[session dataTaskWithURL:[NSURL URLWithString:filename]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSError *jsonError = nil;
                _returnedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                if (jsonError) {
                    NSLog(@"error is %@", [jsonError localizedDescription]);
                    // Handle Error and return
                    return;
                }
        
       NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        _returnedData = [NSJSONSerialization JSONObjectWithData:returnData
                                                        options:kNilOptions
                                                          error:&error];
        
        
         }] resume];
        */
    
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(returnData == nil)
        
    {
        
        
        
    }
    else
    {
    
    _returnedData = [NSJSONSerialization JSONObjectWithData:returnData
                                                    options:kNilOptions
                                                      error:&error];
    
    }
    
        return _returnedData;

   
    
    
    
    
}



@end
