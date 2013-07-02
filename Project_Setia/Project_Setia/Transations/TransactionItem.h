//
//  TransactionItem.h
//  Project_Setia
//
//  Created by Ding Yang on 17/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionItem : NSObject
@property (nonatomic,retain) NSString *firstName;
@property (nonatomic,retain) NSString *lastName;
@property (nonatomic,retain) NSString *countryCode;
@property (nonatomic,retain) NSString *phoneNumber;
@property (nonatomic,retain) NSString *grossAmount;
@property (nonatomic,retain) NSString *nettAmount;
@end
