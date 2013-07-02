//
//  RetailChainCellView.m
//  Project_Setia
//
//  Created by Ding Yang on 8/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "RetailChainCellView.h"

@implementation RetailChainCellView
@synthesize idTField;
@synthesize retailNameTField;
@synthesize descriptionTField;
@synthesize emailTField;
@synthesize phone1TField;
@synthesize phone2TField;
@synthesize urlTField;

#define retailChainCellItemWidth 150.0f
#define retailChainCellItemHeigth 44.0f
#define retailChainTitle_idWidth 33.0f
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        idTField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, retailChainTitle_idWidth, retailChainCellItemHeigth)];
        idTField.borderStyle = UITextBorderStyleBezel;
        idTField.enabled = NO;
        [self addSubview:idTField];
        [idTField release];
        
        retailNameTField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        retailNameTField.borderStyle = UITextBorderStyleBezel;
        retailNameTField.enabled = NO;
        [self addSubview:retailNameTField];
        [retailNameTField release];
        
        descriptionTField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth+1*retailChainCellItemWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        descriptionTField.borderStyle = UITextBorderStyleBezel;
        descriptionTField.enabled = NO;
        [self addSubview:descriptionTField];
        [descriptionTField release];
        
        emailTField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth+2*retailChainCellItemWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        emailTField.borderStyle = UITextBorderStyleBezel;
        emailTField.enabled = NO;
        [self addSubview:emailTField];
        [emailTField release];
        
        phone1TField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth+3*retailChainCellItemWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        phone1TField.borderStyle = UITextBorderStyleBezel;
        phone1TField.enabled = NO;
        [self addSubview:phone1TField];
        [phone1TField release];
        
        phone2TField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth+4*retailChainCellItemWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        phone2TField.borderStyle = UITextBorderStyleBezel;
        phone2TField.enabled = NO;
        [self addSubview:phone2TField];
        [phone2TField release];
        
        urlTField = [[UITextField alloc]initWithFrame:CGRectMake(retailChainTitle_idWidth+5*retailChainCellItemWidth, 0, retailChainCellItemWidth, retailChainCellItemHeigth)];
        urlTField.borderStyle = UITextBorderStyleBezel;
        urlTField.enabled = NO;
        [self addSubview:urlTField];
        [urlTField release];
        
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
