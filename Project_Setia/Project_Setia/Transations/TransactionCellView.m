//
//  TransactionCellView.m
//  Project_Setia
//
//  Created by Ding Yang on 16/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "TransactionCellView.h"

@implementation TransactionCellView

@synthesize nameTField,phoneTField,grossAmountTField,nettAmountTField;

#define transactionCellItemHeigth 44.0f
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        nameTField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 130, transactionCellItemHeigth)];
        nameTField.borderStyle = UITextBorderStyleBezel;
        nameTField.enabled = NO;
        [self addSubview:nameTField];
        [nameTField release];
        
        phoneTField = [[UITextField alloc]initWithFrame:CGRectMake(130, 0, 150, transactionCellItemHeigth)];
        phoneTField.borderStyle = UITextBorderStyleBezel;
        phoneTField.enabled = NO;
        [self addSubview:phoneTField];
        [phoneTField release];
        
        grossAmountTField = [[UITextField alloc]initWithFrame:CGRectMake(280, 0, 85, transactionCellItemHeigth)];
        grossAmountTField.borderStyle = UITextBorderStyleBezel;
        grossAmountTField.enabled = NO;
        [self addSubview:grossAmountTField];
        [grossAmountTField release];
        
        nettAmountTField = [[UITextField alloc]initWithFrame:CGRectMake(365, 0, 85, transactionCellItemHeigth)];
        nettAmountTField.borderStyle = UITextBorderStyleBezel;
        nettAmountTField.enabled = NO;
        [self addSubview:nettAmountTField];
        [nettAmountTField release];
        
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
