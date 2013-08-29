//
//  SaleItem.m
//  Project_Setia
//
//  Created by Ding Yang on 9/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "SaleItem.h"

@implementation SaleItem
@synthesize customer,discount,store,user,purchaseAmount,netAmount,pointsRedeemed,comments;
-(void)dealloc{
    self.customer = nil;
    self.discount = nil;
    self.store = nil;
    self.user = nil;
    self.purchaseAmount = nil;
    self.netAmount = nil;
    self.pointsRedeemed = nil;
    self.comments = nil;
    [super dealloc];
}
@end
