//
//  WSLoggerImpl.h
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLogEntry.h"
@protocol WSLoggerImpl <NSObject>
-(void) log:(WSLogEntry *) logEntry;
@end