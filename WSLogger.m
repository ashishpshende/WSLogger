//
//  WSLogger.m
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLogger.h"
#import "WSLoggerImplementation.h"
#import "WSLoggerImplInitialized.h"
#import "WSLoggerImplUnInitialized.h"
#define LOGGERDBPATH @"LoggerDB.sqlite"

@implementation WSLogger
{
    WSLoggerImplementation *internalLogger;
    WSLoggerImplInitialized  *LoggerImplInitialized;
    WSLoggerImplUnInitialized *LoggerImplUnInitialized;
}
@synthesize settings;
@synthesize apiURL;
@synthesize loggerToken;
@synthesize database;
static WSLogger *logger;
-(void) setDelegate:(id<WSLoggerDelegate>)delegate
{
    _delegate = delegate;
    internalLogger.delegate = _delegate;
    LoggerImplInitialized.delegate = _delegate;
    LoggerImplUnInitialized.delegate = _delegate;
}
- (instancetype)initFromInside
{
    self = [super init];
    if (self)
    {
        //Initailize Database
        [self initDatabase];
        
        //  Initialization
        LoggerImplInitialized = [[WSLoggerImplInitialized alloc]init];
        LoggerImplUnInitialized = [[WSLoggerImplUnInitialized alloc]init];
        internalLogger = LoggerImplUnInitialized;

    }
    return self;
}
- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"-init is not a valid initializer for the class WSLogger. Kindly Use logger method to initialize AXlogger Object"
                                 userInfo:nil];
    return nil;
}

+(instancetype) logger
{
    if (!logger)
    {
        logger = [[WSLogger alloc]initFromInside];
    }
    return logger;
}
-(void) log:(WSLogEntry *) logEntry
{
    [internalLogger log:logEntry];
}
-(void) initDatabase
{
    NSLog(@"Copyng Logger database file into project");

    if ([self copyDbFile])     // Copy File First
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *DocDirPath = [paths objectAtIndex:0];
        NSString *path = [DocDirPath stringByAppendingPathComponent:LOGGERDBPATH];
        self.database = [FMDatabase databaseWithPath:path];
        NSLog(@"%@ Initialized",self.database);
        [self.database open];
    }
    else
    {
        NSLog(@"Database file Error: Unable to copy DB File in project.");
    }
}
-(BOOL) copyDbFile
{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *DocDirPath = [paths objectAtIndex:0];
    BOOL success;
    NSError *error;
    NSString *LoggerDB = [DocDirPath stringByAppendingPathComponent:LOGGERDBPATH];
    NSLog(@"DB Path : %@",LoggerDB);
    success = [manager fileExistsAtPath:LoggerDB];
    if ([manager fileExistsAtPath:LoggerDB])
    {
        return success;
    }
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *LoggerDBfilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:LOGGERDBPATH]; // test for existence.
    success = [manager copyItemAtPath:LoggerDBfilePath toPath:LoggerDB error:&error];
    NSAssert(success, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    return success;
}
-(instancetype) initWithSettings:(WSLoggerSettings *)loggerSettings
{
        self.settings = loggerSettings;
        internalLogger = LoggerImplInitialized;
        self.apiURL = [NSString stringWithFormat:@"%@/%@",self.settings.BaseURL,self.settings.APIName];
        return self;
}

-(NSMutableArray *) getAllLogEntries
{
   NSMutableArray  *logList = [NSMutableArray array];
    FMResultSet *resultSet= [[WSLogger logger].database executeQuery:@"select * from LogEntries"];
    if (resultSet)
    {
        while ([resultSet next])
        {
            WSLogEntry *logEntry = [[WSLogEntry alloc]initWithResultSet:resultSet];
            [logList addObject:logEntry];
        }
    }
    else
    {
        NSLog(@"Empty Database");
    }
    return logList;
}

-(void) clearRecords
{
    NSString *query = @"delete  from   LogEntries where   logEntrySerialNumber < (select MAX(logEntrySerialNumber)  from LogEntries)-10";
    if ([[WSLogger logger].database executeUpdate:query])
    {
        [self.delegate didLogRecordsDelete:@"Unable to delete records."];
        NSLog(@"All records Deleted except recent 10 or less than records.");
    }
    else
    {
        [self.delegate didLogRecordsDelete:@"Unable to delete records."];
        NSLog(@"Unable to delete records.");
    }
}
-(void) clearAllRecords
{
    if ([[WSLogger logger].database executeUpdate:@"delete  from   LogEntries "])
    {
        [self.delegate didLogRecordsDelete:@"All records Deleted"];
     NSLog(@"All records Deleted");
    }
    else
    {
        [self.delegate didLogRecordsDelete:@"Unable to delete records."];
        NSLog(@"Unable to delete records.");
    }
    
}
@end
