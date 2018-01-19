//
//  ProfileView.h
//  SlackTeamList
//
//  Created by Thomas on 2018-01-18.
//  Copyright © 2018 Slack Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailsView : UIView

    @property (strong, nonatomic)  UILabel *userPositionLabel;
    @property (strong, nonatomic)  UILabel *userLocalTimeLabel;
    @property (strong, nonatomic)  UIButton *userPhoneButton;
    @property (strong, nonatomic)  UIButton *userEmailButton;

    @property (strong, nonatomic)  UIButton *userMessageButton;
    @property (strong, nonatomic)  UIButton *userCallButton;
    @property (strong, nonatomic)  UIButton *userMoreButton;

    @property (strong, nonatomic)  UIImageView *userBackgroundImageView;
    @property (strong, nonatomic)  UILabel *userProfileName;
    @property (strong, nonatomic)  UILabel *userProfileDisplayName;

    @property (strong, nonatomic) UILabel *whatIDoLabel;
    @property (strong, nonatomic) UILabel *timeZoneLabel;
    @property (strong, nonatomic) UILabel *phoneLabel;
    @property (strong, nonatomic) UILabel *emailLabel;

@end
