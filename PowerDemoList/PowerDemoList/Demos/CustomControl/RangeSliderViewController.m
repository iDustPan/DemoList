//
//  RangeSliderViewController.m
//  PowerDemoList
//
//  Created by borderxlab_pan on 2019/3/28.
//  Copyright © 2019 com.pan.test. All rights reserved.
//

#import "RangeSliderViewController.h"
#import "XPRangeSlider.h"
#import <Masonry.h>

@interface RangeSliderViewController ()

@property (nonatomic, strong) XPRangeSlider *slider;

@end

@implementation RangeSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(44);
    }];
}

- (XPRangeSlider *)slider {
    if (!_slider) {
        _slider = [[XPRangeSlider alloc] initWithFrame:CGRectZero];
        _slider.backgroundColor = [UIColor redColor];
    }
    return _slider;
}

@end
