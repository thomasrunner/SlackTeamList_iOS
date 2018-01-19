//
//  ProfileView.m
//  SlackTeamList
//
//  Created by Thomas on 2018-01-18.
//  Copyright © 2018 Slack Demo. All rights reserved.
//

#import "UserDetailsView.h"

@implementation UserDetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self alignBackgroundImageAndLabels];
        [self alignMessageAndCallButtons];
        [self alignProfileDataLabels];
    }
    return self;
}

-(void) alignBackgroundImageAndLabels
{
    //Background Image
    _userBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 199)];
    _userBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _userBackgroundImageView.clipsToBounds = YES;
    [_userBackgroundImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userBackgroundImageView];
    
    NSArray *viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|[background]|" options:0 metrics:nil views:@{@"background" : _userBackgroundImageView}];
    [self addConstraints:viewHorizontalLayout];
    
    NSArray *viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[background(199)]" options:0 metrics:nil views:@{@"background" : _userBackgroundImageView}];
    [self addConstraints:viewVerticalLayout];
    
    //User Profile Info
    _userProfileName = [[UILabel alloc] initWithFrame:CGRectMake(10, 144, 310, 21)];
    _userProfileName.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
    _userProfileName.textColor = [UIColor whiteColor];
    [_userProfileName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userProfileName];
    
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[profilename]|" options:0 metrics:nil views:@{@"profilename" : _userProfileName}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-144-[profilename(21)]" options:0 metrics:nil views:@{@"profilename" : _userProfileName}];
    [self addConstraints:viewVerticalLayout];
    
    _userProfileDisplayName = [[UILabel alloc] initWithFrame:CGRectMake(10, 166, 310, 21)];
    _userProfileDisplayName.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    _userProfileDisplayName.textColor = [UIColor whiteColor];
    [_userProfileDisplayName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userProfileDisplayName];
    
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[profiledisplayname]|" options:0 metrics:nil views:@{@"profiledisplayname" : _userProfileDisplayName}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-166-[profiledisplayname(21)]" options:0 metrics:nil views:@{@"profiledisplayname" : _userProfileDisplayName}];
    [self addConstraints:viewVerticalLayout];
}

-(void)alignMessageAndCallButtons
{
    //Top Button Row
    _userMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 212, 110, 30)];
    [_userMessageButton setTitle:@"Message" forState:UIControlStateNormal];
    _userMessageButton.hidden = false;
    _userMessageButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
    _userMessageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_userMessageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_userMessageButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userMessageButton];
    
    NSArray *viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-212-[userMessageButton(30)]" options:0 metrics:nil views:@{@"userMessageButton" : _userMessageButton}];
    [self addConstraints:viewVerticalLayout];
    
    _userCallButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 212, 110, 30)];
    [_userCallButton setTitle:@"Call" forState:UIControlStateNormal];
    _userCallButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17.0];
    _userCallButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_userCallButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_userCallButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userCallButton];
    
    NSArray *viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[userMessageButton(110)]-20-[userCallButton(110)]" options:0 metrics:nil views:@{@"userMessageButton" : _userMessageButton, @"userCallButton" : _userCallButton}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-212-[userCallButton(30)]" options:0 metrics:nil views:@{@"userCallButton" : _userCallButton}];
    [self addConstraints:viewVerticalLayout];
}

-(void)alignProfileDataLabels
{
    //Data Labels
    _userPositionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 289, 310, 21)];
    _userPositionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    [_userPositionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userPositionLabel];
    
    NSArray *viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[userPositionLabel]|" options:0 metrics:nil views:@{@"userPositionLabel" : _userPositionLabel}];
    [self addConstraints:viewHorizontalLayout];
    
    NSArray *viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-289-[userPositionLabel(21)]" options:0 metrics:nil views:@{@"userPositionLabel" : _userPositionLabel}];
    [self addConstraints:viewVerticalLayout];
    
    _userLocalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 352, 300, 21)];
    _userLocalTimeLabel.text = @"12:00 PM local time";
    _userLocalTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    [_userLocalTimeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userLocalTimeLabel];
    
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[userLocalTimeLabel]|" options:0 metrics:nil views:@{@"userLocalTimeLabel" : _userLocalTimeLabel}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-352-[userLocalTimeLabel(21)]" options:0 metrics:nil views:@{@"userLocalTimeLabel" : _userLocalTimeLabel}];
    [self addConstraints:viewVerticalLayout];
    
    _userPhoneButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 416, 300, 30)];
    _userPhoneButton.titleLabel.text = @"(555) 555 5555";
    _userPhoneButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    _userPhoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_userPhoneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_userPhoneButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userPhoneButton];
    
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[userPhoneButton]|" options:0 metrics:nil views:@{@"userPhoneButton" : _userPhoneButton}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-416-[userPhoneButton(30)]" options:0 metrics:nil views:@{@"userPhoneButton" : _userPhoneButton}];
    [self addConstraints:viewVerticalLayout];
    
    _userEmailButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 482, 300, 30)];
    _userEmailButton.titleLabel.text = @"12:00 PM local time";
    _userEmailButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    [_userEmailButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _userEmailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_userEmailButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_userEmailButton];
    
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[userEmailButton]|" options:0 metrics:nil views:@{@"userEmailButton" : _userEmailButton}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-482-[userEmailButton(30)]" options:0 metrics:nil views:@{@"userEmailButton" : _userEmailButton}];
    [self addConstraints:viewVerticalLayout];
    
    //Fixed Label
    _whatIDoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 74, 21)];
    _whatIDoLabel.text = NSLocalizedString(@"What I do",nil);
    _whatIDoLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    _whatIDoLabel.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
    [_whatIDoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_whatIDoLabel];
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[whatIDoLabel]|" options:0 metrics:nil views:@{@"whatIDoLabel" : _whatIDoLabel}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-260-[whatIDoLabel(21)]" options:0 metrics:nil views:@{@"whatIDoLabel" : _whatIDoLabel}];
    [self addConstraints:viewVerticalLayout];
    
    _timeZoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 323, 74, 21)];
    _timeZoneLabel.text = NSLocalizedString(@"Timezone",nil);
    _timeZoneLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    _timeZoneLabel.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
    [_timeZoneLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_timeZoneLabel];
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[timeZoneLabel]|" options:0 metrics:nil views:@{@"timeZoneLabel" : _timeZoneLabel}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-323-[timeZoneLabel(21)]" options:0 metrics:nil views:@{@"timeZoneLabel" : _timeZoneLabel}];
    [self addConstraints:viewVerticalLayout];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 387, 74, 21)];
    _phoneLabel.text = NSLocalizedString(@"Phone",nil);
    _phoneLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    _phoneLabel.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
    [_phoneLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_phoneLabel];
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[phoneLabel]|" options:0 metrics:nil views:@{@"phoneLabel" : _phoneLabel}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-387-[phoneLabel(21)]" options:0 metrics:nil views:@{@"phoneLabel" : _phoneLabel}];
    [self addConstraints:viewVerticalLayout];
    
    _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 453, 74, 21)];
    _emailLabel.text = NSLocalizedString(@"Email",nil);
    _emailLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    _emailLabel.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
    [_emailLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_emailLabel];
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[emailLabel]|" options:0 metrics:nil views:@{@"emailLabel" : _emailLabel}];
    [self addConstraints:viewHorizontalLayout];
    
    viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-453-[emailLabel]" options:0 metrics:nil views:@{@"emailLabel" : _emailLabel}];
    [self addConstraints:viewVerticalLayout];
}
@end
