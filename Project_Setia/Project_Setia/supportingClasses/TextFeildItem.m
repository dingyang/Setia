//
//  TextFeildItem.m
//  Project_Setia
//
//  Created by Ding Yang on 21/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "TextFeildItem.h"

@implementation TextFeildItem
@synthesize tfContent;
-(void)dealloc{
    self.tfContent = nil;
    [super dealloc];
}
@end
