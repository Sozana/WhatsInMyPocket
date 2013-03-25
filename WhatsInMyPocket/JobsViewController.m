//
//  JobsViewController.m
//  WhatsInMyPocket
//
//  Created by Mattias Burstrom on 3/22/13.
//  Copyright (c) 2013 sawsan altammar. All rights reserved.
//

#import "JobsViewController.h"
#import "DataManager.h"
#import "Job.h"
#import "Option.h"
#import "JobTableCell.h"
#import "OptionInputCell.h"

@interface JobsViewController ()
{
    NSMutableArray *_jobs;
    Job *_selectedJob;
}
@end

@implementation JobsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _jobs = [[[DataManager sharedManager] jobs] mutableCopy];
    NSLog(@"_jobs %@", _jobs);
    
    self.tableView.tableFooterView = [[UIView alloc] init];

}
- (IBAction)addJob:(UIBarButtonItem *)sender;
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Job Name"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Add", nil];
    
    [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [message show];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *name = [[alertView textFieldAtIndex:0] text];
    if( [name length] >= 3 ){
        return YES;
    }
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 1) {
        NSString *name = [[alertView textFieldAtIndex:0] text];
        [self _addJobWithName:name];
    }
}

- (void)_addJobWithName:(NSString *)name;
{
    Job *job = [[Job alloc] initWithName:name];
    job.options = [[DataManager sharedManager] options];
    [_jobs insertObject:job atIndex:0];
    NSLog(@"_jobs %@", _jobs);
    [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_jobs count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 1;
    Job *job = [_jobs objectAtIndex:section];
    if (job.isSelected || [job isEqual:_selectedJob]) {
        rows = [job.options count] + 1;
    }
    NSLog(@"section %d rows %d",section, rows);
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    if (indexPath.row == 0) {
        cell = (JobTableCell *)[tableView dequeueReusableCellWithIdentifier:@"JobTableCell" forIndexPath:indexPath];
        Job *job = [_jobs objectAtIndex:indexPath.section];
        [(JobTableCell *)cell setJob:job];
    }else{
        cell = (OptionInputCell *)[tableView dequeueReusableCellWithIdentifier:@"OptionInputCell" forIndexPath:indexPath];
        Job *job = [_jobs objectAtIndex:indexPath.section];
        Option *option = [job.options objectAtIndex:indexPath.row-1];
        [(OptionInputCell *)cell setOption:option];
    }

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat height = 40.0;
    if (indexPath.row > 0) {
        height = 36.0;
    }
    return height;
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobTableCell *cell = (JobTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    Job *job = cell.job;
    _selectedJob = job;
    BOOL deselect = job.isSelected;
    [cell toggleSelected];
    
    NSLog(@"indexPath %d", indexPath.section);
    int cnt = [cell.job.options count];
    
    NSLog(@"%d", cnt);
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:cnt];
    for (int i=1; i<=cnt; i++) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
        [arr addObject:ip];
    }

    for (Job *jj in _jobs) {
        if (NO == jj.isSelected) {
            [tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationTop];
        } else if(deselect) {
            
            [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}




#pragma mark - TextFieldDelegate


//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//{
//
//}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)

- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Memory Management

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
