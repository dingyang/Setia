//
//  CustomerCellView.m
//  Project_Setia
//
//  Created by Ding Yang on 8/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "CustomerCellView.h"

@implementation CustomerCellView

@synthesize nricTField;
@synthesize firstNameTField;
@synthesize lastnameTField;
@synthesize emailTField;
@synthesize phone1TField;
@synthesize phone2TField;
@synthesize LoginIdTField;

#define customerCellItemWidth 155.5f
#define customerCellItemHeigth 44.0f
#define customerCellItemModifiedWidth 30.0f
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        nricTField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, customerCellItemWidth, customerCellItemHeigth)];
//        nricTField.borderStyle = UITextBorderStyleBezel;
//        nricTField.enabled = NO;
//        [self addSubview:nricTField];
//        [nricTField release];
        
        firstNameTField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, customerCellItemWidth-customerCellItemModifiedWidth, customerCellItemHeigth)];
        firstNameTField.borderStyle = UITextBorderStyleBezel;
        firstNameTField.enabled = NO;
        [self addSubview:firstNameTField];
        [firstNameTField release];
        
        lastnameTField = [[UITextField alloc]initWithFrame:CGRectMake(1*customerCellItemWidth-customerCellItemModifiedWidth, 0, customerCellItemWidth-customerCellItemModifiedWidth, customerCellItemHeigth)];
        lastnameTField.borderStyle = UITextBorderStyleBezel;
        lastnameTField.enabled = NO;
        [self addSubview:lastnameTField];
        [lastnameTField release];
        
        emailTField = [[UITextField alloc]initWithFrame:CGRectMake(2*customerCellItemWidth-2*customerCellItemModifiedWidth, 0, customerCellItemWidth+2*customerCellItemModifiedWidth, customerCellItemHeigth)];
        emailTField.borderStyle = UITextBorderStyleBezel;
        emailTField.enabled = NO;
        [self addSubview:emailTField];
        [emailTField release];
        
        phone1TField = [[UITextField alloc]initWithFrame:CGRectMake(3*customerCellItemWidth, 0, customerCellItemWidth, customerCellItemHeigth)];
        phone1TField.borderStyle = UITextBorderStyleBezel;
        phone1TField.enabled = NO;
        [self addSubview:phone1TField];
        [phone1TField release];
        
        phone2TField = [[UITextField alloc]initWithFrame:CGRectMake(4*customerCellItemWidth, 0, customerCellItemWidth, customerCellItemHeigth)];
        phone2TField.borderStyle = UITextBorderStyleBezel;
        phone2TField.enabled = NO;
        [self addSubview:phone2TField];
        [phone2TField release];
        
        LoginIdTField = [[UITextField alloc]initWithFrame:CGRectMake(5*customerCellItemWidth, 0, customerCellItemWidth, customerCellItemHeigth)];
        LoginIdTField.borderStyle = UITextBorderStyleBezel;
        LoginIdTField.enabled = NO;
        [self addSubview:LoginIdTField];
        [LoginIdTField release];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
