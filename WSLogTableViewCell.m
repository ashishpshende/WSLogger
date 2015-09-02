//
//  WSLogTableViewCell.m
//  Axonator
//
//  Created by Ashish on 30/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLogTableViewCell.h"

@implementation WSLogTableViewCell
{
    UILabel *logEntrySrNo;
    UILabel *logEntryCode;
    UILabel *logEntryMessage;
    UILabel *logEntryType;
    
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        logEntrySrNo = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, self.contentView.frame.size.height)];
        [self.contentView addSubview:logEntrySrNo];
        [logEntrySrNo setTextAlignment:NSTextAlignmentCenter];
 
        
        logEntryMessage = [[UILabel alloc]initWithFrame:CGRectMake(logEntrySrNo.frame.size.width, 0, self.contentView.frame.size.width - logEntrySrNo.frame.size.width, self.contentView.frame.size.height/2)];
        [self.contentView addSubview:logEntryMessage];
  
        
        logEntryCode = [[UILabel alloc]initWithFrame:CGRectMake(logEntrySrNo.frame.size.width, logEntryMessage.frame.size.height, logEntryMessage.frame.size.width/2, self.contentView.frame.size.height/2)];
        [self.contentView addSubview:logEntryCode];
        [logEntryCode setTextAlignment:NSTextAlignmentCenter];
        
        logEntryType = [[UILabel alloc]initWithFrame:CGRectMake(logEntryCode.frame.origin.x+logEntryCode.frame.size.width, logEntryMessage.frame.size.height, logEntryMessage.frame.size.width/2, self.contentView.frame.size.height/2)];
        [self.contentView addSubview:logEntryType];
        [logEntryType setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}
-(void) setCellFrame
{
    [logEntrySrNo setFrame:CGRectMake(0, 0, 20, self.contentView.frame.size.height)];
    [logEntryMessage setFrame:CGRectMake(logEntrySrNo.frame.size.width, 0, self.contentView.frame.size.width - logEntrySrNo.frame.size.width, self.contentView.frame.size.height/2)];
    [logEntryCode setFrame:CGRectMake(logEntrySrNo.frame.size.width, logEntryMessage.frame.size.height, logEntryMessage.frame.size.width/2, self.contentView.frame.size.height/2)];
    [logEntryType setFrame:CGRectMake(logEntryCode.frame.origin.x+logEntryCode.frame.size.width, logEntryMessage.frame.size.height, logEntryCode.frame.size.width, self.contentView.frame.size.height/2)];
}
-(void) setLogEntry:(WSLogEntry *)logEntry
{
    [self setCellFrame];
    _logEntry = logEntry;
    [logEntrySrNo setText:[NSString stringWithFormat:@"%ld",logEntry.logEntrySerialNumber]];
    [logEntryCode setText:[NSString stringWithFormat:@"Code: %ld",logEntry.logEntryCode]];
    [logEntryType setText:[NSString stringWithFormat:@"Type: %ld",(long)logEntry.logEntryType]];
    [logEntryMessage setText:logEntry.logEntryMessage];
    
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
