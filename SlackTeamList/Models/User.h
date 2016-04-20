//
//  User.h
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSCoding>
{
    NSString *name;
    NSString *userid;

    BOOL deleted;
    
    BOOL is_admin;
    BOOL is_owner;
    BOOL has_files;
    BOOL has_2fa;
    NSString* presence;
    
    NSString* first_name;
    NSString* last_name;
    NSString* real_name;
    NSString* title;
    NSString* email;
    NSString* skype;
    NSString* phone;
    NSString* image_24;
    NSString* image_32;
    NSString* image_48;
    NSString* image_72;
    NSString* image_192;
}

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *userid;
@property (nonatomic) BOOL deleted;

@property (nonatomic) BOOL is_admin;
@property (nonatomic) BOOL is_owner;
@property (nonatomic) BOOL has_files;
@property (nonatomic) BOOL has_2fa;
@property (nonatomic) NSString* presence;

@property (nonatomic) NSString* first_name;
@property (nonatomic) NSString* last_name;
@property (nonatomic) NSString* real_name;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* email;
@property (nonatomic) NSString* skype;
@property (nonatomic) NSString* phone;
@property (nonatomic) NSString* image_24;
@property (nonatomic) NSString* image_32;
@property (nonatomic) NSString* image_48;
@property (nonatomic) NSString* image_72;
@property (nonatomic) NSString* image_192;


- (BOOL) isSlackBot;
- (NSString*) nameWithAtSymbol;
- (NSString*) titleWithNameFailover;
- (NSString*) realNameWithNameFailover;

- (void)encodeWithCoder:(NSCoder *)enCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (id)copyWithZone:(NSZone *)zone;

@end
