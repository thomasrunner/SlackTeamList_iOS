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
#import "NetworkLayer.h"
#import "TeamUserTableViewCell.h"
#import "TeamListView.h"

@interface TeamListViewController ()

    @property (strong, nonatomic) NSMutableArray *teamUserArray;
    @property (strong, nonatomic) User *selectedUser;
    @property (strong, nonatomic) FileCache *fileCache;
    @property (strong, nonatomic) UIRefreshControl *refreshControl;
    @property (strong, nonatomic) TeamListView *view;

@end

@implementation TeamListViewController
@synthesize teamUserArray;
@synthesize selectedUser;
@synthesize fileCache;
@synthesize view;
@synthesize refreshControl;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    self.view = [[TeamListView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets =  NO;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //TABLE VIEW
    self.view.teamListTableView.delegate = self;
    self.view.teamListTableView.dataSource = self;

    //HELPERS
    teamUserArray = [[NSMutableArray alloc] init];
    fileCache = [[FileCache alloc] init];
    [self downloadSlackTeamList:true];
    
    //PULL TO REFRESH
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.view.teamListTableView addSubview:refreshControl];
    
    self.navigationItem.title = @"Team List";
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - Pull to Refresh
-(void)handleRefresh:(UIRefreshControl *)refresh {

    [self downloadSlackTeamList:true];
    
    [refreshControl endRefreshing];
}

#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [teamUserArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    TeamUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TeamUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell initView];
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

#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
    TeamUserTableViewCell* cell = [tableView cellForRowAtIndexPath:path];
    [cell setSelected:NO];
    if(indexPath.row < [teamUserArray count])
    {
        selectedUser = [teamUserArray objectAtIndex:indexPath.row];
        UserDetailViewController *userDetailVC = [[UserDetailViewController alloc] init];
        userDetailVC.selectedUser = selectedUser;
        [self.navigationController pushViewController:userDetailVC animated:true];
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

#pragma mark - Download Slack Team List
- (void) downloadSlackTeamList:(BOOL)forceDownload
{
    NetworkLayer *networkLayer = [[NetworkLayer alloc] init];
    if(teamUserArray == nil)
    {
        teamUserArray = [[NSMutableArray alloc] init];
    }
    else
    {
        if([teamUserArray count] > 0) [teamUserArray removeAllObjects];
    }
    
    [networkLayer downloadSlackTeamWithForce:forceDownload :^(NSMutableArray *array) {
        teamUserArray = array;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(teamUserArray != nil && [teamUserArray count] > 0)
            {
                if(self.view.teamListTableView.delegate == nil)
                {
                    ///////////////////////
                    self.view.teamListTableView.delegate = self;
                    self.view.teamListTableView.dataSource = self;
                    //////////////////////
                    
                    self.view.teamListTableView.decelerationRate = UIScrollViewDecelerationRateFast;
                }
                
                [self.view.teamListTableView reloadData];
            }
            else
            {
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Loading Error"
                                              message:@"Sorry internet connection issue."
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"Try Again?"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action)
                                           {
                                               
                                               return;
                                           }];
                
                
                [alert addAction:okButton];
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
    }];
}

@end
