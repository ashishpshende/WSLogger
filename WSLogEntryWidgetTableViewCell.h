//
//  WSLogEntryWidgetTableViewCell.h
//  Axonator
//
//  Created by Ashish on 31/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSLogEntryWidgetKeyValuePair.h"
@interface WSLogEntryWidgetTableViewCell : UITableViewCell
@property (nonatomic,strong) WSLogEntryWidgetKeyValuePair *keyValuePair;
@end
