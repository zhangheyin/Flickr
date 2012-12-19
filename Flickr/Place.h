//
//  Place.h
//  Flickr
//
//  Created by Zhang Heyin on 12-12-13.
//  Copyright (c) 2012年 yulore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFAppDotNetAPIClient.h"

@interface Place : NSObject


@property (readonly) NSString *content;
@property (readonly) float latitude;
@property (readonly) float longitude;
@property (readonly) int photo_count;
@property (readonly) NSString *place_id;
@property (readonly) NSString *place_type;
@property (readonly) NSString *place_type_id;
@property (readonly) NSString *place_url;
@property (readonly) NSString *timezone;
@property (readonly) NSString *woe_name;
@property (readonly) NSString *woeid;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block;

@end
