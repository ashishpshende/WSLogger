//
//  WSLoggerImplementation.m
//  Axonator
//
//  Created by Ashish on 31/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLoggerImplementation.h"

@implementation WSLoggerImplementation
@synthesize delegate;
-(void)log:(WSLogEntry *)logEntry
{
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}
@end
