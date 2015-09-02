//
//  WSLogEntryWidgetKeyValuePair.m
//  Axonator
//
//  Created by Ashish on 31/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLogEntryWidgetKeyValuePair.h"

@implementation WSLogEntryWidgetKeyValuePair
@synthesize key;
@synthesize value;
-(void) print
{
    NSLog(@"KEY : %@ \tVALUE: %@",self.key,self.value);
}
@end
