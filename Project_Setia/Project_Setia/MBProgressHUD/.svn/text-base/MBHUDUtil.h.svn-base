//
//  MBHUDUtil.h
//  EMeeting
//
//  Created by AppDev on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define loadStr @"加载中…"
#define reloadStr @"重新加载…"
#define AlterFinishStr @"修改成功"
#define SaveFinishStr @"保存成功"
#define SendFinishStr @"发表成功"
#define AlterFailedStr @"修改失败"
#define SaveFailedStr @"保存失败"
#define SendFailedStr @"发表失败"
#define kNoNetwork @"暂无网络"
#define kRequestTimeout @"网络超时"
typedef void(^ExecutingBlock)(void);

@interface MBHUDUtil : NSObject

+(void)HUDShowMsg:(UIView*)sender msg:(NSString*)msg;
+(void)HUDShowMsg:(UIView*)sender msg:(NSString*)msg yOffset:(float)yoffset;

+(void)HUDLoadShowMsg:(UIViewController*)sender msg:(NSString*)msg sel:(SEL)sel obj:(id)obj;

+(void)HUDLoadShowMsg:(UIViewController*)sender msg:(NSString*)msg block:(ExecutingBlock)block;

@end
