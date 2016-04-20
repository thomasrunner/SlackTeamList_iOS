//
//  TeamUserTableViewCell.m
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import "TeamUserTableViewCell.h"

@implementation TeamUserTableViewCell
@synthesize userNameLabel;
@synthesize userPositionLabel;
@synthesize userProfileImageView;
@synthesize miniPhoneImageView;
@synthesize miniSkypeImageView;
@synthesize miniEmailImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
