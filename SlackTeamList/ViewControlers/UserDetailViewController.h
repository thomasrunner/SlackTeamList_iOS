//
//  UserDetailViewController.h
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserDetailViewController : UIViewController
{
    User *selectedUser;
    IBOutlet UILabel *userPositionLabel;
    IBOutlet UILabel *userLocalTimeLabel;
    IBOutlet UIButton *userPhoneButton;
    IBOutlet UIButton *userEmailButton;
    IBOutlet UIImageView *userBackgroundImageView;
    IBOutlet UILabel *userProfileName;
    IBOutlet UILabel *userProfileDisplayName;
    
}

@property (strong, nonatomic) User *selectedUser;
@property (strong, nonatomic) IBOutlet UILabel *userPositionLabel;

@property (strong, nonatomic) IBOutlet UILabel *userLocalTimeLabel;
@property (strong, nonatomic) IBOutlet UIButton *userPhoneButton;
@property (strong, nonatomic) IBOutlet UIButton *userEmailButton;
@property (strong, nonatomic) IBOutlet UIImageView *userBackgroundImageView;
@property (strong, nonatomic) IBOutlet UILabel *userProfileName;
@property (strong, nonatomic) IBOutlet UILabel *userProfileDisplayName;


- (IBAction)messageButton:(id)sender;
- (IBAction)callButton:(id)sender;
- (IBAction)moreButton:(id)sender;
- (IBAction)userPhoneButton:(id)sender;
- (IBAction)userEmailButton:(id)sender;

@end
