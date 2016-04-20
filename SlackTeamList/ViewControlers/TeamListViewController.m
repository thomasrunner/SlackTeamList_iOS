//
//  TeamListViewController.m
//  SlackTeamList
//
//  Created by Thomas on 2016-02-19.
//  Copyright © 2016 Slack Demo. All rights reserved.
//

#import "TeamListViewController.h"
#import "UserDetailViewController.h"
#import "User.h"
#import "FileCache.h"
#import "SlackAPI.h"
#import "TeamUserTableViewCell.h"

@interface TeamListViewController ()

    @property (strong, nonatomic) NSMutableArray *teamUserArray;
    @property (strong, nonatomic) User *selectedUser;
    @property (strong, nonatomic) FileCache *fileCache;
    @property (strong, nonatomic) SlackAPI *slackAPI;
    @property  (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TeamListViewController
@synthesize teamUserArray;
@synthesize selectedUser;
@synthesize fileCache;
@synthesize teamListTableView;
@synthesize slackAPI;
@synthesize refreshControl;

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    teamUserArray = [[NSMutableArray alloc] init];
    fileCache = [[FileCache alloc] init];
    slackAPI = [[SlackAPI alloc] init];
    [self downloadSlackTeamList:true];
    
    //Pull to Refresh Initialization
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [teamListTableView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"teamListtoUserProfileSegue"])
    {
        // Get destination view
        UserDetailViewController *userDetailVC = [segue destinationViewController];
        userDetailVC.selectedUser = selectedUser;
    }
}

#pragma mark - Pull to Refresh
-(void)handleRefresh:(UIRefreshControl *)refresh {

    [self downloadSlackTeamList:true];
    
    [refreshControl endRefreshing];
}

#pragma mark - UITableViewController
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [teamUserArray count];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
    TeamUserTableViewCell* cell = [tableView cellForRowAtIndexPath:path];
    [cell setSelected:NO];
    
    selectedUser = [teamUserArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"teamListtoUserProfileSegue" sender:self];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TeamUserTableViewCell";
    TeamUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TeamUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if(indexPath.row < [teamUserArray count])
    {
        selectedUser = [teamUserArray objectAtIndex:indexPath.row];
        
        NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"slack"];
        
        // New Folder is your folder name
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
        
        NSString *cachefilenumber = selectedUser.userid;
        
        NSString *cacheFileName = [stringPath stringByAppendingFormat:@"/"];
        cacheFileName = [cacheFileName stringByAppendingFormat:@"%@",cachefilenumber];
        cacheFileName = [cacheFileName stringByAppendingFormat:@"%@",@"p.jpg"];
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:cacheFileName];
        
        cell.userNameLabel.text = [selectedUser nameWithAtSymbol];
        cell.userPositionLabel.text = [selectedUser titleWithNameFailover];
        cell.userProfileImageView.image = nil;
        
        cell.miniEmailImageView.hidden = true;
        cell.miniPhoneImageView.hidden = true;
        cell.miniSkypeImageView.hidden = true;
        
        if([selectedUser.email length] > 0)
        {
            cell.miniEmailImageView.hidden = false;
        }
        
        if([selectedUser.phone length] > 0)
        {
            cell.miniPhoneImageView.hidden = false;
        }
        
        if([selectedUser.skype length] > 0)
        {
            cell.miniSkypeImageView.hidden = false;
        }
        
        if(fileExists)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL *url = [NSURL fileURLWithPath:cacheFileName];
                NSData *data = [[NSData alloc] initWithContentsOfURL:url];
                if(data !=nil)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.userProfileImageView.image = [UIImage imageWithData:data];
                        cell.userProfileImageView.layer.cornerRadius = 8;
                        cell.userProfileImageView.layer.masksToBounds = YES;
                    });
                }
                
            });
        }
        else
        {
            fileExists = [[NSFileManager defaultManager] fileExistsAtPath:cacheFileName];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                //Caching Athlete Profile Photo
                NSURL * url = [NSURL URLWithString:selectedUser.image_72];
                NSData * data = [NSData dataWithContentsOfURL:url];
                
                if(data !=nil)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [data writeToFile:cacheFileName atomically:YES];
                        
                        cell.userProfileImageView.image = [UIImage imageWithData:data];
                        cell.userProfileImageView.layer.cornerRadius = 8;
                        cell.userProfileImageView.layer.masksToBounds = YES;
                    });
                }
            });
        }
    }
    return cell;
}


#pragma Download Slack Team List
- (void) downloadSlackTeamList:(BOOL)forceDownload
{
    if(teamUserArray == nil)
    {
        teamUserArray = [[NSMutableArray alloc] init];
    }
    else
    {
        if([teamUserArray count] > 0) [teamUserArray removeAllObjects];
    }
    
    //Caching
    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"slack"];
    // New Folder is your folder name
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *cacheFileName = [stringPath stringByAppendingFormat:@"%@",[fileCache teamData]];
    NSLog(@"%@",cacheFileName);
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:cacheFileName];
    
    if(!forceDownload && fileExists)
    {
        
        
        teamUserArray = [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFileName];
        
        if(teamListTableView.delegate == nil)
        {
            ///////////////////////
            self.teamListTableView.delegate = self;
            self.teamListTableView.dataSource = self;
            //////////////////////
            
            teamListTableView.decelerationRate = UIScrollViewDecelerationRateFast;
        }
        
        [teamListTableView reloadData];
    }
    else
    {
        
        NSString *urlString = [slackAPI slackTeamURL:@"xoxp-5048173296-5048487710-19045732087-b5427e3b46"];
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
                            if ([[member objectForKey:@"presence"] isEqualToString: @""])
                            {
                                teamMember.presence = (BOOL)[member objectForKey:@"presence"];
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
                    
                    //set your image on main thread.
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if(teamListTableView.delegate == nil)
                        {
                            ///////////////////////
                            self.teamListTableView.delegate = self;
                            self.teamListTableView.dataSource = self;
                            //////////////////////
                            
                            teamListTableView.decelerationRate = UIScrollViewDecelerationRateFast;
                        }
                        
                        [teamListTableView reloadData];
                        @synchronized(self)
                        {
                            NSMutableArray *cacheArray = [[NSMutableArray alloc] initWithArray:teamUserArray copyItems:YES];
                            //Write File Cache
                            BOOL success = [NSKeyedArchiver archiveRootObject:cacheArray toFile:cacheFileName];
                            if(!success)
                            {
                                NSLog(@"%@", @"Error saving slack team cached data.");
                            }
                        }
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertController * alert=   [UIAlertController
                                                      alertControllerWithTitle:@"Loading Error"
                                                      message:@"Sorry internet connection issue."
                                                      preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction* okButton = [UIAlertAction
                                                   actionWithTitle:@"OK"
                                                   style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                                                   {
                                                       if([teamUserArray count] == 0 && fileExists) [self downloadSlackTeamList:false];
                                                       return;
                                                   }];
                        
                        
                        [alert addAction:okButton];
                        [self presentViewController:alert animated:YES completion:nil];
                    });
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:@"Loading Error"
                                                  message:@"Sorry internet connection issue."
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* okButton = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                                               {
                                                   if([teamUserArray count] == 0 && fileExists) [self downloadSlackTeamList:false];
                                                   return;
                                                   
                                               }];
                    
                    [alert addAction:okButton];
                    [self presentViewController:alert animated:YES completion:nil];
                });
            }
        }];
        [task resume];
    }
}

@end
