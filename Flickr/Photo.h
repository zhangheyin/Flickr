//
//  Place.h
//  Flickr
//
//  Created by Zhang Heyin on 12-12-13.
//  Copyright (c) 2012年 yulore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFAppDotNetAPIClient.h"

@interface Photo : NSObject


@property (readonly) NSString *title;
@property (readonly) float latitude;
@property (readonly) float longitude;
@property (readonly) NSString *place_id;
@property (readonly) NSString *id;
@property (readonly) NSString *farm;
@property (readonly) NSString *server;
@property (readonly) NSString *secret;
@property (readonly) NSString *originalsecret;
@property (readonly) NSString *originalformat;
typedef enum {
	FlickrPhotoFormatSquare = 1,
	FlickrPhotoFormatLarge = 2,
	FlickrPhotoFormatOriginal = 64,
  FlickrPhotoFormatThumbnail = 128
} FlickrPhotoFormat;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)globalPhotoWithplaceID:(NSString *)placeID maxResult:(int)maxResult block:(void (^)(NSArray *posts, NSError *error))block;
+ (NSURL *)urlForPhoto:(Photo *)photo format:(FlickrPhotoFormat)format;
@end
