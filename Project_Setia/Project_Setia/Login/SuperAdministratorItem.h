//
//  SuperAdministratorItem.h
//  Project_Setia
//
//  Created by Ding Yang on 3/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperAdministratorItem : NSObject
@property (nonatomic,retain) NSString *userId;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *firstname;
@property (nonatomic,retain) NSString *lastname;
@property (nonatomic,retain) NSString *code;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *repassword;
@property (nonatomic,retain) NSString *storename;
@property (nonatomic,retain) NSString *chainname;

@property (nonatomic,retain) NSString *chainId;
@property (nonatomic,retain) NSString *storeId;
@property (nonatomic,retain) NSString *phone1number;
@property (nonatomic,retain) NSString *phone2number;
@property (nonatomic,retain) NSString *birthday;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *gender;
@property (nonatomic,retain) NSString *country;
@property (nonatomic,retain) NSString *registertime;
@property (nonatomic,retain) NSString *lastlogintime;
@end
