//
//  IndexViewController.m
//  PowerDemoList
//
//  Created by borderxlab_pan on 2019/3/28.
//  Copyright © 2019 com.pan.test. All rights reserved.
//

#import "IndexViewController.h"
#import <Masonry/Masonry.h>
#import "BXLIndexView.h"

@interface IndexViewController ()

@property (nonatomic, strong) BXLIndexView *indexView;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.indexView];
    [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(600);
        make.centerY.mas_equalTo(0);
    }];
    
    self.indexView.indexes = @[UITableViewIndexSearch,@"A", @"B", @"C", @"D", @"C",@"D", @"E", @"F", @"G",@"H", @"I", @"G", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"
                               ];
}

- (BXLIndexView *)indexView {
    if (!_indexView) {
        _indexView = [[BXLIndexView alloc] initWithFrame:CGRectZero];
        _indexView.backgroundColor = [UIColor cyanColor];
    }
    return _indexView;
}

@end
