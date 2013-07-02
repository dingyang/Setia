//
//  MBHUDUtil.m
//  EMeeting
//
//  Created by AppDev on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MBHUDUtil.h"

@implementation MBHUDUtil

+(void)HUDShowMsg:(UIView*)sender msg:(NSString*)msg{
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:sender animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = msg;
	hud.margin = 10.f;
	hud.yOffset = 100.f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:1.5];
    
}
+(void)HUDShowMsg:(UIView*)sender msg:(NSString*)msg yOffset:(float)yoffset{
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:sender animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = msg;
	hud.margin = 10.f;
	hud.yOffset =yoffset;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:1.5];
    
}

+(void)HUDLoadShowMsg:(UIViewController*)sender msg:(NSString*)msg sel:(SEL)sel obj:(id)obj{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:sender.view];
    [sender.view addSubview:HUD];
    
    HUD.delegate = (id)sender;
    HUD.labelText = msg;
    
    [HUD showWhileExecuting:sel onTarget:(id)sender withObject:obj animated:YES];
    //[HUD removeFromSuperview];
    [HUD release];
}

+(void)HUDLoadShowMsg:(UIViewController*)sender msg:(NSString*)msg block:(ExecutingBlock)block{
    
#if NS_BLOCKS_AVAILABLE
	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:sender.view];
	[sender.view addSubview:hud];
	hud.labelText = msg;
	
	[hud showAnimated:YES whileExecutingBlock:block completionBlock:^{
		[hud removeFromSuperview];
		[hud release];
	}];
#endif

}

@end
