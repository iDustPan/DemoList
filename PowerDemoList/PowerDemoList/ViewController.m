//
//  ViewController.m
//  PowerDemoList
//
//  Created by 徐攀 on 11/05/2018.
//  Copyright © 2018 com.pan.test. All rights reserved.
//

#import "ViewController.h"
#import "XPRangeSlider.h"
#import "DemoListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DemoListViewController *demoVC = [[DemoListViewController alloc] initWithNibName:nil bundle:nil];
    [self addChildViewController:demoVC];
    [self.view addSubview:demoVC.view];
    [demoVC didMoveToParentViewController:self];
    
}


@end
