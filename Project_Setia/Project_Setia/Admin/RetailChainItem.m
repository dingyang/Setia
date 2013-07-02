//
//  RetailChainItem.m
//  Project_Setia
//
//  Created by Ding Yang on 6/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "RetailChainItem.h"

@implementation RetailChainItem
@synthesize rc_id;
@synthesize rc_name;
@synthesize rc_description;
@synthesize rc_email;
@synthesize rc_phone1;
@synthesize rc_phone2;
@synthesize rc_url;
@synthesize rc_buildingName;
@synthesize rc_city;
@synthesize rc_country;
@synthesize rc_discount;
@synthesize rc_landmark;
@synthesize rc_postalCode;
@synthesize rc_streetName;
@synthesize rc_unitNumber;
-(void)dealloc
{
    self.rc_id = nil;
    self.rc_description = nil;
    self.rc_email = nil;
    self.rc_phone1 = nil;
    self.rc_phone2 = nil;
    self.rc_url = nil;
    self.rc_unitNumber = nil;
    self.rc_streetName = nil;
    self.rc_postalCode = nil;
    self.rc_country = nil;
    self.rc_city = nil;
    self.rc_buildingName = nil;
    self.rc_landmark = nil;
    self.rc_buildingName = nil;
    self.rc_discount = nil;
    [super dealloc];
}
@end
