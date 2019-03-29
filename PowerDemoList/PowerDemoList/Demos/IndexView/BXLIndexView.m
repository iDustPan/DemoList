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

@property (nonatomic, assign) NSInteger selectedSection;

@property (nonatomic, strong) UILabel *indicator;

@property (nonatomic, strong) NSMutableArray<CALayer *> *subTextLayer;

@property (nonatomic, strong) UIImpactFeedbackGenerator *generator NS_AVAILABLE_IOS(10_0);

@end

@implementation BXLIndexView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _subTextLayer = @[].mutableCopy;
        _spacing = 2;
        _fontSize = 12;
        _itemWidth = 16;
        _textColor = [UIColor blackColor];
        _highlightBgColor = [UIColor blackColor];
        _highlightTextColor = [UIColor whiteColor];
        _indicatorRightMargin = 20;
        _indicatorWidth = 40;
        [self addSubview:self.indicator];
    }
    return self;
}

- (void)setSelectedSection:(NSInteger)selectedSection {
    if (selectedSection != _selectedSection) {
        [self configureSublayers:NO];
        _selectedSection = selectedSection;
        [self configureSublayers:YES];
        [self touchedFeedBack];
    }
}

- (void)touchedFeedBack {
    if (@available(iOS 10.0, *)) {
        [self.generator prepare];
        [self.generator impactOccurred];
    }
}

- (void)configureSublayers:(BOOL)selected {
    if (self.selectedSection != 0) {
        CATextLayer *touchedLayer = (CATextLayer *)self.subTextLayer[self.selectedSection];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (selected) {
            touchedLayer.backgroundColor = _highlightBgColor.CGColor;
            touchedLayer.foregroundColor = _highlightTextColor.CGColor;
        }else{
            touchedLayer.backgroundColor = self.backgroundColor.CGColor;
            touchedLayer.foregroundColor = _textColor.CGColor;
        }
        [self layoutIndicator:touchedLayer];
        [CATransaction commit];
    }
}

- (void)configureTouchedLayerAtPoint:(CGPoint)point {
    NSInteger section = (point.y + _spacing)/(_itemWidth + _spacing);
    if (point.y < 0) {
        section = 0;
        [self showIndicator:NO];
    }else if (section >= _indexes.count) {
        section = _indexes.count - 1;
    }else{
        [self showIndicator:YES];
    }
    self.selectedSection = section;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint startPoint = [touch locationInView:self];
    [self configureTouchedLayerAtPoint:startPoint];
    [self showIndicator:YES];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint currentPoint = [touch locationInView:self];
    [self configureTouchedLayerAtPoint:currentPoint];
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self showIndicator:NO];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [self showIndicator:NO];
}

- (void)setIndexes:(NSArray<NSString *> *)indexes {
    _indexes = indexes;
    [self.subTextLayer makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
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
        layer.cornerRadius = _itemWidth * .5f;
        [self.layer addSublayer:layer];
        [self.layer setNeedsDisplay];
        positionY += _itemWidth + _spacing;
        [_subTextLayer addObject:layer];
    }
}

- (void)showIndicator:(BOOL)show {
    if (show) {
        self.indicator.alpha = 1;
    }else{
        [UIView animateWithDuration:.35f delay:0 options:0 animations:^{
            self.indicator.alpha--;
        } completion:nil];
    }
}

- (void)layoutIndicator:(CATextLayer *)layer {
    self.indicator.center = CGPointMake(-(_indicatorRightMargin + _indicatorWidth/2),
                                        layer.frame.origin.y + layer.frame.size.height * .5f);
    self.indicator.bounds = CGRectMake(0, 0, _indicatorWidth, _indicatorWidth);
    self.indicator.text = layer.string;
    self.indicator.layer.cornerRadius = self.indicator.bounds.size.width * .5f;
    self.indicator.clipsToBounds = YES;
}

- (CAShapeLayer *)searchLayer {
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
                  endAngle:(2.25*M_PI)
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
    txtLayer.contentsScale = [UIScreen mainScreen].scale;
    return txtLayer;
}

- (UILabel *)indicator {
    if (!_indicator) {
        _indicator = [[UILabel alloc] initWithFrame:CGRectZero];
        _indicator.backgroundColor = [UIColor lightGrayColor];
        _indicator.textAlignment = NSTextAlignmentCenter;
    }
    return _indicator;
}

- (UIImpactFeedbackGenerator *)generator {
    if (!_generator) {
        _generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
    }
    return _generator;
}


@end
