//
//  CheckNetWorkIsAvailable.m
//  Project_Setia
//
//  Created by Ding Yang on 3/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "CheckNetWorkIsAvailable.h"

struct in_addr{
    in_addr_t s_addr;
};

struct sockaddr_in{
    __uint8_t sin_len;
    sa_family_t sin_family;
    in_port_t sin_port;
    struct in_addr  sin_addr;
    char        sin_zero[8];
};
@implementation CheckNetWorkIsAvailable

-(BOOL)netWorkIsExistence
{
    struct sockaddr_in initAddress;                             //sockaddr_in是与sockaddr等价的数据结构
    bzero(&initAddress, sizeof(initAddress));
    initAddress.sin_len = sizeof(initAddress);
    initAddress.sin_family = AF_INET;                      //sin_family是地址家族，一般都是“AF_xxx”的形式。通常大多用的是都是AF_INET,代表TCP/IP协议族
    
    SCNetworkReachabilityRef     readRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&initAddress);     //创建测试连接的引用：
    SCNetworkReachabilityFlags flags;
    
    BOOL getRetrieveFlags = SCNetworkReachabilityGetFlags(readRouteReachability, &flags);
    CFRelease(readRouteReachability);
    
    if (!getRetrieveFlags) {
        return NO;
    }
    
    BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (flagsReachable && !connectionRequired) ? YES : NO;
}
@end
