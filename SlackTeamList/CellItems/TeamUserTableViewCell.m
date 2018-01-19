//
//  TeamUserTableViewCell.m
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import "TeamUserTableViewCell.h"

@implementation TeamUserTableViewCell

-(void)initView
{
    self.frame = CGRectMake(0, 0, self.frame.size.width, 60.0f);

    self.backgroundColor = [UIColor whiteColor];
    _miniPhoneImageView = [[UIImageView alloc] init];
    _miniSkypeImageView = [[UIImageView alloc] init];
    _miniEmailImageView = [[UIImageView alloc] init];
    
    _miniSkypeImageView.image = [UIImage imageNamed:@"skype-32"];
    _miniSkypeImageView.layer.opacity = 0.5f;
    _miniPhoneImageView.image = [UIImage imageNamed:@"phone-32"];
    _miniPhoneImageView.layer.opacity = 0.5f;
    _miniEmailImageView.image = [UIImage imageNamed:@"email-32"];
    _miniEmailImageView.layer.opacity = 0.5f;
    
    [self addSubview:_miniPhoneImageView];
    [self addSubview:_miniEmailImageView];
    [self addSubview:_miniSkypeImageView];
    
    [_miniPhoneImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_miniSkypeImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_miniEmailImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *miniImageViewDictionary = @{@"phone" : _miniPhoneImageView, @"skype" : _miniSkypeImageView, @"email" : _miniEmailImageView};
    
    NSArray *viewVerticalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[phone(==16)]" options:0 metrics:nil views:miniImageViewDictionary];
    
    [self addConstraints:viewVerticalLayout];
    
    NSArray *viewVerticalLayout1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[skype(==16)]" options:0 metrics:nil views:miniImageViewDictionary];
    
    [self addConstraints:viewVerticalLayout1];
    
    NSArray *viewVerticalLayout2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[email(==16)]" options:0 metrics:nil views:miniImageViewDictionary];
    
    [self addConstraints:viewVerticalLayout2];
    
    NSArray *viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"[phone(==16)]-5-|" options:0 metrics:nil views:miniImageViewDictionary];
    
    [self addConstraints:viewHorizontalLayout];
    
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"[skype(==16)]-5-[phone]" options:0 metrics:nil views:miniImageViewDictionary];
    
    [self addConstraints:viewHorizontalLayout];
    
    viewHorizontalLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"[email(==16)]-6-[skype]" options:0 metrics:nil views:miniImageViewDictionary];
    
    [self addConstraints:viewHorizontalLayout];
    
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(66, 8, 171, 21)];
    _userNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0];
    
    [self addSubview:_userNameLabel];
    
    _userPositionLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 29, 242, 21)];
    _userPositionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    [self addSubview:_userPositionLabel];
    _userPositionLabel.textColor = [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];
    
    _userProfileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 7, 48, 48)];
    
    [self addSubview:_userProfileImageView];
}

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
