//
//  ClerkUserItem.m
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "ClerkUserItem.h"

@implementation ClerkUserItem
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
@synthesize email;
@synthesize phone1;
@synthesize phone2;
-(void)dealloc{
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
    self.email = nil;
    self.phone2 = nil;
    self.phone1 = nil;
    [super dealloc];
}
@end
