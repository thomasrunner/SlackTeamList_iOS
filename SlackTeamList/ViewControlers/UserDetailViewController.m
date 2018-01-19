//
//  UserDetailViewController.m
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserDetailsView.h"

@interface UserDetailViewController()

    @property (nonatomic, strong) UserDetailsView *view;

@end

@implementation UserDetailViewController
@synthesize view;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    self.view = [[UserDetailsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets =  NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;

    [self downloadTeamMember];
}

#pragma mark - Display Member Details
-(void) downloadTeamMember {
    
    NSURL * url = [NSURL URLWithString:_selectedUser.image_192];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    if(data !=nil)
    {
        self.view.userBackgroundImageView.image = [UIImage imageWithData:data];
    }
    
    self.view.userProfileName.text = [_selectedUser realNameWithNameFailover];
    self.view.userProfileDisplayName.text = [_selectedUser nameWithAtSymbol];
    self.view.userPositionLabel.text = [_selectedUser titleWithNameFailover];
    
    [self.view.userPhoneButton setTitle: _selectedUser.phone forState:UIControlStateNormal];
    [self.view.userEmailButton setTitle: _selectedUser.email forState:UIControlStateNormal];
}


@end
