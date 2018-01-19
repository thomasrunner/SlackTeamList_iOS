//
//  SlackAPI.m
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import "SlackAPI.h"

@implementation SlackAPI

-(NSString*) slackTeamURL :(NSString*)token
{
    NSString *urlstring = @"";

    urlstring = @"https://slack.com/api/users.list?token=";
    urlstring = [urlstring stringByAppendingString:[NSString stringWithFormat:@"%@",token]];
    urlstring = [urlstring stringByAppendingString:@"&presence=1"];
    return urlstring;
}

@end
