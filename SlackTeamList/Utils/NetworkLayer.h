//
//  NetworkLayer.h
//  SlackTeamList
//
//  Created by Thomas on 2018-01-16.
//  Copyright © 2018 Slack Demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlackAPI.h"

typedef void(^completionBlock)(NSMutableArray *);


@interface NetworkLayer : SlackAPI

    -(void) downloadSlackTeamWithForce:(Boolean)forceDownload : (completionBlock)finished;

@end
