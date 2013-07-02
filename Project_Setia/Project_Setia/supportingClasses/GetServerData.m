//
//  GetServerData.m
//  Project_Setia
//
//  Created by Ding Yang on 15/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import "GetServerData.h"
@implementation GetServerData
@synthesize serverDataArray;
@synthesize delegate;

-(void)getServerDataMappingForClass:(id)mappingclass mappingsFromDictionary:(NSDictionary *)dic pathPattern:(NSString *)pattern keyPath:(NSString *)path appendingUrlString:(NSString *)str Delegate:(id)serverDelegate
{
    self.delegate = serverDelegate;
    self.serverDataArray = [[NSArray alloc]init];
    
    RKObjectMapping* articleMapping = [RKObjectMapping mappingForClass:[mappingclass class]];
    [articleMapping addAttributeMappingsFromDictionary:dic];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping pathPattern:pattern keyPath:path statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSMutableString *baseUrl = [NSMutableString stringWithString:@"http://www.guangqinggong.com/Setia/API/"];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",baseUrl,str];
    NSURL *URL = [NSURL URLWithString:requestUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of Articles: %@", mappingResult.array);
        [self.delegate getServerDataDidFinish:mappingResult.array];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
        [self.delegate getServerDateFailed];
    }];
    [objectRequestOperation start];
}
@end
