//
//  StoreCellView.m
//  Project_Setia
//
//  Created by Ding Yang on 9/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "StoreCellView.h"

@implementation StoreCellView

@synthesize idTField;
@synthesize countryTField;
@synthesize cityTField;
@synthesize streetNameTField;
@synthesize phone1TField;
@synthesize phone2TField;
@synthesize postalCodeTField;

#define storeCellItemWidth 150.0f
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
        
        countryTField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        countryTField.borderStyle = UITextBorderStyleBezel;
        countryTField.enabled = NO;
        [self addSubview:countryTField];
        [countryTField release];
        
        cityTField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth+1*storeCellItemWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        cityTField.borderStyle = UITextBorderStyleBezel;
        cityTField.enabled = NO;
        [self addSubview:cityTField];
        [cityTField release];
        
        streetNameTField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth+2*storeCellItemWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        streetNameTField.borderStyle = UITextBorderStyleBezel;
        streetNameTField.enabled = NO;
        [self addSubview:streetNameTField];
        [streetNameTField release];
        
        postalCodeTField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth+3*storeCellItemWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        postalCodeTField.borderStyle = UITextBorderStyleBezel;
        postalCodeTField.enabled = NO;
        [self addSubview:postalCodeTField];
        [postalCodeTField release];
        
        phone1TField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth+4*storeCellItemWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        phone1TField.borderStyle = UITextBorderStyleBezel;
        phone1TField.enabled = NO;
        [self addSubview:phone1TField];
        [phone1TField release];
        
        phone2TField = [[UITextField alloc]initWithFrame:CGRectMake(storeTitle_idWidth+5*storeCellItemWidth, 0, storeCellItemWidth, storeCellItemHeigth)];
        phone2TField.borderStyle = UITextBorderStyleBezel;
        phone2TField.enabled = NO;
        [self addSubview:phone2TField];
        [phone2TField release];
        
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
