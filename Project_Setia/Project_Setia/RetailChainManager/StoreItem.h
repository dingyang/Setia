//
//  StoreItem.h
//  Project_Setia
//
//  Created by Ding Yang on 9/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreItem : NSObject
@property (nonatomic,retain) NSString *st_id;
@property (nonatomic,retain) NSString *st_name;
@property (nonatomic,retain) NSString *st_description;
@property (nonatomic,retain) NSString *st_email;
@property (nonatomic,retain) NSString *st_phone1;
@property (nonatomic,retain) NSString *st_phone2;
@property (nonatomic,retain) NSString *st_url;
@property (nonatomic,retain) NSString *st_discount;
@property (nonatomic,retain) NSString *st_buildingName;
@property (nonatomic,retain) NSString *st_unitNumber;
@property (nonatomic,retain) NSString *st_streetName;
@property (nonatomic,retain) NSString *st_landmark;
@property (nonatomic,retain) NSString *st_postalCode;
@property (nonatomic,retain) NSString *st_country;
@property (nonatomic,retain) NSString *st_city;

@end
