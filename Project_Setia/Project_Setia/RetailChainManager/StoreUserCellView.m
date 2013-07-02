//
//  StoreUserCellView.m
//  Project_Setia
//
//  Created by Ding Yang on 8/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "StoreUserCellView.h"

@implementation StoreUserCellView

@synthesize idTField;
@synthesize codeTField;
@synthesize firstnameTField;
@synthesize lastnameTField;
@synthesize usernameTField;

#define storeCellItemWidth 225.0f
#define storeCellItemHeigth 44.0f
#define storeTitle_idWidth 33.0f
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        idTField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, storeTitle_idWidth, storeCellItemHeigth)];
        idTField.borderStyle = UITextBorderStyleBezel;
        idTField.enabled = NO;
        [self addSubview:idTField];
        [idTField release];
        
        codeTField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        codeTField.borderStyle = UITextBorderStyleBezel;
        codeTField.enabled = NO;
        [self addSubview:codeTField];
        [codeTField release];
        
        firstnameTField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth+1*storeCellItemWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        firstnameTField.borderStyle = UITextBorderStyleBezel;
        firstnameTField.enabled = NO;
        [self addSubview:firstnameTField];
        [firstnameTField release];
        
        lastnameTField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth+2*storeCellItemWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        lastnameTField.borderStyle = UITextBorderStyleBezel;
        lastnameTField.enabled = NO;
        [self addSubview:lastnameTField];
        [lastnameTField release];
        
        usernameTField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth+3*storeCellItemWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        usernameTField.borderStyle = UITextBorderStyleBezel;
        usernameTField.enabled = NO;
        [self addSubview:usernameTField];
        [usernameTField release];
    }
    return self;
}
@end
