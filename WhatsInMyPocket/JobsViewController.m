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
#import "TotalsTableCell.h"

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
    NSArray *jobs = [[DataManager sharedManager] jobs];
    _jobs = (nil == jobs) ? [NSMutableArray array] : [jobs mutableCopy];
    NSLog(@"_jobs %@", _jobs);
    
    [self _setNoJobsView];
    

}


- (IBAction)addJob:(UIBarButtonItem *)sender;
{
    [self _addJobWithMessage:nil];
}

- (void)_addJobWithMessage:(NSString *)message;
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Job Name"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Add", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [alert show];
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
    Job *job = [[DataManager sharedManager] addJobNamed:name];
    if (nil == job) {
        [self _addJobWithMessage:[NSString stringWithFormat:@"An error occured!\nA job named \"%@\" already exists", name]];
    }else{
        self.tableView.tableHeaderView = nil;
        [_jobs insertObject:job atIndex:0];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0]
                      withRowAnimation:UITableViewRowAnimationTop];
        [self _setSelectedJob:job];

    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"%d", [_jobs count]);
    return [_jobs count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 1;
    Job *job = [_jobs objectAtIndex:section];
    NSLog(@"%@", job.options);
    
    if (job.isSelected) {
        rows = [job.options count] + 2;
    }
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
        Job *job = [_jobs objectAtIndex:indexPath.section];
        if (indexPath.row == [job.options count] + 1) {
            TotalsTableCell *totCell = (TotalsTableCell *)[tableView dequeueReusableCellWithIdentifier:@"TotalsTableCell" forIndexPath:indexPath];
            totCell.backgroundColor = [UIColor orangeColor];
            totCell.job = job;
            [totCell calculateForLabelText];
            cell = totCell;
            
        }else{
            cell = (OptionInputCell *)[tableView dequeueReusableCellWithIdentifier:@"OptionInputCell" forIndexPath:indexPath];
            NSLog(@"jobOptions %@", job.options);
            Option *option = [job.options objectAtIndex:indexPath.row-1];
            [(OptionInputCell *)cell setOption:option];
        }
    }

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    CGFloat height = 150.0;
    if ([_jobs count]) {
        height = 0.0;
        _noJobsView.frame = CGRectZero;
    }
    return height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
//{
//    CGFloat height = 0.0f;
//    Job *currentJob = [_jobs objectAtIndex:section];
//    if (currentJob.isSelected) {
//        height = 50.0f;
//    }
//    
//    return height;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
//{
//    CGFloat height = 0.0f;
//    TotalsFooterView *view = nil;
//    Job *currentJob = [_jobs objectAtIndex:section];
//    if (currentJob.isSelected) {
//        height = 50.0f;
//        view = [[TotalsFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
//        _footerView = view;
//    }
//    
//    return view;
//    
//}

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
    
    Job *job = [_jobs objectAtIndex:indexPath.section];
    [self _setSelectedJob:job];



}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
// TODO:Fix crash for when deleting a job if a section is opened!
    for (Job *job in _jobs) {
        if (job.isSelected) {
            return NO;
        }
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath %@", indexPath);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self _deleteJobAtIndexPath:indexPath];
    }
}

#pragma mark - Private

- (void)_deleteJobAtIndexPath:(NSIndexPath *)indexPath
{
    Job *job = [_jobs objectAtIndex:indexPath.section];
    [[DataManager sharedManager] deleteJob:job];
    [_jobs removeObjectAtIndex:indexPath.section];
    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                  withRowAnimation:UITableViewRowAnimationFade];
    if ([_jobs count] < 1) {
        [self _setNoJobsView];
    }
    
}
- (void)_setNoJobsView;
{
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = ([_jobs count]) ? nil : _noJobsView;
}

/*
 for (int i=0; i<[_jobs count]; i++){
 Job *currentJob = [_jobs objectAtIndex:i];
 NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
 JobTableCell *cell = (JobTableCell *)[tableView cellForRowAtIndexPath:ip];
 [cell setIsSelected:[currentJob isEqual:job]];
 
 }
 */

- (void)_setSelectedJob:(Job *)job;
{
    int count = [_jobs count];
    
    for (int i=0; i<count; i++){
        Job *currentJob = [_jobs objectAtIndex:i];
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
        JobTableCell *cell = (JobTableCell *)[self.tableView cellForRowAtIndexPath:ip];
        
        int cnt = [currentJob.options count];
        NSArray *ips = [self _indexPathsWithCount:cnt+1 forSection:i];
        if (currentJob.isSelected) {
            [cell setIsSelected:YES];
            [currentJob toggleSelected];
            [self.tableView deleteRowsAtIndexPaths:ips withRowAnimation:UITableViewRowAnimationTop];
            
        }else if([job isEqual:currentJob] && NO == currentJob.isSelected){
            [cell setIsSelected:NO];
            [currentJob toggleSelected];
            [self.tableView insertRowsAtIndexPaths:ips withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}

- (NSArray *)_indexPathsWithCount:(NSInteger)cnt forSection:(NSInteger)section;
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:cnt];
    for (int i=1; i<=cnt; i++) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:section];
        [arr addObject:ip];
    }
    return arr;
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField; 
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
