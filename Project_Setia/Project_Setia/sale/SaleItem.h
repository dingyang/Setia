//
//  SaleItem.h
//  Project_Setia
//
//  Created by Ding Yang on 9/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaleItem : NSObject
@property (nonatomic,retain) NSString *customer;
@property (nonatomic,retain) NSString *discount;
@property (nonatomic,retain) NSString *store;
@property (nonatomic,retain) NSString *user;
@property (nonatomic,retain) NSString *purchaseAmount;
@property (nonatomic,retain) NSString *netAmount;
@property (nonatomic,retain) NSString *pointsRedeemed;
@property (nonatomic,retain) NSString *comments;
@end
