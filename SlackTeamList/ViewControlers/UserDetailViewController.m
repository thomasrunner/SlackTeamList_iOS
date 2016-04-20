//
//  UserDetailViewController.m
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()



@end

@implementation UserDetailViewController
@synthesize selectedUser;
@synthesize userPositionLabel;
@synthesize userEmailButton;
@synthesize userLocalTimeLabel;
@synthesize userPhoneButton;
@synthesize userBackgroundImageView;
@synthesize userProfileName;
@synthesize userProfileDisplayName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self downloadTeamMember];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Display Member Details
-(void) downloadTeamMember {
    
    NSURL * url = [NSURL URLWithString:selectedUser.image_192];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    if(data !=nil)
    {
        userBackgroundImageView.image = [UIImage imageWithData:data];
    }
    
    userProfileName.text = [selectedUser realNameWithNameFailover];
    userProfileDisplayName.text = [selectedUser nameWithAtSymbol];
    userPositionLabel.text = [selectedUser titleWithNameFailover];
    
    [userPhoneButton setTitle: selectedUser.phone forState:UIControlStateNormal];
    [userEmailButton setTitle: selectedUser.email forState:UIControlStateNormal];
}



- (IBAction)messageButton:(id)sender {
    
}

- (IBAction)callButton:(id)sender {
    
}

- (IBAction)moreButton:(id)sender {
    
}

- (IBAction)userPhoneButton:(id)sender {
    
}

- (IBAction)userEmailButton:(id)sender {
    
}
@end
