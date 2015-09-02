//
//  WSLogEntryWidgetKeyValuePair.h
//  Axonator
//
//  Created by Ashish on 31/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSLogEntryWidgetKeyValuePair : NSObject
@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *value;
-(void) print;
@end
