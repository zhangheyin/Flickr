//
//  Place.m
//  Flickr
//
//  Created by Zhang Heyin on 12-12-13.
//  Copyright (c) 2012年 yulore. All rights reserved.
//

#import "Place.h"

@implementation Place
@synthesize content = _content;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize photo_count = _photo_count;
@synthesize place_id = _place_id;
@synthesize place_type = _place_type;
@synthesize place_type_id = _place_type_id;
@synthesize place_url = _place_url;
@synthesize timezone = _timezone;
@synthesize woe_name = _woe_name;
@synthesize woeid = _woeid;



- (id) initWithAttributes:(NSDictionary *)attributes {
  self = [super init];
  if (!self) {
    return nil;
  }
  
  _content = [attributes valueForKeyPath:@"_content"];
  _latitude = [[attributes valueForKeyPath:@"latitude"] floatValue];
  _longitude = [[attributes valueForKeyPath:@"longitude"] floatValue];
  _photo_count = [[attributes valueForKeyPath:@"photo_count"] integerValue];
  _place_id = [attributes valueForKeyPath:@"place_id"];
  _place_type = [attributes valueForKeyPath:@"place_type"];
  _place_type_id = [attributes valueForKeyPath:@"place_type_id"];
  _place_url = [attributes valueForKeyPath:@"place_url"];
  _timezone = [attributes valueForKeyPath:@"timezone"];
  _woe_name = [attributes valueForKeyPath:@"woe_name"];
  _woeid = [attributes valueForKeyPath:@"woeid"];
  
  return self;
}

+ (void)globalTimelinePostsWithBlock:(void (^)(NSArray *posts, NSError *error))block {
  [[AFAppDotNetAPIClient sharedClient] getPath:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
    NSArray *postsFromResponse = [JSON valueForKeyPath:@"places.place"];
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
    for (NSDictionary *attributes in postsFromResponse) {
      Place *aPlace = [[Place alloc] initWithAttributes:attributes];
      [mutablePosts addObject:aPlace];
      
    }
    
    if (block) {
      block([NSArray arrayWithArray:mutablePosts], nil);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    if (block) {
      block([NSArray array], error);
    }
  }];
}

@end
