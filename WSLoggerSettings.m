//
//  WSLoggerSettings.m
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLoggerSettings.h"

@implementation WSLoggerSettings
@synthesize BaseURL;
@synthesize APIName;
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _numberOfLogs = 10;
    }
    return self;
}
-(void) setNumberOfLogs:(int)numberOfLogs
{
    if (numberOfLogs >=10)
        _numberOfLogs = numberOfLogs;
}
@end
