//
//  WSLoggerImplementation.h
//  Axonator
//
//  Created by Ashish on 31/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLoggerDelegate.h"
#import "WSLogEntry.h"
#import "WSLogger.h"
@interface WSLoggerImplementation : NSObject
@property (nonatomic,strong) id <WSLoggerDelegate> delegate;
-(void) log:(WSLogEntry *) logEntry;
@end
