//
//  NIActivityIndicator.m
//
//  Created by Nikki Vergracht on 07/04/15.
//  Copyright (c) 2015 Lewion.ninja All rights reserved.
//

#import "NIActivityIndicator.h"

@interface NIActivityIndicator ()

@property (nonatomic, strong) CAShapeLayer *backgroundStroke;
@property (nonatomic, strong) CAShapeLayer *stroke;
@property (nonatomic, strong) CAShapeLayer *mask;

@property (nonatomic) CGFloat factor;
@property (nonatomic) BOOL finish;

@property (nonatomic, strong) CABasicAnimation *strokeAnimation;
@property (nonatomic, strong) CABasicAnimation *strokeAnimationFinish;
@property (nonatomic, strong) CABasicAnimation *maskAnimation;

@end

@implementation NIActivityIndicator

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
        [self setupLayersWithFrame:(CGRect)frame];
	}
	return self;
}

- (void)setupLayersWithFrame:(CGRect)frame{
    self.finish = NO;
    self.factor = frame.size.width;
    
    CAShapeLayer * backgroundStroke = [CAShapeLayer layer];
    backgroundStroke.frame       = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [backgroundStroke setValue:@(-135 * M_PI/180) forKeyPath:@"transform.rotation"];
    backgroundStroke.fillColor   = nil;
    backgroundStroke.strokeColor = [UIColor colorWithRed:0.0784 green: 0.62 blue:0.412 alpha:1].CGColor;
    backgroundStroke.lineWidth   = 9;
    backgroundStroke.strokeStart = 0;
    backgroundStroke.path        = [self bezierPath].CGPath;
    [self.layer addSublayer:backgroundStroke];
    _backgroundStroke = backgroundStroke;
    
    self.initiallyShowFullStroke = YES;
    
	CAShapeLayer * stroke = [CAShapeLayer layer];
	stroke.frame       = CGRectMake(0, 0, frame.size.width, frame.size.height);
	[stroke setValue:@(-135 * M_PI/180) forKeyPath:@"transform.rotation"];
	stroke.fillColor   = nil;
    stroke.strokeColor = [UIColor colorWithRed:0.0784 green: 0.62 blue:0.412 alpha:1].CGColor;
	stroke.lineWidth   = 10;
	stroke.strokeStart = 1;
	stroke.path        = [self bezierPath].CGPath;
	[self.layer addSublayer:stroke];
	_stroke = stroke;
	
	CAShapeLayer * mask = [CAShapeLayer layer];
	mask.frame       = CGRectMake(0, 0, frame.size.width, frame.size.height);;
	[mask setValue:@(-135 * M_PI/180) forKeyPath:@"transform.rotation"];
	mask.fillColor   = nil;
    mask.strokeColor = [UIColor whiteColor].CGColor;
	mask.lineWidth   = 11;
	mask.strokeStart = 1;
	mask.path        = [self bezierPath].CGPath;
	[self.layer addSublayer:mask];
	_mask = mask;
}

#pragma mark - Setters

- (void)setStrokeColor:(UIColor *)strokeColor {
    _backgroundStroke.strokeColor = _stroke.strokeColor = strokeColor.CGColor;
}

- (void)setMaskColor:(UIColor *)maskColor {
    _mask.strokeColor = maskColor.CGColor;
}

- (void)setStrokeWidth:(CGFloat)strokeWidth {
    _mask.lineWidth = strokeWidth; _stroke.lineWidth = strokeWidth - 1;
}

- (void)setInitiallyShowFullStroke:(BOOL)initiallyShowFullStroke {
    _backgroundStroke.strokeStart = (int)!initiallyShowFullStroke;
}

#pragma mark - Animation 

- (void)startAnimation {
    self.backgroundStroke.hidden = YES;
    [self.stroke addAnimation:self.strokeAnimation forKey:@"strokeAnimation"];
    [self.mask addAnimation:self.maskAnimation forKey:@"maskAnimation"];
}

- (void)finishAnimation {
    self.finish = YES;
}

- (CABasicAnimation *)strokeAnimation {
    if (!_strokeAnimation) {
        _strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        _strokeAnimation.toValue            = @0;
        _strokeAnimation.duration           = self.duration ? self.duration : 2;
        _strokeAnimation.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.586 :-0.00868 :0.333 :1];
        _strokeAnimation.fillMode = kCAFillModeForwards;
        _strokeAnimation.removedOnCompletion = YES;
        _strokeAnimation.delegate = self;
    }
    return _strokeAnimation;
}

- (CABasicAnimation *)maskAnimation {
    if (!_maskAnimation) {
        _maskAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        _maskAnimation.toValue            = @0;
        _maskAnimation.duration           = self.duration ? self.duration : 2;
        _maskAnimation.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.719 :-0.012 :0.431 :0.986];
        _maskAnimation.fillMode = kCAFillModeForwards;
        _maskAnimation.removedOnCompletion = YES;
    }
    return _maskAnimation;
}

- (CABasicAnimation *)strokeAnimationFinish {
    if (!_strokeAnimationFinish) {
        _strokeAnimationFinish = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        _strokeAnimationFinish.toValue            = @0;
        _strokeAnimationFinish.duration           = self.duration ? self.duration : 2;
        _strokeAnimationFinish.timingFunction     = [CAMediaTimingFunction functionWithControlPoints:0.586 :-0.00868 :0.333 :1];
        _strokeAnimationFinish.fillMode = kCAFillModeForwards;
        _strokeAnimationFinish.removedOnCompletion = NO;
    }
    return _strokeAnimationFinish;
}

#pragma mark - Delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.finish) {
        [self.stroke removeAnimationForKey:@"strokeAnimation"];
        [self.mask removeAnimationForKey:@"maskAnimation"];
        [self.stroke addAnimation:self.strokeAnimationFinish forKey:@"strokeAnimationFinish"];
    } else {
        [self.stroke addAnimation:self.strokeAnimation forKey:@"strokeAnimation"];
        [self.mask addAnimation:self.maskAnimation forKey:@"maskAnimation"];
    }
}

#pragma mark - Bezier Path

- (UIBezierPath*)bezierPath{
	UIBezierPath *bezierPath = [UIBezierPath bezierPath];
	[bezierPath moveToPoint:CGPointMake((124.619/146)*self.factor, (124.619/146)*self.factor)];
    [bezierPath addCurveToPoint:CGPointMake((124.619/146)*self.factor, (21.381/146)*self.factor) controlPoint1:CGPointMake((153.127/146)*self.factor, (96.111/146)*self.factor) controlPoint2:CGPointMake((153.127/146)*self.factor, (49.889/146)*self.factor)];
	[bezierPath addCurveToPoint:CGPointMake((21.381/146)*self.factor, (21.381/146)*self.factor) controlPoint1:CGPointMake((96.111/146)*self.factor, (-7.127/146)*self.factor) controlPoint2:CGPointMake((49.889/146)*self.factor, (-7.127/146)*self.factor)];
	[bezierPath addCurveToPoint:CGPointMake((21.381/146)*self.factor, (124.619/146)*self.factor) controlPoint1:CGPointMake((-7.127/146)*self.factor, (49.889/146)*self.factor) controlPoint2:CGPointMake((-7.127/146)*self.factor, (96.111/146)*self.factor)];
	[bezierPath addCurveToPoint:CGPointMake((124.619/146)*self.factor, (124.619/146)*self.factor) controlPoint1:CGPointMake((49.889/146)*self.factor, (153.127/146)*self.factor) controlPoint2:CGPointMake((96.111/146)*self.factor, (153.127/146)*self.factor)];
	return bezierPath;
}

@end