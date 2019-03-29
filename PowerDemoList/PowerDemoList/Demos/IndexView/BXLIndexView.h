//
//  BXLIndexView.h
//  PowerDemoList
//
//  Created by borderxlab_pan on 2019/3/28.
//  Copyright © 2019 com.pan.test. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface BXLIndexView : UIControl

@property (nonatomic, strong) NSArray<NSString *> *indexes;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *highlightTextColor;

@property (nonatomic, strong) UIColor *highlightBgColor;

@property (nonatomic, assign) CGFloat spacing;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, assign) CGFloat indicatorRightMargin;

@property (nonatomic, assign) CGFloat indicatorWidth;


@end

NS_ASSUME_NONNULL_END
