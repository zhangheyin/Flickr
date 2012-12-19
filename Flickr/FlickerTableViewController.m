//
//  FlickerTableViewController.m
//  Flickr
//
//  Created by Zhang Heyin on 12-12-12.
//  Copyright (c) 2012年 yulore. All rights reserved.
//

#import "FlickerTableViewController.h"
#import "FlickrFetcher.h"
#import "Place.h"
@interface FlickerTableViewController ()

@end

@implementation FlickerTableViewController
@synthesize topPlaceArray = _topPlaceArray;
@synthesize photoListViewController = _photoListViewController;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  NSLog(@"start");
  [Place globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
    if (error) {
      [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
    } else {
      self.topPlaceArray = posts;
      [self.tableView reloadData];
    }
  }];
    NSLog(@"stop");
  //NSLog(@"start");
  //self.topPlaceArray = [FlickrFetcher topPlaces];
  // NSLog(@"stop");
 // NSLog(@"%@", self.topPlaceArray);
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
  return [self.topPlaceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
 // NSDictionary *singlePlace = [self.topPlaceArray objectAtIndex:[indexPath row]];
  Place *aPlace = [self.topPlaceArray objectAtIndex:[indexPath row]];
  [cell.textLabel setText:[NSString stringWithFormat:@"%@", aPlace.content]];
  [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", aPlace.woe_name]];
  NSLog(@"cellForRowAtIndexPathcellForRowAtIndexPath");
    return cell;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
  Place *currentPlace = [self.topPlaceArray objectAtIndex:[indexPath row]];
  if ([segue.identifier isEqualToString:@"toList"]) {
    [segue.destinationViewController setCurrentPlace:currentPlace];
  }
}

@end
