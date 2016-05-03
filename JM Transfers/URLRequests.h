//
//  URLRequests.h
//  JM Transfers
//
//  Created by Machel Slack on 29/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <Foundation/Foundation.h>

@interface URLRequests : NSObject


@property (nonatomic, strong) NSArray *returnedData;


- (NSArray *)makeurlrequest:(NSString*)urlstring;



@end
