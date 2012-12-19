//
//  FlickerTableViewController.h
//  Flickr
//
//  Created by Zhang Heyin on 12-12-12.
//  Copyright (c) 2012年 yulore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoListViewController.h"
@interface FlickerTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *topPlaceArray;
@property (nonatomic, strong) PhotoListViewController *photoListViewController;
@end
