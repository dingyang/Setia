//
//  PostReturnValue.m
//  Project_Setia
//
//  Created by Ding Yang on 4/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "PostReturnValue.h"

@implementation PostReturnValue
@synthesize returnValue;
-(void)dealloc
{
    self.returnValue = nil;
    [super dealloc];
}
@end
