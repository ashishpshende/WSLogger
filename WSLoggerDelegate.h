//
//  WSLoggerDelegate.h
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WSLoggerDelegate <NSObject>

@required
-(void) didFailedLoggingWithReason:(NSString *) reason;
@optional
-(void) didSuceedLogging:(NSDictionary *) response;
-(void) didLogRecordsDelete:(NSString *) message;
@end