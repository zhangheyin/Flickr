// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFAppDotNetAPIClient.h"

#import "AFJSONRequestOperation.h"
#import "FlickrAPIKey.h"
static NSString * const kAFAppDotNetAPIBaseURLString = @"http://api.flickr.com/services/rest/?method=flickr.places.getTopPlacesList&place_type_id=7&format=json&nojsoncallback=1&api_key=1b7df8a1f2e826d4d0dfe1f894f084ec";


static NSString * const kAFAppDotNetAPIPhotoURLString = @"";
@implementation AFAppDotNetAPIClient

+ (AFAppDotNetAPIClient *)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetAPIBaseURLString]];
    });
    
    return _sharedClient;
}


+ (AFAppDotNetAPIClient *)sharedPhotoClient:(NSString *)placeID maxResult:(int)maxResult {
  static AFAppDotNetAPIClient *_sharedClient = nil;
  //static dispatch_once_t onceToken;
  
  NSString *url = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&place_id=%@&per_page=%d&extras=original_format,tags,description,geo,date_upload,owner_name,place_url", placeID, maxResult];
  NSString *newURL = [NSString stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@", url, FlickrAPIKey];
  //dispatch_once(&onceToken, ^{
    _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:newURL]];
  //});
  NSLog(@"%@", newURL);
  return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end
