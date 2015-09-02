//
//  WSLogEntry.m
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "WSLogEntry.h"
#import "FMDatabase.h"

#import "WSLogger.h"

@implementation WSLogEntry
@synthesize logEntrySerialNumber;
@synthesize  logEntryCode;
@synthesize logEntryType;
@synthesize logEntryMessage;
@synthesize logEntryDescription;
@synthesize dateTime;
@synthesize ipAddress;
@synthesize longitude;
@synthesize latiitude;
@synthesize parameters;

-(instancetype)init
{
    self = [super init];
    if (self)
    {
    
        self.logEntrySerialNumber = [self getcurrentIndex];
        self.logEntryCode =100;
        self.logEntryType =WSActivity;
        self.logEntryMessage = @"";
        self.logEntryDescription = @"";
        

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        NSDate *currentDate = [NSDate date];
        NSString *DateTimeString =[dateFormatter  stringFromDate:currentDate];
        [dateFormatter setDateFormat:@"HH:mm:ss.SSS aa"];
        self.dateTime = [NSString stringWithFormat:@"%@ %@",DateTimeString,[dateFormatter stringFromDate:currentDate]];
        

        self.ipAddress = [self getIPAddress];
        self.longitude = 0;
        self.latiitude = 0;
        self.parameters =@{
                           @"one":@"Five - Four",
                           @"Two":@"Five - Three",
                           @"Three":@"Five - Two",
                           @"Four": @"Five - One",
                           @"Five" : @"Five - Zero"
                           };
    }
    return self;
}
-(long) getcurrentIndex
{
    long index=0;
    NSString *query =@"select * from    LogEntries where   logEntrySerialNumber = (select MAX(logEntrySerialNumber)  from LogEntries);";
    FMResultSet *resultSet  =  [[WSLogger logger].database executeQuery:query];
    if (resultSet)
    {
        while ([resultSet next])
        {
            index = [resultSet longForColumn:@"logEntrySerialNumber"];
        }
    }
    return index+1;
}
-(instancetype) initWithResultSet:(FMResultSet *)resultSet
{
    self = [super init];
    if (self)
    {
        self.logEntrySerialNumber = [resultSet longForColumn:@"logEntrySerialNumber"];
        self.logEntryCode = [resultSet longForColumn:@"logEntryCode"];
        self.logEntryType =(WSLogEntryType) [resultSet longForColumn:@"logEntryType"];
        self.logEntryMessage = [resultSet stringForColumn:@"logEntryMessage"];
        self.logEntryDescription = [resultSet stringForColumn:@"logEntryDescription"];
        self.parameters =[self stringToDictionary:[resultSet stringForColumn:@"parameters"]];
        self.dateTime = [resultSet stringForColumn:@"dateTime"];
        self.ipAddress = [resultSet stringForColumn:@"ipAddress"];
        self.longitude = [resultSet doubleForColumn:@"longitude"];
        self.latiitude = [resultSet doubleForColumn:@"latiitude"];
    }
    return self;
}
-(void) print
{
            NSLog(@"SERIAL NUMBER : %ld",self.logEntrySerialNumber);
            NSLog(@"ENTRY CODE : %ld",self.logEntryCode);
            NSLog(@"TYPE : %ld",(long) self.logEntryType);
            NSLog(@"MESSAGE : %@",self.logEntryMessage);
            NSLog(@"DESCRIPTION : %@",self.logEntryDescription);
            NSLog(@"DATE & TIME : %@",self.dateTime);
            NSLog(@"IP ADDRESS : %@",self.ipAddress);
            NSLog(@"LOGITUDE : %f",self.longitude);
            NSLog(@"LATITUDE : %f",self.latiitude);
            NSLog(@"PARAMETERS : %@",self.parameters);
}

-(NSDictionary *) stringToDictionary:(NSString *) String
{
    NSError *error;
    NSData *data = [String dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    return json;
}
-(NSString *) dictionaryToString:(NSDictionary *)dict
{
    NSError * err;
    NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dict options:0 error:&err];
    NSString * String = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
    return  String;
}
-(void) save
{
    NSString *query = @"insert into LogEntries values (?,?,?,?,?,?,?,?,?,?)";
    [[WSLogger logger].database executeUpdate:query,[NSNumber numberWithLong:self.logEntrySerialNumber],[NSNumber numberWithLong:self.logEntryCode],[NSNumber numberWithInt:self.logEntryType],self.logEntryMessage,self.self.logEntryDescription,self.dateTime,self.ipAddress,[NSNumber numberWithDouble:self.longitude],[NSNumber numberWithDouble:self.latiitude],[self dictionaryToString:self.parameters]];
    NSLog(@"LogEntry Create in Local DB, logEntrySerialNumber:%ld",self.logEntrySerialNumber);
}

-(NSDictionary *) toDictionary
{
    NSDictionary *dictionary =
                                @{
                                @"serial_number":[NSNumber numberWithLong:self.logEntrySerialNumber],
                                @"entry_code":[NSNumber numberWithLong:self.logEntryCode],
                                @"type":[NSNumber numberWithLong:(long) self.logEntryType],
                                @"message":self.logEntryMessage,
                                @"desc":self.logEntryDescription,
                                @"date_time":self.dateTime,
                                @"ip_address":self.ipAddress,
                                @"longitude":[NSNumber numberWithDouble:self.longitude],
                                @"latitude":[NSNumber numberWithDouble:self.latiitude],
                                @"params":self.parameters
                                };
    
    return dictionary;
}


- (NSString *)getIPAddress
{
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
@end
