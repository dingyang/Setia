//
//  CustomerItem.m
//  Project_Setia
//
//  Created by Ding Yang on 7/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "CustomerItem.h"

@implementation CustomerItem
@synthesize cus_BalancePoints;
@synthesize cus_BuildingName;
@synthesize cus_City;
@synthesize cus_Country;
@synthesize cus_CountryCode;
@synthesize cus_Date;
@synthesize cus_Email;
@synthesize cus_Firstname;
@synthesize cus_Gender;
@synthesize cus_JoinedStore;
@synthesize cus_Landmark;
@synthesize cus_Lastname;
@synthesize cus_LoginId;
@synthesize cus_NRIC;
@synthesize cus_Password;
@synthesize cus_PhoneNumber;
@synthesize cus_PostalCode;
@synthesize cus_RetailChains;
@synthesize cus_StreetName;
@synthesize cus_UnitNumber;
@synthesize cus_Discount;

-(void)dealloc{
    self.cus_UnitNumber = nil;
    self.cus_StreetName = nil;
    self.cus_RetailChains = nil;
    self.cus_PostalCode = nil;
    self.cus_PhoneNumber = nil;
    self.cus_Password = nil;
    self.cus_NRIC = nil;
    self.cus_LoginId = nil;
    self.cus_Lastname = nil;
    self.cus_Landmark = nil;
    self.cus_JoinedStore = nil;
    self.cus_Gender = nil;
    self.cus_Firstname = nil;
    self.cus_Email = nil;
    self.cus_Date = nil;
    self.cus_CountryCode = nil;
    self.cus_Country = nil;
    self.cus_City = nil;
    self.cus_BuildingName = nil;
    self.cus_BalancePoints = nil;
    self.cus_Discount = nil;
    [super dealloc];
}

@end
