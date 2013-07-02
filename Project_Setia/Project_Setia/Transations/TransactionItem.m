//
//  TransactionItem.m
//  Project_Setia
//
//  Created by Ding Yang on 17/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "TransactionItem.h"

@implementation TransactionItem
@synthesize firstName,lastName,countryCode,phoneNumber,grossAmount,nettAmount;
-(void)dealloc{
    self.firstName = nil;
    self.lastName = nil;
    self.countryCode = nil;
    self.phoneNumber = nil;
    self.grossAmount = nil;
    self.nettAmount = nil;
    [super dealloc];
}
@end
