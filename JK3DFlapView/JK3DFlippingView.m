//
//  JK3DFlippingView.m
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/30/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <AHEasing/CAKeyframeAnimation+AHEasing.h>
#import "UIImage+AlphaChange.h"
#import "JK3DFlippingView.h"

static NSString* const RotationAnimationKey = @"viewRotationAnimation";

@interface JK3DFlippingView ()

@property (nonatomic, strong) CALayer* flippingLayer;
@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString* animatingPropertyKeyPath;
@property (nonatomic, assign) CGSize flippingViewDimensions;
@property (nonatomic, strong) UIView* parentView;
@property (nonatomic, strong) UITapGestureRecognizer* tapRecognizer;

@property (nonatomic, assign) JKFlapOpeningMode flapOpeningModeValue;
@property (nonatomic, assign) JKFlapOpening2DDirection flapOpening2DDirectionValue;
@property (nonatomic, assign) JKFlapOpening2DPosition flapOpening2DPositionValue;
@property (nonatomic, assign) JKFlapOpening3DMode flapOpening3DModeValue;

@end

@implementation JK3DFlippingView

- (instancetype)init2DFlapWithPosition:(JKFlapOpening2DPosition)flapOpeningPosition and2DModeFlapOpeningDirection:(JKFlapOpening2DDirection)flapOpeningDirection andFlipviewSize:(CGSize)flippingViewSize {
    if (self = [super init]) {
        _flapOpeningModeValue = JKFlapOpeningMode2D;
        _flapOpening2DPositionValue = flapOpeningPosition;
        _flapOpening2DDirectionValue = flapOpeningDirection;
        _flippingViewDimensions = flippingViewSize;
        [self setupDefaultParametersValues];
    }
    return self;
}

- (instancetype)init3DFlapWithOpeningMode:(JKFlapOpening3DMode)flapOpening3DMode andFlipviewSize:(CGSize)flippingViewSize {
    if (self = [super init]) {
        _flapOpeningModeValue = JKFlapOpeningMode3D;
        _flapOpening3DModeValue = flapOpening3DMode;
        _flippingViewDimensions = flippingViewSize;
        [self setupDefaultParametersValues];
    }
    return self;
}

- (void)setupDefaultParametersValues {
    _flapOpeningAngle = 120.0;
    _animationDuration = 0.75f;
    _blurredImageEffectValue = JKBlurredImageEffectNone;
    _overlayLabelTextValue = @"";
    _flapOverlayViewAlpha = 0.7;
    
    _flapOpened = NO;
    _parentView = [UIView new];
    _parentView.frame = CGRectMake (0, 0, _flippingViewDimensions.width, _flippingViewDimensions.height);
    
    _flippingLayer = [CALayer layer];
    _flippingLayer.frame = CGRectMake (0, 0, _flippingViewDimensions.width, _flippingViewDimensions.height);
    _flippingLayer.backgroundColor = [UIColor clearColor].CGColor;
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    _flippingLayer.sublayerTransform = perspective;
}

- (UIView*)outputFlipView {
    
    CATextLayer* flippingViewOverlayLabel = [CATextLayer layer];
    flippingViewOverlayLabel.frame =
    CGRectMake (0, 0, _flippingViewDimensions.width - 20, _flippingViewDimensions.height - 20);
    flippingViewOverlayLabel.wrapped = YES;
    flippingViewOverlayLabel.alignmentMode = kCAAlignmentCenter;
    UIFont* fontToApply = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    [flippingViewOverlayLabel setFontSize:fontToApply.pointSize];
    flippingViewOverlayLabel.font = (__bridge CFTypeRef)(fontToApply.fontName);
    
    flippingViewOverlayLabel.string = _overlayLabelTextValue;
    flippingViewOverlayLabel.position = self.flippingLayer.position;
    if (self.blurredImageEffectValue != JKBlurredImageEffectNone) {
        self.flippingLayer.contents =
        (__bridge id)[[self backgroundImageFromBlurredEffectValue:self.blurredImageEffectValue]
                      imageByApplyingAlpha:_flapOverlayViewAlpha]
        .CGImage;
    } else {
        if (self.overlayBackgroundImage) {
            self.flippingLayer.contents =
            (__bridge id)[_overlayBackgroundImage imageByApplyingAlpha:_flapOverlayViewAlpha].CGImage;
        } else {
            self.flippingLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        }
    }
    [self setupPositionAndAnchorPoint];
    [self.flippingLayer addSublayer:flippingViewOverlayLabel];
    [self.parentView.layer addSublayer:self.flippingLayer];
    
    self.tapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateFlippingLayer)];
    [self.parentView addGestureRecognizer:self.tapRecognizer];
    return self.parentView;
}

- (UIImage*)backgroundImageFromBlurredEffectValue:(JKBlurredImageEffect)blurredImageEffectValue {
    NSString* blurredImageName = @"";
    if (blurredImageEffectValue == JKBlurredImageEffectSpotlight) {
        blurredImageName = @"blur-spotlight";
    } else if (blurredImageEffectValue == JKBlurredImageEffectBlack) {
        blurredImageName = @"blur-black";
    } else if (blurredImageEffectValue == JKBlurredImageEffectColorful) {
        blurredImageName = @"blur-colorful";
    } else if (blurredImageEffectValue == JKBlurredImageEffectBlue) {
        blurredImageName = @"blur-blue";
    }
    UIImage* im = [UIImage imageNamed:blurredImageName];
    return im;
}

- (void)setupPositionAndAnchorPoint {
    CGPoint flappingLayerPosition;
    CGPoint flappingLayerAnchorPoint;
    
    if (self.flapOpeningModeValue == JKFlapOpeningMode3D) {
        if (self.flapOpening3DModeValue == JKFlapOpeningMode3DTop) {
            flappingLayerPosition = CGPointMake (_flippingViewDimensions.width / 2.0, 0);
            flappingLayerAnchorPoint = CGPointMake (0.5, 0);
            self.animatingPropertyKeyPath = @"transform.rotation.x";
        } else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DLeft) {
            flappingLayerPosition = CGPointMake (0, _flippingViewDimensions.height / 2.0);
            flappingLayerAnchorPoint = CGPointMake (0, 0.5);
            self.animatingPropertyKeyPath = @"transform.rotation.y";
        } else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DBottom) {
            flappingLayerPosition =
            CGPointMake (_flippingViewDimensions.width / 2.0, _flippingViewDimensions.height);
            flappingLayerAnchorPoint = CGPointMake (0.5, 1);
            self.animatingPropertyKeyPath = @"transform.rotation.x";
        } else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DRight) {
            flappingLayerPosition =
            CGPointMake (_flippingViewDimensions.width, _flippingViewDimensions.height / 2.0);
            flappingLayerAnchorPoint = CGPointMake (1, 0.5);
            self.animatingPropertyKeyPath = @"transform.rotation.y";
        }
    } else {
        if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionTopLeft) {
            flappingLayerPosition = CGPointMake (0, 0);
            flappingLayerAnchorPoint = CGPointMake (0, 0);
        } else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionBottomLeft) {
            flappingLayerPosition = CGPointMake (0, _flippingViewDimensions.height);
            flappingLayerAnchorPoint = CGPointMake (0, 1);
        } else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionBottomRight) {
            flappingLayerPosition =
            CGPointMake (_flippingViewDimensions.width, _flippingViewDimensions.height);
            flappingLayerAnchorPoint = CGPointMake (1, 1);
        } else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionTopRight) {
            flappingLayerPosition = CGPointMake (1, 0);
            flappingLayerAnchorPoint = CGPointMake (_flippingViewDimensions.width, 0);
        }
        self.animatingPropertyKeyPath = @"transform.rotation.z";
    }
    self.flippingLayer.position = flappingLayerPosition;
    self.flippingLayer.anchorPoint = flappingLayerAnchorPoint;
}

- (void)animateFlippingLayer {
    CGFloat fromVal;
    CGFloat toVal;
    CGColorRef toColorValue;
    CGColorRef fromColorValue;
    CATransform3D transformToApply;
    
    if (!self.flapOpened) {
        fromVal = 0;
        toVal = degreesToRadians (_flapOpeningAngle);
        toColorValue = [UIColor redColor].CGColor;
        fromColorValue = [UIColor blackColor].CGColor;
    } else {
        fromVal = degreesToRadians (_flapOpeningAngle);
        toVal = 0;
        toColorValue = [UIColor blackColor].CGColor;
        fromColorValue = [UIColor redColor].CGColor;
    }
    
    if (self.flapOpeningModeValue == JKFlapOpeningMode2D) {
        if (self.flapOpening2DDirectionValue == JKFlapOpening2DDirectionAnticlockwise) {
            toVal = -1 * toVal;
        }
        transformToApply = CATransform3DMakeRotation (toVal, 0, 0, 1);
    } else if (self.flapOpeningModeValue == JKFlapOpeningMode3D) {
        if (self.flapOpening3DModeValue == JKFlapOpeningMode3DTop ||
            self.flapOpening3DModeValue == JKFlapOpeningMode3DBottom) {
            transformToApply = CATransform3DMakeRotation (toVal, 1, 0, 0);
        } else {
            transformToApply = CATransform3DMakeRotation (toVal, 0, 1, 0);
        }
    }
    
    CABasicAnimation* rotation3DAnimation = [CAKeyframeAnimation animationWithKeyPath:self.animatingPropertyKeyPath
                                                                             function:ElasticEaseOut
                                                                            fromValue:fromVal
                                                                              toValue:toVal];
    self.flapOpened = !self.flapOpened;
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[ rotation3DAnimation ];
    animationGroup.duration = _animationDuration;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeBoth;
    [self.flippingLayer addAnimation:animationGroup forKey:RotationAnimationKey];
    self.flippingLayer.transform = transformToApply;
}

- (void)animationDidStop:(CAAnimation*)anim finished:(BOOL)flag {
    if ([self.delegate conformsToProtocol:@protocol (AnimationCompleteProtocol)] &&
        [self.delegate respondsToSelector:@selector (flipAnimationEnded)]) {
        [self.delegate flipAnimationEnded];
    }
}

- (void)animationDidStart:(CAAnimation*)anim {
    if ([self.delegate conformsToProtocol:@protocol (AnimationCompleteProtocol)] &&
        [self.delegate respondsToSelector:@selector (flipAnimationBegan)]) {
        [self.delegate flipAnimationBegan];
    }
}

static inline CGFloat degreesToRadians (CGFloat degrees) {
    return degrees * (M_PI / 180.0);
}

@end
