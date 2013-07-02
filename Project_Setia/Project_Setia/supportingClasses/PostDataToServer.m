//
//  PostDataToServer.m
//  Project_Setia
//
//  Created by Ding Yang on 4/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:@[@"st_id",@"st_name",@"st_description",@"st_email",@"st_url",@"st_discount",@"st_buildingName",@"st_unitNumber",@"st_streetName",@"st_landmark",@"st_postalCode",@"st_country",@"st_city",@"st_phone1",@"st_phone2"] forKeys:@[@"id",@"name",@"description",@"email",@"url",@"discount",@"building_name",@"unit_number",@"street_name",@"landmark",@"postal_code",@"country",@"city",@"phone_1",@"phone_2"]];

#import "PostDataToServer.h"
#import <RestKit/RestKit.h>
#import "SuperAdministratorItem.h"

@implementation PostDataToServer
@synthesize serverDataArray;
@synthesize delegate;

-(void)postServerDataMappingForClass:(id)mappingclass mappingsFromDictionary:(NSDictionary *)dic appendingUrlString:(NSString *)str postParameters:(NSDictionary*)params pathPattern:(NSString *)pattern keyPath:(NSString *)path Delegate:(id)serverDelegate
{
    self.delegate = serverDelegate;
    RKObjectMapping* articleMapping = [RKObjectMapping mappingForClass:[mappingclass class]];
    [articleMapping addAttributeMappingsFromDictionary:dic];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:articleMapping pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    NSString *urlStr = [[NSString alloc]initWithFormat:@"%@%@",@"http://www.guangqinggong.com/Setia/API/",str];
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:urlStr]];
    [manager addResponseDescriptor:responseDescriptor];
    
    // POST to create
    [manager postObject:nil path:@"add.json" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"<======serverData=======>--Load collection of Articles: %@", mappingResult.array);
        [self.delegate postServerDataDidFinish:mappingResult.array];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"<=====postServerDateFailed=====>--Operation failed with error: %@", error);
        [self.delegate postServerDateFailed];
    }];

}

@end
