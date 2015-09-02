//
//  WSLoggerImplInitialized.m
//  Axonator
//
//  Created by Ashish on 31/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLoggerImplInitialized.h"
#import "AFNetworking.h"
@implementation WSLoggerImplInitialized
-(void) log:(WSLogEntry *)logEntry
{
//    [logEntry print];
    [logEntry save];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"%@",[logEntry toDictionary]);
    [manager POST:[WSLogger logger].apiURL parameters:[logEntry toDictionary] constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //Add Files to Multipart
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
          [self.delegate didSuceedLogging:responseObject];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate didFailedLoggingWithReason:error.localizedDescription];
     }];
    
}
@end
