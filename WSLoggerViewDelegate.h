//
//  WSLoggerViewDelegate.h
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLogEntry.h"
#import "WSLogEnrtyView.h"
@class WSLogListView;
@protocol WSLoggerViewDelegate <NSObject>

@required
-(void) logListView:(WSLogListView *)logListView didLogEntrySelected:(WSLogEntry *)logEntry;
@optional
-(void) getSelectedLogEnrtyView:(WSLogEnrtyView *)LogEnrtyView;
@end

