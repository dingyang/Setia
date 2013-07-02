//
//  PostDataToServer.h
//  Project_Setia
//
//  Created by Ding Yang on 4/6/13.
//  Copyright (c) 2013 Ding Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PostServerDataDelegate <NSObject>

-(void)postServerDataDidFinish:(NSArray *)serverData;
@optional
-(void)postServerDateFailed;

@end

@interface PostDataToServer : NSObject
@property (nonatomic,retain) NSArray *serverDataArray;
@property (nonatomic,retain) id <PostServerDataDelegate> delegate;

-(void)postServerDataMappingForClass:(id)mappingclass mappingsFromDictionary:(NSDictionary *)dic appendingUrlString:(NSString *)str postParameters:(NSDictionary*)params pathPattern:(NSString *)pattern keyPath:(NSString *)path Delegate:(id)serverDelegate;
@end
