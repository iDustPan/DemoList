//
//  BXLIndexView.m
//  PowerDemoList
//
//  Created by borderxlab_pan on 2019/3/28.
//  Copyright © 2019 com.pan.test. All rights reserved.
//

#import "BXLIndexView.h"
#import "CAIndexItemLayer.h"

@interface BXLIndexView ()

@property (nonatomic, strong) CAIndexItemLayer *itemLayer;

@end

@implementation BXLIndexView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _spacing = 2;
        _fontSize = 12;
    }
    return self;
}

- (void)setIndexes:(NSArray<NSString *> *)indexes {
    _indexes = indexes;
    [self addIndexItems];
}

- (void)addIndexItems {
    [self layoutIfNeeded];
    CGFloat positionY = 0;
    CGFloat itemH = 15;
    for (NSString *indexItem in _indexes) {
        CALayer *layer = nil;
        if (indexItem != UITableViewIndexSearch) {
            layer = [self textLayerWithItem:indexItem];
        }else{
            
        }
        layer.frame = CGRectMake((self.frame.size.width - itemH) * .5f, positionY, itemH, itemH);
        [self.layer addSublayer:layer];
        [self.layer setNeedsDisplay];
        positionY += itemH + _spacing;
    }
}

- (CALayer *)searchLayer {
    return nil;
}

- (CAIndexItemLayer *)textLayerWithItem:(NSString *)item {
    CAIndexItemLayer *txtLayer = [CAIndexItemLayer layer];
    txtLayer.string = item;
    txtLayer.fontSize = _fontSize;
    txtLayer.alignmentMode = kCAAlignmentCenter;
    txtLayer.foregroundColor = [UIColor blackColor].CGColor;
    return txtLayer;
}

@end
