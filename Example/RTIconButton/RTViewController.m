//
//  RTViewController.m
//  RTIconButton
//
//  Created by rickytan on 09/28/2015.
//  Copyright (c) 2015 rickytan. All rights reserved.
//

#import <RTIconButton/RTIconButton.h>

#import "RTViewController.h"

@interface RTViewController ()

@end

@implementation RTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    {
        RTIconButton *button = [RTIconButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"watch"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"Hello, world" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:24.f];
        button.backgroundColor = [UIColor redColor];
        button.iconPosition = RTIconPositionRight;
        button.iconMargin = 8.f;
        [button sizeToFit];
        button.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 20.f);
        [self.view addSubview:button];
    }
    
    {
        RTIconButton *button = [RTIconButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"watch"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"Hello, world" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:24.f];
        button.backgroundColor = [UIColor redColor];
        button.iconPosition = RTIconPositionBottom;
        button.iconMargin = 8.f;
        button.iconSize = CGSizeMake(36, 36);
        [button sizeToFit];
        button.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 + 48.f);
        [self.view addSubview:button];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
