//
//  RTTableViewController.m
//  RTIconButton
//
//  Created by Ricky on 2017/7/25.
//  Copyright © 2017年 rickytan. All rights reserved.
//

#import <RTIconButton/RTIconButton.h>

#import "RTTableViewController.h"

@interface RTTableViewController ()

@end

@implementation RTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    RTIconButton *button = [cell viewWithTag:1001];
    [button setContentHorizontalAlignment:((NSUInteger)cell >> 4) % 4];
    [button setContentVerticalAlignment:indexPath.row % 4];
    button.iconMargin = indexPath.row % 20;
    button.iconPosition = indexPath.row % 4;
    [button setTitle:[NSString stringWithFormat:@"Row: %zd", indexPath.row]
            forState:UIControlStateNormal];
    
    return cell;
}

@end
