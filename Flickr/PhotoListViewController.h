//
//  PhotoListViewController.h
//  Flickr
//
//  Created by Zhang Heyin on 12-12-13.
//  Copyright (c) 2012年 yulore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "Photo.h"
@interface PhotoListViewController : UITableViewController


@property (nonatomic, strong) NSArray *photosInPlace;
@property (nonatomic, strong) Place *currentPlace;
@end
