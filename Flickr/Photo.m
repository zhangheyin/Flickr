//
//  Place.m
//  Flickr
//
//  Created by Zhang Heyin on 12-12-13.
//  Copyright (c) 2012年 yulore. All rights reserved.
//

#import "Photo.h"

@implementation Photo
@synthesize title = _title;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize id = _id;
@synthesize place_id = _place_id;
@synthesize farm = _farm;
@synthesize server = _server;
@synthesize secret = _secret;
@synthesize originalsecret = _originalsecret;
@synthesize originalformat = _originalformat;


- (id) initWithAttributes:(NSDictionary *)attributes {
  self = [super init];
  if (!self) {
    return nil;
  }
  
  _title = [attributes valueForKeyPath:@"title"];
  _latitude = [[attributes valueForKeyPath:@"latitude"] floatValue];
  _longitude = [[attributes valueForKeyPath:@"longitude"] floatValue];
  _place_id = [attributes valueForKeyPath:@"place_id"];
  _id = [attributes valueForKeyPath:@"id"];
  _farm = [attributes valueForKeyPath:@"farm"];
  _server = [attributes valueForKeyPath:@"server"];
  _secret = [attributes valueForKeyPath:@"secret"];
  _originalsecret = [attributes valueForKeyPath:@"originalsecret"];
  _originalformat = [attributes valueForKeyPath:@"originalformat"];
  return self;
}

+ (void)globalPhotoWithplaceID:(NSString *)placeID maxResult:(int)maxResult block:(void (^)(NSArray *, NSError *))block {
  [[AFAppDotNetAPIClient sharedPhotoClient:placeID maxResult:maxResult] getPath:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
    NSArray *postsFromResponse = [JSON valueForKeyPath:@"photos.photo"];
    NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
    NSLog(@"%@", postsFromResponse);
    for (NSDictionary *attributes in postsFromResponse) {
      Photo *aPhoto = [[Photo alloc] initWithAttributes:attributes];
      [mutablePosts addObject:aPhoto];
      
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



+ (NSString *)urlStringForPhoto:(Photo *)photo format:(FlickrPhotoFormat)format
{
	NSString *farm = photo.farm;
	NSString *server = photo.server;
	NSString *photo_id = photo.id;
	NSString *secret = photo.secret;
	if (format == FlickrPhotoFormatOriginal)
    secret = photo.originalsecret;
  
	NSString *fileType = @"jpg";
	if (format == FlickrPhotoFormatOriginal)
    fileType = photo.originalformat;
	
	if (!farm || !server || !photo_id || !secret) return nil;
	
	NSString *formatString = @"s";
	switch (format) {
		case FlickrPhotoFormatSquare:    formatString = @"s"; break;
		case FlickrPhotoFormatLarge:     formatString = @"b"; break;
    case FlickrPhotoFormatThumbnail: formatString = @"t"; break;
      // case FlickrPhotoFormatSmall:     formatString = @"m"; break;
      // case FlickrPhotoFormatMedium500: formatString = @"-"; break;
      // case FlickrPhotoFormatMedium640: formatString = @"z"; break;
		case FlickrPhotoFormatOriginal:  formatString = @"o"; break;
	}
  
	return [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_%@.%@", farm, server, photo_id, secret, formatString, fileType];
}

+ (NSURL *)urlForPhoto:(Photo *)photo format:(FlickrPhotoFormat)format
{
  return [NSURL URLWithString:[self urlStringForPhoto:photo format:format]];
}


@end
