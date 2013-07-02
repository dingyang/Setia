//
//  StoreItem.m
//  Project_Setia
//
//  Created by Ding Yang on 9/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "StoreItem.h"

@implementation StoreItem
@synthesize st_id;
@synthesize st_name;
@synthesize st_description;
@synthesize st_email;
@synthesize st_phone1;
@synthesize st_phone2;
@synthesize st_url;
@synthesize st_buildingName;
@synthesize st_city;
@synthesize st_country;
@synthesize st_discount;
@synthesize st_landmark;
@synthesize st_postalCode;
@synthesize st_streetName;
@synthesize st_unitNumber;
-(void)dealloc
{
    self.st_id = nil;
    self.st_description = nil;
    self.st_email = nil;
    self.st_phone1 = nil;
    self.st_phone2 = nil;
    self.st_url = nil;
    self.st_unitNumber = nil;
    self.st_streetName = nil;
    self.st_postalCode = nil;
    self.st_country = nil;
    self.st_city = nil;
    self.st_buildingName = nil;
    self.st_landmark = nil;
    self.st_buildingName = nil;
    self.st_discount = nil;
    [super dealloc];
}

@end
