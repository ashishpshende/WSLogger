//
//  WSLogTableViewCell.h
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSLogEntry.h"
@interface WSLogTableViewCell : UITableViewCell
@property (nonatomic,strong) WSLogEntry *logEntry;
@end
