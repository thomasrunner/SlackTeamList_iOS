//
//  User.m
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize name;
@synthesize deleted;
@synthesize is_admin;
@synthesize is_owner;
@synthesize has_files;
@synthesize has_2fa;
@synthesize presence;
@synthesize userid;

@synthesize first_name;
@synthesize last_name;
@synthesize real_name;
@synthesize title;
@synthesize email;
@synthesize skype;
@synthesize phone;
@synthesize image_24;
@synthesize image_32;
@synthesize image_48;
@synthesize image_72;
@synthesize image_192;

-(id)init
{
    self = [super init];
    
    if(self)
    {
        userid = @"";
        name = @"";
        deleted = false;
        is_admin = false;
        is_owner = false;
        has_files = false;
        has_2fa = false;
        presence = @"";
        first_name = @"";
        last_name = @"";
        real_name = @"";
        title = @"";
        email = @"";
        skype = @"";
        phone = @"";
        image_24 = @"";
        image_32 = @"";
        image_48 = @"";
        image_72 = @"";
        image_192 = @"";
        

    }
    return self;
}

- (BOOL) isSlackBot
{
    if([userid isEqualToString:@"USLACKBOT"])
    {
        return true;
    }
    return false;
}

- (NSString*) nameWithAtSymbol
{
    NSString *fancyName = @"@";
    return  [fancyName stringByAppendingString: self.name];
}


/// Since Title can be "" this allows for a failover
- (NSString*) titleWithNameFailover
{

    if([title length] > 0)
    {
        return title;
    }
    else
    {
        if (![self isSlackBot])
        {
            return [self nameWithAtSymbol];
        }
        else
        {
            return @"";
        }
    }
}


/// Since Title can be "" this allows for a failover
- (NSString*) realNameWithNameFailover
{
    if ([real_name length] > 0)
    {
        return real_name;
    }
    else
    {
        if (![self isSlackBot])
        {
            return [self nameWithAtSymbol];
        }
        else
        {
            return @"";
        }
    }
}



- (void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.userid forKey:@"userid"];
    
    [coder encodeObject:self.name forKey:@"name"];
    
    [coder encodeBool:self.deleted forKey:@"deleted"];
    
    [coder encodeBool:self.is_admin forKey:@"is_admin"];
    
    [coder encodeBool:self.is_owner forKey:@"is_owner"];
    
    [coder encodeBool:self.has_files forKey:@"has_files"];
    
    [coder encodeBool:self.has_2fa forKey:@"has_2fa"];
    
    [coder encodeObject:self.presence forKey:@"presence"];
    
    [coder encodeObject:self.first_name forKey:@"first_name"];
    
    [coder encodeObject:self.last_name forKey:@"last_name"];
    
    [coder encodeObject:self.real_name forKey:@"real_name"];
    
    [coder encodeObject:self.title forKey:@"title"];
    
    [coder encodeObject:self.email forKey:@"email"];
    
    [coder encodeObject:self.skype forKey:@"skype"];
    
    [coder encodeObject:self.phone forKey:@"phone"];
    
    [coder encodeObject:self.image_24 forKey:@"image_24"];
    
    [coder encodeObject:self.image_32 forKey:@"image_32"];
    
    [coder encodeObject:self.image_48 forKey:@"image_48"];
    
    [coder encodeObject:self.image_72 forKey:@"image_72"];
    
    [coder encodeObject:self.image_192 forKey:@"image_192"];
    
}



- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {

        self.userid = [aDecoder decodeObjectForKey:@"userid"];
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.deleted = [aDecoder decodeBoolForKey:@"deleted"];
        
        self.is_admin = [aDecoder decodeBoolForKey:@"is_admin"];
        
        self.is_owner = [aDecoder decodeBoolForKey:@"is_owner"];
        
        self.has_files = [aDecoder decodeBoolForKey:@"has_files"];
        
        self.has_2fa = [aDecoder decodeBoolForKey:@"has_2fa"];
        
        self.presence = [aDecoder decodeObjectForKey:@"presence"];
        
        self.first_name = [aDecoder decodeObjectForKey:@"first_name"];
        
        self.last_name = [aDecoder decodeObjectForKey:@"last_name"];
        
        self.real_name = [aDecoder decodeObjectForKey:@"real_name"];
        
        self.title = [aDecoder decodeObjectForKey:@"title"];
        
        self.email = [aDecoder decodeObjectForKey:@"email"];
        
        self.skype = [aDecoder decodeObjectForKey:@"skype"];
        
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        
        self.image_24 = [aDecoder decodeObjectForKey:@"image_24"];
        
        self.image_32 = [aDecoder decodeObjectForKey:@"image_32"];
        
        self.image_48 = [aDecoder decodeObjectForKey:@"image_48"];
        
        self.image_72 = [aDecoder decodeObjectForKey:@"image_72"];
        
        self.image_192 = [aDecoder decodeObjectForKey:@"image_192"];
        
    }
    
    return self;
}


- (id)copyWithZone:(NSZone *)zone {
    
    User *copy = [[[self class] allocWithZone:zone] init];
    
    copy.userid = self.userid;
    
    copy.name = self.name;
    
    copy.deleted = self.deleted;
    
    copy.is_admin = self.is_admin;
    
    copy.is_owner = self.is_owner;
    
    copy.has_files = self.has_files;
    
    copy.has_2fa = self.has_2fa;
    
    copy.presence = self.presence;
    
    copy.first_name = self.first_name;
    
    copy.last_name = self.last_name;
    
    copy.real_name = self.real_name;
    
    copy.title = self.title;
    
    copy.email = self.email;
    
    copy.skype = self.skype;
    
    copy.phone = self.phone;
    
    copy.image_24 = self.image_24;
    
    copy.image_32 = self.image_32;
    
    copy.image_48 = self.image_48;
    
    copy.image_72 = self.image_72;
    
    copy.image_192 = self.image_192;
    
    return copy;
}

@end
