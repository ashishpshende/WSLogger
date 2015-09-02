//
//  WSLogger.h
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <Foundation/Foundation.h>
//Delegate
#import "WSLoggerDelegate.h"
#import "WSLoggerViewDelegate.h"



#import "WSLogEntry.h"
#import "WSLoggerImpl.h"
#import "FMDatabase.h"
#import "WSLoggerSettings.h"


//Display Content
#import "WSLogEnrtyView.h"
#import "WSLogListView.h"


@interface WSLogger : NSObject <WSLoggerImpl>
@property (nonatomic,strong) WSLoggerSettings *settings;
@property (nonatomic,strong) NSString *loggerToken;
@property (nonatomic,strong) id<WSLoggerDelegate> delegate ;
@property (nonatomic,strong) FMDatabase *database;
@property (nonatomic,strong) NSString *apiURL;

-(void) log:(WSLogEntry *) logEntry;
+(instancetype) logger;
-(instancetype) initWithSettings:(WSLoggerSettings *)loggerSettings;
-(NSMutableArray *) getAllLogEntries;
-(void) clearRecords;
-(void) clearAllRecords;
@end
