//
//  ViewController.m
//  SPSegment
//
//  Created by 乐升平 on 2018/12/29.
//  Copyright © 2018 乐升平. All rights reserved.
//

#import "ViewController.h"
#import "SPMultipleSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat ScreenW = [UIScreen mainScreen].bounds.size.width;
    
    SPMultipleSwitch *switch1 = [[SPMultipleSwitch alloc] initWithItems:@[@"Weekly",@"Monthly"]];
    switch1.frame = CGRectMake(0, 0, 180, 30);
    [switch1 addTarget:self action:@selector(switchAction1:) forControlEvents:UIControlEventTouchUpInside];
    switch1.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    switch1.layer.borderColor = [UIColor whiteColor].CGColor;
    switch1.selectedTitleColor = [UIColor redColor];
    switch1.titleColor = [UIColor whiteColor];
    switch1.trackerColor = [UIColor whiteColor];
    self.navigationItem.titleView = switch1;
    
    SPMultipleSwitch *switch2 = [[SPMultipleSwitch alloc] initWithItems:@[@"Feed",@"Leaderboard"]];
    switch2.frame = CGRectMake(30, 100, ScreenW-60, 40);
    switch2.backgroundColor = [UIColor orangeColor];
    switch2.selectedTitleColor = [UIColor orangeColor];
    switch2.titleColor = [UIColor whiteColor];
    switch2.trackerColor = [UIColor whiteColor];
    switch2.contentInset = 5;
    switch2.spacing = 10;
    switch2.titleFont = [UIFont boldSystemFontOfSize:17];
    switch2.trackerColor = [UIColor whiteColor];
    [switch2 addTarget:self action:@selector(switchAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switch2];
    
    SPMultipleSwitch *switch3 = [[SPMultipleSwitch alloc] initWithItems:@[@"私信",@"评论",@"@我",@"通知"]];
    switch3.frame = CGRectMake(15, 180, ScreenW-30, 50);
    switch3.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:191.0/255.0 blue:81.0/255.0 alpha:1];
    switch3.selectedTitleColor = [UIColor colorWithRed:31.0/255.0 green:191.0/255.0 blue:81.0/255.0 alpha:1];
    switch3.titleColor = [UIColor whiteColor];
    switch3.trackerColor = [UIColor whiteColor];
    switch3.contentInset = 5;
    switch3.spacing = 10;
    switch3.trackerImage = [UIImage imageNamed:@"tracker"];
    [switch3 addTarget:self action:@selector(switchAction3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switch3];
}

- (void)switchAction1:(SPMultipleSwitch *)multipleSwitch {
    NSLog(@"点击了第%zd个",multipleSwitch.selectedSegmentIndex);
}

- (void)switchAction2:(SPMultipleSwitch *)multipleSwitch {
    NSLog(@"点击了第%zd个",multipleSwitch.selectedSegmentIndex);
}

- (void)switchAction3:(SPMultipleSwitch *)multipleSwitch {
    NSLog(@"点击了第%zd个",multipleSwitch.selectedSegmentIndex);
}
@end
