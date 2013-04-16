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
    _splashViewController.delegate = self;
    [self presentViewController:_splashViewController animated:NO completion:^(void){
        [_splashViewController showNameFieldIfNeeded];
    }];

    _jobs = [[[DataManager sharedManager] jobs] mutableCopy];
    _selectedJobs = [NSMutableArray arrayWithCapacity:[_jobs count]];
    NSLog(@"_jobs %@", _jobs);
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    
    [[DataManager sharedManager] save];
    
    [self _setNoJobsView];

}

#pragma mark - SplashViewControllerDelegate

- (void)splashViewControllerShouldBeRemoved:(SplashViewController *)vc;
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
        _splashViewController = nil;
    }];
}

- (void)_jobsDidChange:(NSNotification *)notification;
{
    [notification.object enumerateKeysAndObjectsUsingBlock:^(id key, Job *job, BOOL *stop) {
        
        if ([key isEqualToString:kNotificationKey_JobAdded] && nil != job) {
            [job setIncludeInCalculation:YES];
            [_jobs insertObject:job atIndex:0];
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationTop];
        }else if([key isEqualToString:kNotificationKey_JobDeleted] && nil != job){
            NSInteger index = [_jobs indexOfObject:job];

            [_jobs removeObjectIdenticalTo:job];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationFade];
        }

    }];
    [self _setNoJobsView];
}

- (void)_setNoJobsView;
{
//    self.tableView.tableFooterView = [[UIView alloc] init];
    if ([_jobs count]) {
        self.tableView.tableHeaderView = nil;
    }else{
        NSLog(@"_noJobsView %@", _noJobsView);
        self.tableView.tableHeaderView = _noJobsView;
    }
//    self.tableView.tableHeaderView = ([_jobs count]) ? nil : _noJobsView;
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
- (IBAction)showJobs:(id)sender;
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
        
    }
//    else{
//        cell = [tableView dequeueReusableCellWithIdentifier:@"AddJobTableCell" forIndexPath:indexPath];
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        text = @"Add Job";
//    }
    cell.textLabel.text = text;
    
    
    // Configure the cell...
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    NSString *title = ([_jobs count] < 1) ? nil : @"My Jobs";
    NSLog(@"ttttitt %@", title);
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = ([_jobs count] < 1) ? 0.0 : 30.0;
    return height;
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

}



- (void)dealloc;
{
    self.noJobsView = nil;
}


@end
