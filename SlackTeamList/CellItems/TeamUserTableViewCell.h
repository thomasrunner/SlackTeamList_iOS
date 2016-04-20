//
//  TeamUserTableViewCell.h
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamUserTableViewCell : UITableViewCell
{
    
    IBOutlet UILabel *userNameLabel;
    
    IBOutlet UILabel *userPositionLabel;
    IBOutlet UIImageView *userProfileImageView;
    
    IBOutlet UIImageView *miniPhoneImageView;
    IBOutlet UIImageView *miniSkypeImageView;
    IBOutlet UIImageView *miniEmailImageView;
    
}

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userPositionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userProfileImageView;

@property (strong, nonatomic) IBOutlet UIImageView *miniPhoneImageView;
@property (strong, nonatomic) IBOutlet UIImageView *miniSkypeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *miniEmailImageView;

@end
