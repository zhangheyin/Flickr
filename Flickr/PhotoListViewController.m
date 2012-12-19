//
//  PhotoListViewController.m
//  Flickr
//
//  Created by Zhang Heyin on 12-12-13.
//  Copyright (c) 2012年 yulore. All rights reserved.
//

#import "PhotoListViewController.h"
#import "FlickrFetcher.h"
#import "UIImageView+AFNetworking.h"
#import "PhotoTableViewCell.h"
@interface PhotoListViewController ()

@end

@implementation PhotoListViewController
@synthesize photosInPlace = _photosInPlace;
@synthesize currentPlace = _currentPlace;

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}
- (void)reload:(id)sender {
  // [_activityIndicatorView startAnimating];
  self.navigationItem.rightBarButtonItem.enabled = NO;
  
  
  [Photo globalPhotoWithplaceID:self.currentPlace.place_id maxResult:100 block:^(NSArray *posts, NSError *error){
    if (error) {
      [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
    } else {
      
      self.photosInPlace = posts;
      [self.tableView reloadData];
      //[_activityIndicatorView stopAnimating];
      self.navigationItem.rightBarButtonItem.enabled = YES;
    }}];
}
- (void)viewDidLoad
{
  [super viewDidLoad];
  //NSLog(@"start");
  //self.photosInPlace = [FlickrFetcher photosInPlace2:self.currentPlace
  //                                     maxResults:100];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
  
  self.tableView.rowHeight = 70.0f;
  
  [self reload:nil];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
  return [self.photosInPlace count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"PhotoCell";
  PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[PhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
  }
  
  
  
  // Configure the cell...
  [cell setPhoto:[self.photosInPlace objectAtIndex:indexPath.row]];
  return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [PhotoTableViewCell heightForCellWithPost:[self.photosInPlace objectAtIndex:indexPath.row]];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Navigation logic may go here. Create and push another view controller.
  /*
   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
   // ...
   // Pass the selected object to the new view controller.
   [self.navigationController pushViewController:detailViewController animated:YES];
   */
}

@end
