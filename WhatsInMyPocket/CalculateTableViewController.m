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
#import "AddJobTableCell.h"
#import "SplashViewController.h"


@interface CalculateTableViewController ()
{
    NSMutableArray *_jobs;
    NSMutableArray *_selectedJobs;
    SplashViewController *_splashViewController;
}
@end

@implementation CalculateTableViewController

- (void)awakeFromNib;
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_jobsDidChange:) name:kJobsUpdatedNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _splashViewController = [[SplashViewController alloc] init];
    [self presentViewController:_splashViewController animated:NO completion:nil];
    [self performSelector:@selector(_removeSplash) withObject:nil afterDelay:4];

    _jobs = [[[DataManager sharedManager] jobs] mutableCopy];
    _selectedJobs = [NSMutableArray arrayWithCapacity:[_jobs count]];
    NSLog(@"_jobs %@", _jobs);
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    
    [[DataManager sharedManager] save];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)_jobsDidChange:(NSNotification *)notification;
{
    [notification.object enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([key isEqualToString:kNotificationKey_JobAdded] && nil != obj) {
            [_jobs insertObject:obj atIndex:0];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationTop];
        }else if([key isEqualToString:kNotificationKey_JobDeleted] && nil != obj){
            NSInteger index = [_jobs indexOfObject:obj];

            [_jobs removeObjectIdenticalTo:obj];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationFade];
        }

    }];
}

- (void)_removeSplash;
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        _splashViewController = nil;
    }];
//    [UIView animateWithDuration:1.0f
//                     animations:^{
//                         _splashViewController.view.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished) {
//                         if (finished) {
//                             
//                         }
//                     }];
    
}

- (void)bababoi;
{
    
}

- (IBAction)whatsInMyPocket:(UIButton *)sender;
{
    self.resultLabel.text = @"$3276";
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
    NSInteger cnt = [_jobs count];
    return cnt;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger cnt = [_jobs count];
    NSLog(@"cnt %d", cnt);
    return cnt;
    return (cnt) ? cnt : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *text = nil;
    if ([_jobs count]) {
        cell = (JobSelectionTableCell *)[tableView dequeueReusableCellWithIdentifier:@"JobSelectionCell" forIndexPath:indexPath];
        Job *job = [_jobs objectAtIndex:indexPath.row];
        NSLog(@"%@", job.name);
        [(JobSelectionTableCell *)cell setIncluded:job.includeInCalculation];
        text = job.name;
        
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddJobTableCell" forIndexPath:indexPath];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        text = @"Add Job";
    }
    cell.textLabel.text = text;
    
    
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    NSString *title = nil;
    if (section == 0) {
        title = @"My Jobs";
    }
    return title;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[AddJobTableCell class]]) {
        [self showJobs:nil];
    }else{
        Job *job = [_jobs objectAtIndex:indexPath.row];
        [(JobSelectionTableCell *)cell toggleSelected];
        job.includeInCalculation = cell.isSelected;
        [[DataManager sharedManager] save];
    }
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
    *detailViewController = [[  alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}





@end
