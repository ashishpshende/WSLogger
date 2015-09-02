//
//  WSLogEnrtyView.m
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//
#import "WSLogEntryWidgetKeyValuePair.h"
#import <objc/runtime.h>
#import "WSLogEnrtyView.h"
#import "WSLogEntryWidgetTableViewCell.h"
@implementation WSLogEnrtyView
{
    UITableView *logEntryTableView;
    NSMutableArray *WidgetList;
    NSMutableArray *parameters;
    UIAlertView *alertView;
}
-(void) setLogEntry:(WSLogEntry *)logEntry
{
    _logEntry = logEntry;
    [self loadWidgetArrays];
    [self loadparameterArrays];
}
-(void) loadWidgetArrays
{
    WidgetList = [NSMutableArray array];
    unsigned int count=0;
    objc_property_t *propsSuper = class_copyPropertyList([WSLogEntry class],&count);
    for ( int i=0;i<count;i++ )
    {
        const char *name = property_getName(propsSuper[i]);
        WSLogEntryWidgetKeyValuePair *keyPair = [[WSLogEntryWidgetKeyValuePair alloc]init];
        keyPair.key = [NSString stringWithFormat:@"%s",name];
        keyPair.value =[NSString stringWithFormat:@"%@",[_logEntry valueForKey:[NSString stringWithFormat:@"%s",name]]];
        if (![keyPair.key isEqualToString:@"parameters"])
            [WidgetList addObject:keyPair];
    }

}
-(void) loadparameterArrays
{
    parameters = [NSMutableArray array];
    for (NSString *aKey in [_logEntry.parameters allKeys])
    {
        WSLogEntryWidgetKeyValuePair *keyPair = [[WSLogEntryWidgetKeyValuePair alloc]init];
        keyPair.key = aKey;
        keyPair.value =[_logEntry.parameters objectForKey:aKey];
        [parameters addObject:keyPair];
    }
}
-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        logEntryTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        logEntryTableView.delegate = self;
        logEntryTableView.dataSource = self;
        [logEntryTableView registerClass:[WSLogEntryWidgetTableViewCell class] forCellReuseIdentifier:@"LOGWIDGETCELL"];
        [logEntryTableView setHidden:NO];
        logEntryTableView.tableFooterView= [[UIView alloc] initWithFrame:CGRectZero];
        logEntryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:logEntryTableView];
        alertView = [[UIAlertView alloc] initWithTitle:@"Details" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Basic Parameters";
    else
        return @"Customized Parameters";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return WidgetList.count;
    else
        return parameters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSLogEntryWidgetTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LOGWIDGETCELL" forIndexPath:indexPath];
    WSLogEntryWidgetKeyValuePair *keyPair;
    if (indexPath.section ==0)
    {
        keyPair = [WidgetList objectAtIndex:indexPath.row];
        [cell setKeyValuePair:keyPair];
    }
    else
    {
        keyPair = [parameters objectAtIndex:indexPath.row];
        [cell setKeyValuePair:keyPair];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WSLogEntryWidgetKeyValuePair *keyPair;
    if (indexPath.section ==0)
    {
        keyPair = [WidgetList objectAtIndex:indexPath.row];
        alertView.message = [NSString stringWithFormat:@"%@ : %@",keyPair.key,keyPair.value];
    }
    else
    {
        keyPair = [parameters objectAtIndex:indexPath.row];
        alertView.message = [NSString stringWithFormat:@"%@ : %@",keyPair.key,keyPair.value];
    }
    [alertView show];
}
@end
