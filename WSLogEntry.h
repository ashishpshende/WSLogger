//
//  WSLogEntry.h
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
typedef NS_ENUM(NSInteger, WSLogEntryType)
{
    WSError,
    WSAPICall,
    WSAPIResponse,
    WSAPPCrash,
    WSActivity
};
@interface WSLogEntry : NSObject
@property (nonatomic) long logEntrySerialNumber;
@property (nonatomic) long logEntryCode;
@property (nonatomic) WSLogEntryType logEntryType;
@property (nonatomic,strong) NSString *logEntryMessage;
@property (nonatomic,strong) NSString *logEntryDescription;
@property (nonatomic,strong) NSString *dateTime;
@property (nonatomic,strong) NSString *ipAddress;
@property (nonatomic) double longitude;
@property (nonatomic) double latiitude;
@property (nonatomic,strong) NSDictionary *parameters;

-(instancetype) initWithResultSet:(FMResultSet *) resultSet;
-(NSDictionary *) toDictionary;
-(void) print;
-(void) save;
@end
