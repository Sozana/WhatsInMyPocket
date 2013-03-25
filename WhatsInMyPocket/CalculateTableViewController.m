//
//  CalculateTableViewController.m
//  WhatsInMyPocket
//
//  Created by sawsan altammar on 2/23/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "CalculateTableViewController.h"
#import "OptionInputCell.h"
#import "IIViewDeckController.h"
#import "DataManager.h"
#import "Job.h"
#import "Option.h"
#import "Constants.h"
#import "JobSelectionTableCell.h"

@interface CalculateTableViewController ()
{
    NSArray *_jobs;
    NSMutableArray *_selectedJobs;
}
@end

@implementation CalculateTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    _jobs = [DataManager sharedManager].jobs;
    _selectedJobs = [NSMutableArray arrayWithCapacity:[_jobs count]];
    NSLog(@"_jobs %@", _jobs);
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}
- (void)bababoi;
{
    
}

- (IBAction)whatsInMyPocket:(UIButton *)sender;
{
    self.resultLabel.text = @"No Idea!";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // A change :)
    // another change
    
}


- (IBAction)showSelection:(UIBarButtonItem *)sender;
{
    [self.viewDeckController toggleRightViewAnimated:YES];
}
- (IBAction)showJobs:(UIBarButtonItem *)sender;
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_jobs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JobSelectionCell";
    JobSelectionTableCell *cell = (JobSelectionTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Job *job = [_jobs objectAtIndex:indexPath.row];
    NSLog(@"%@", job.name);
    
    cell.textLabel.text = job.name;
    // Configure the cell...
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobSelectionTableCell *cell = (JobSelectionTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell toggleSelected];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}





@end
