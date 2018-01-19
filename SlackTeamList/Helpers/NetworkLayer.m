//
//  NetworkLayer.m
//  SlackTeamList
//
//  Created by Thomas on 2018-01-16.
//  Copyright © 2018 Slack Demo. All rights reserved.
//

#import "NetworkLayer.h"
#import "FileCache.h"
#import "User.h"

@implementation NetworkLayer


-(void) downloadSlackTeamWithForce:(Boolean)forceDownload : (completionBlock)finished
{
    FileCache *fileCache = [[FileCache alloc] init];
    //Caching
    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"slack"];
    // New Folder is your folder name
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *cacheFileName = [stringPath stringByAppendingFormat:@"%@",[fileCache teamData]];
    //NSLog(@"%@",cacheFileName);
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:cacheFileName];
    NSMutableArray *teamUserArray;
    if(!forceDownload && fileExists)
    {
        teamUserArray = [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFileName];
        finished(teamUserArray);
    }
    else
    {
        teamUserArray = [[NSMutableArray alloc] init];
        NSString *urlString = [self slackTeamURL:@"xoxp-5048173296-5048487710-19045732087-b5427e3b46"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(data != nil)
            {
                //Parse JSON data to Stream Model
                NSError *parseerror;
                NSMutableDictionary *teamDic = [NSJSONSerialization
                                                JSONObjectWithData:data
                                                options:NSJSONReadingMutableContainers
                                                error:&parseerror];
                if ([teamDic valueForKey:@"ok"]){
                    
                    NSArray *teamMembers = [teamDic objectForKey:@"members"];
                    
                    for (NSDictionary *member in teamMembers)
                    {
                        User *teamMember = [[User alloc] init];
                        
                        teamMember.userid = [member objectForKey:@"id"];
                        teamMember.name = [member objectForKey:@"name"];
                        
                        if([member objectForKey:@"deleted"] != [NSNull null])
                        {
                            if ([member objectForKey:@"deleted"])
                            {
                                teamMember.deleted = true;
                            }
                        }
                        
                        if([member objectForKey:@"is_admin"] != [NSNull null])
                        {
                            if ([member objectForKey:@"is_admin"])
                            {
                                teamMember.is_admin = true;
                            }
                        }
                        
                        if([member objectForKey:@"is_owner"] != [NSNull null])
                        {
                            if ([member objectForKey:@"is_owner"])
                            {
                                teamMember.is_owner = true;
                            }
                        }
                        
                        if([member objectForKey:@"has_files"] != [NSNull null])
                        {
                            if ([member objectForKey:@"has_files"])
                            {
                                teamMember.has_files = true;
                            }
                        }
                        
                        if([member objectForKey:@"has_2fa"] != [NSNull null])
                        {
                            if ([member objectForKey:@"has_2fa"])
                            {
                                teamMember.has_2fa = true;
                            }
                        }
                        
                        if([member objectForKey:@"presence"] != [NSNull null])
                        {
                            if (![[member objectForKey:@"presence"] isEqualToString: @""])
                            {
                                teamMember.presence = (NSString*)[member objectForKey:@"presence"];
                            }
                        }
                        
                        
                        //User Profile Class which is a subclass of User
                        NSDictionary *profileDic = [member objectForKey:@"profile"];
                        
                        if([profileDic objectForKey:@"first_name"] != [NSNull null])
                        {
                            teamMember.first_name = (NSString*)[profileDic objectForKey:@"first_name"];
                        }
                        
                        if([profileDic objectForKey:@"last_name"] != [NSNull null])
                        {
                            teamMember.last_name = (NSString*)[profileDic objectForKey:@"last_name"];
                        }
                        
                        if([profileDic objectForKey:@"real_name"] != [NSNull null])
                        {
                            teamMember.real_name = (NSString*)[profileDic objectForKey:@"real_name"];
                        }
                        
                        if([profileDic objectForKey:@"title"] != [NSNull null])
                        {
                            teamMember.title = (NSString*)[profileDic objectForKey:@"title"];
                        }
                        
                        if([profileDic objectForKey:@"email"] != [NSNull null])
                        {
                            teamMember.email = (NSString*)[profileDic objectForKey:@"email"];
                        }
                        
                        if([profileDic objectForKey:@"skype"] != [NSNull null])
                        {
                            teamMember.skype = (NSString*)[profileDic objectForKey:@"skype"];
                        }
                        
                        if([profileDic objectForKey:@"phone"] != [NSNull null])
                        {
                            teamMember.phone = (NSString*)[profileDic objectForKey:@"phone"];
                        }
                        
                        if([profileDic objectForKey:@"image_24"] != [NSNull null])
                        {
                            teamMember.image_24 = (NSString*)[profileDic objectForKey:@"image_24"];
                        }
                        
                        if([profileDic objectForKey:@"image_32"] != [NSNull null])
                        {
                            teamMember.image_32 = (NSString*)[profileDic objectForKey:@"image_32"];
                        }
                        
                        if([profileDic objectForKey:@"image_48"] != [NSNull null])
                        {
                            teamMember.image_48 = (NSString*)[profileDic objectForKey:@"image_48"];
                        }
                        
                        if([profileDic objectForKey:@"image_72"] != [NSNull null])
                        {
                            teamMember.image_72 = (NSString*)[profileDic objectForKey:@"image_72"];
                        }
                        
                        if([profileDic objectForKey:@"image_192"] != [NSNull null])
                        {
                            teamMember.image_192 = (NSString*)[profileDic objectForKey:@"image_192"];
                        }
                        
                        [teamUserArray addObject:teamMember];
                        
                        teamMember = nil;
                    }
                    
                    
                }
            }
            finished(teamUserArray);
        }];
        [task resume];
        [session finishTasksAndInvalidate];
    }
}
@end
