//
//  Transfer.h
//  JM Transfers
//
//  Created by Machel Slack on 29/11/2015.
//  Copyright © 2015 Just Computers Parts. All rights reserved.
//
#import "HomePageBackgroundView.h"

#import <Foundation/Foundation.h>

@interface Transfer : NSObject




@property (nonatomic, strong) NSString *ShopAcc;
@property (nonatomic, strong) NSString *recreason;
@property (nonatomic, strong) NSString *recpayment;
@property (nonatomic, strong) NSString *recaccount;
@property (nonatomic, strong) NSString *recbank;
@property (nonatomic, strong) NSString *recphone;
@property (nonatomic, strong) NSString *reclastname;
@property (nonatomic, strong) NSString *recfirstname;
@property (nonatomic, strong) NSString *sendercountry;

@property (nonatomic, strong) NSString *sendertown;

@property (nonatomic, strong) NSString *senderfirst;

@property (nonatomic, strong) NSString *senderpostcode;

@property (nonatomic, strong) NSString *senderemail;

@property (nonatomic, strong) NSString *senderphone;

@property (nonatomic, strong) NSString *senderlastname;

@property (nonatomic, strong) NSString *senderfirstname;


@property (nonatomic, strong) NSString *GBP;

@property (nonatomic, strong) NSString *FEE;

@property (nonatomic, strong) NSString *NGN;

@property (nonatomic, strong) NSString *TOTAL;

@property (nonatomic, strong) NSString *RATE;

@property (nonatomic, assign) int recID;

@property (nonatomic, assign) int senderID;

@property (nonatomic, strong) NSString *uksms;

@property (nonatomic, strong) NSString *ngnsms;

@property (nonatomic, strong) NSString *payment_method;

@end
