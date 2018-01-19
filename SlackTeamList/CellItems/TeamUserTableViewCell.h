//
//  TeamUserTableViewCell.h
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamUserTableViewCell : UITableViewCell

@property (strong, nonatomic)  UILabel *userNameLabel;
@property (strong, nonatomic)  UILabel *userPositionLabel;
@property (strong, nonatomic)  UIImageView *userProfileImageView;

@property (strong, nonatomic)  UIImageView *miniPhoneImageView;

@property (strong, nonatomic)  UIImageView *miniEmailImageView;
@property (strong, nonatomic)  UIImageView *miniSkypeImageView;
-(void)initView;

@end
