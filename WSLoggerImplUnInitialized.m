//
//  WSLoggerImplUnInitialized.m
//  Axonator
//
//  Created by Ashish on 31/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLoggerImplUnInitialized.h"

@implementation WSLoggerImplUnInitialized
-(void) log:(WSLogEntry *)logEntry
{
    [self.delegate didFailedLoggingWithReason:@"Setting Uninitialized.\nYou must initialize WSLogger Object with initWithSettings method.\nFor Example: [[WSLogger logger] initWithSettings:settings];"];
    [NSException raise:NSInternalInconsistencyException
                format:@"Setting Uninitialized.\nYou must initialize WSLogger Object with initWithSettings method.\nFor Example: [[WSLogger logger] initWithSettings:settings];"];
    
}
@end
