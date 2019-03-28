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
        _itemWidth = 16;
    }
    return self;
}

- (CALayer *)layerAtPoint:(CGPoint)point {
    CALayer *touchedLayer = nil;
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer containsPoint:point]) {
            return layer;
        }
    }
    return touchedLayer;
}

- (void)configureTouchedLayerAtPoint:(CGPoint)point {
    for (CALayer *layer in self.layer.sublayers) {
        CGPoint coverPoint = [self.layer convertPoint:point toLayer:layer];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if ([layer containsPoint:coverPoint]) {
            layer.backgroundColor = [UIColor blackColor].CGColor;
        }else{
            layer.backgroundColor = self.backgroundColor.CGColor;
        }
        [CATransaction commit];
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint startPoint = [touch locationInView:self];
    [self configureTouchedLayerAtPoint:startPoint];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentPoint = [touch locationInView:self];
    [self configureTouchedLayerAtPoint:currentPoint];
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)setIndexes:(NSArray<NSString *> *)indexes {
    _indexes = indexes;
    [self addIndexItems];
}

- (void)addIndexItems {
    [self layoutIfNeeded];
    CGFloat positionY = 0;
    for (NSString *indexItem in _indexes) {
        CALayer *layer = nil;
        if (indexItem != UITableViewIndexSearch) {
            layer = [self textLayerWithItem:indexItem];
        }else{
            layer = [self searchLayer];
        }
        layer.frame = CGRectMake((self.frame.size.width - _itemWidth) * .5f, positionY, _itemWidth, _itemWidth);
        [self.layer addSublayer:layer];
        [self.layer setNeedsDisplay];
        positionY += _itemWidth + _spacing;
    }
}

- (CALayer *)searchLayer {
    CAShapeLayer *layer = [CAShapeLayer layer];
    CGFloat radius = 4;
    CGFloat end = (_itemWidth / 2 + radius * sin(M_PI_4));
    CGFloat start =  end * 1.3;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(start, start)];
    [path addLineToPoint:CGPointMake(end , end)];
    [path addArcWithCenter:CGPointMake(_itemWidth / 2, _itemWidth / 2)
                    radius:radius
                startAngle:M_PI_4
                  endAngle:(M_PI_4 + M_PI*2)
                 clockwise:true];
    path.lineWidth = 1;
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = self.backgroundColor.CGColor;
    return layer;
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
