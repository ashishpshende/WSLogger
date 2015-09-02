//
//  WSLogListView.m
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLogListView.h"
#import "WSLogEntry.h"
#import "WSLogTableViewCell.h"
#import "WSLogEnrtyView.h"

@implementation WSLogListView
{
    UITableView *logListTableView;
    NSMutableArray *logList;
    
    UILabel *noResultLabel;
}
@synthesize showMeList;
@synthesize parentVC;
@synthesize delegate;
-(void) loadLogs
{
    logList = [[WSLogger logger] getAllLogEntries];
    [self refreshView];
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showMeList = NO;
        logListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        logListTableView.delegate = self;
        logListTableView.dataSource = self;
        [logListTableView registerClass:[WSLogTableViewCell class] forCellReuseIdentifier:@"LOGVIEWCELL"];
        [logListTableView setHidden:NO];
        logListTableView.tableFooterView= [[UIView alloc] initWithFrame:CGRectZero];
        logListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:logListTableView];
        
        noResultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2-25, self.frame.size.width, 50)];
        [self addSubview:noResultLabel];
        [noResultLabel setTextAlignment:NSTextAlignmentCenter];
        [noResultLabel setText:@"No Log Entries Found in database"];
        [noResultLabel setHidden:YES];
        [self loadLogs];
    }
    return self;
}
-(void) refreshView
{
    if (logList.count == 0)
    {
        [noResultLabel setHidden:NO];
        [logListTableView setHidden:YES];
    }
    else
    {
        [noResultLabel setHidden:YES];
        [logListTableView setHidden:NO];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return logList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSLogEntry *logEntry = (WSLogEntry*) [logList objectAtIndex:indexPath.row];
    WSLogEnrtyView *entryView = [[WSLogEnrtyView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [entryView setLogEntry:logEntry];
    [self.delegate getSelectedLogEnrtyView:entryView];
    [self.delegate logListView:self didLogEntrySelected:logEntry];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOGVIEWCELL" forIndexPath:indexPath];
    WSLogEntry *logEntry = (WSLogEntry*) [logList objectAtIndex:indexPath.row];
    logEntry.logEntrySerialNumber  = indexPath.row +1;
    [cell setLogEntry:logEntry];
    if (indexPath.row % 2 == 0)
        [cell.contentView setBackgroundColor:[UIColor lightGrayColor]];
    else
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

@end
