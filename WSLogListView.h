//
//  WSLogListView.h
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLoggerViewDelegate.h"
#import "WSLogger.h"
@interface WSLogListView : UIView <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIViewController *parentVC;
@property (nonatomic) BOOL showMeList;
@property (nonatomic,strong) id <WSLoggerViewDelegate> delegate;
-(void) refreshView;
@end
