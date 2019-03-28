//
//  DemoListViewController.m
//  PowerDemoList
//
//  Created by borderxlab_pan on 2019/3/28.
//  Copyright © 2019 com.pan.test. All rights reserved.
//

#import "DemoListViewController.h"
#import "RangeSliderViewController.h"
#import "IndexViewController.h"
#import <Masonry/Masonry.h>

@interface DemoListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *demoListTable;

@end

@implementation DemoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.demoListTable];
    [self.demoListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        if(@available(iOS 11, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        }else{
            make.top.equalTo(self.mas_topLayoutGuideBottom);
        }
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self.demoListTable reloadData];
}

- (NSArray *)demoList {
    return @[
             @"Custom Range Slider",
             @"Index View"
             ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self demoList].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
    NSString *demo = [self demoList][indexPath.item];
    cell.textLabel.text = demo;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushWithIndexPath:indexPath];
}

- (void)pushWithIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    switch (indexPath.item) {
        case 0:{
            vc = [RangeSliderViewController new];
        }
            break;
        case 1: {
            vc = [IndexViewController new];
        }
        default:
            break;
    }
    [self presentViewController:vc animated:YES completion:nil];
}

- (UITableView *)demoListTable {
    if (!_demoListTable) {
        _demoListTable = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
        _demoListTable.dataSource = self;
        _demoListTable.delegate = self;
        [_demoListTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    }
    return _demoListTable;
}

@end
