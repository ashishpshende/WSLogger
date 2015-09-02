//
//  WSLogEntryWidgetTableViewCell.m
//  Axonator
//
//  Created by Ashish on 31/08/15.
//  Copyright (c) 2015 WhiteSnow. All rights reserved.
//

#import "WSLogEntryWidgetTableViewCell.h"

@implementation WSLogEntryWidgetTableViewCell
{
    UILabel *keyLabel;
    UILabel *valueLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        keyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width/3, self.contentView.frame.size.height)];
        [self.contentView addSubview:keyLabel];
        [keyLabel setFont:[UIFont systemFontOfSize:12]];
        
        valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(keyLabel.frame.size.width, 0, self.contentView.frame.size.width- keyLabel.frame.size.width,  self.contentView.frame.size.height)];
        [self.contentView addSubview:valueLabel];
        [valueLabel setFont:[UIFont systemFontOfSize:13]];
    }
        return self;
}
-(void)setKeyValuePair:(WSLogEntryWidgetKeyValuePair *)keyValuePair
{
    [keyLabel setFrame:CGRectMake(0, 0, self.contentView.frame.size.width/2, self.contentView.frame.size.height)];
    [valueLabel setFrame:CGRectMake(keyLabel.frame.size.width, 0, self.contentView.frame.size.width- keyLabel.frame.size.width,  self.contentView.frame.size.height)];
     _keyValuePair = keyValuePair;
    [keyLabel setText:[NSString stringWithFormat:@" %@",_keyValuePair.key]];
    [valueLabel setText:[NSString stringWithFormat:@" %@",_keyValuePair.value]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
