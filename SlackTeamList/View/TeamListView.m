//
//  TeamListView.m
//  SlackTeamList
//
//  Created by Thomas on 2018-01-18.
//  Copyright © 2018 Slack Demo. All rights reserved.
//

#import "TeamListView.h"

@implementation TeamListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.tableView];
    }
    return self;
}

- (UITableView *)tableView
{
    if (_teamListTableView == nil)
    {
        _teamListTableView = [[UITableView alloc] initWithFrame:self.bounds
                                                  style:UITableViewStylePlain];
    }
    return _teamListTableView;
}





@end
