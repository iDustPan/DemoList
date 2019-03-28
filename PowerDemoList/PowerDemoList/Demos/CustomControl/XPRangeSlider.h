//
//  XPRangeSlider.h
//  PowerDemoList
//
//  Created by borderxlab_pan on 2019/3/28.
//  Copyright © 2019 com.pan.test. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPRangeSlider : UIControl

@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, assign) CGFloat lowValue;
@property (nonatomic, assign) CGFloat highValue;

@property (nonatomic, assign) CGFloat stepValue;

@property (nonatomic, assign) CGFloat currentValue;

@end

NS_ASSUME_NONNULL_END
