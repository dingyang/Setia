//
//  SuperAdministratorItem.m
//  Project_Setia
//
//  Created by Ding Yang on 3/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "SuperAdministratorItem.h"

@implementation SuperAdministratorItem
@synthesize userId;
@synthesize type;
@synthesize firstname;
@synthesize lastname;
@synthesize code;
@synthesize username;
@synthesize password;
@synthesize repassword;
@synthesize storename;
@synthesize chainname;
@synthesize chainId,storeId,phone1number,phone2number,birthday,email,gender,country,registertime,lastlogintime,promotionType;
-(void)dealloc
{
    self.userId = nil;
    self.type = nil;
    self.firstname = nil;
    self.lastname = nil;
    self.code = nil;
    self.username = nil;
    self.password = nil;
    self.repassword = nil;
    self.storename = nil;
    self.chainname = nil;
    self.chainId = nil;
    self.storeId = nil;
    self.phone2number = nil;
    self.phone1number = nil;
    self.birthday = nil;
    self.email = nil;
    self.gender = nil;
    self.country = nil;
    self.registertime = nil;
    self.lastlogintime = nil;
    self.promotionType = nil;
    [super dealloc];
}
@end
