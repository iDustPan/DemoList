//
//  XPRangeSlider.m
//  PowerDemoList
//
//  Created by borderxlab_pan on 2019/3/28.
//  Copyright © 2019 com.pan.test. All rights reserved.
//

#import "XPRangeSlider.h"

@interface XPRangeSlider ()

@end

@implementation XPRangeSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _minValue = 0;
        _highValue = 1000;
    }
    return self;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    NSLog(@"%s, %@", __func__, NSStringFromCGPoint(point));
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    NSLog(@"%s, %@", __func__, NSStringFromCGPoint(point));
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    NSLog(@"%s, %@", __func__, NSStringFromCGPoint(point));
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {

    NSLog(@"%s", __func__);
}

@end
