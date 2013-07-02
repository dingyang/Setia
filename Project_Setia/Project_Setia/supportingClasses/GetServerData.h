//
//  GetServerData.h
//  Project_Setia
//
//  Created by Ding Yang on 15/5/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServerDataDelegate <NSObject>
-(void)getServerDataDidFinish:(NSArray *)serverData;
@optional
-(void)getServerDateFailed;

@end

@interface GetServerData : NSObject
@property (nonatomic,retain) NSArray *serverDataArray;
@property (nonatomic,retain) id <ServerDataDelegate> delegate;

-(void)getServerDataMappingForClass:(id)mappingclass mappingsFromDictionary:(NSDictionary *)dic pathPattern:(NSString*)pattern keyPath:(NSString*)path appendingUrlString:(NSString*)str Delegate:(id)serverDelegate;
@end


