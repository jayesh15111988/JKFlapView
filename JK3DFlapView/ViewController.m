//
//  ViewController.m
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/29/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <AHEasing/CAKeyframeAnimation+AHEasing.h>
#import "UIImage+AlphaChange.h"
#import "ViewController.h"
#import "JK3DFlippingView.h"

static NSString* const RotationAnimationKey = @"viewRotationAnimation";

@interface ViewController ()

@property (nonatomic, strong) CALayer* flippingLayer;
@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString* animatingPropertyKeyPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JK3DFlippingView* flippingView = [[JK3DFlippingView alloc] init3DFlapWithOpeningMode:JKFlapOpeningMode3DTop andFlipviewSize:CGSizeMake(200, 200)];
    flippingView.overlayLabelTextValue = @"asdasdasd\nasdasd\nasdasd";
    UIView* flipView = [flippingView outputFlipView];
    flipView.backgroundColor = [UIColor redColor];
    [self.view addSubview:flipView];
}

//- (void)viewDidLoad {
//	[super viewDidLoad];
//
//	_flippingViewDimensions = CGSizeMake (128.0, 128.0);
//	_flapOpeningAngle = 120.0;
//	_animationDuration = 0.75f;
//	self.blurredImageEffectValue = BlurredImageEffectNone;
//	self.flapOpeningModeValue = JKFlapOpeningMode3D;
//
//	self.flapOpening3DModeValue = JKFlapOpeningMode3DTop;
//
//	self.flapOpening2DPositionValue = JKFlapOpening2DPositionBottomRight;
//	self.flapOpening2DDirectionValue = JKFlapOpening2DDirectionAnticlockwise;
//
//	self.overlayBackgroundImage = [UIImage imageNamed:@"blur.jpg"];
//	self.flapOverlayViewAlpha = 0.7;
//	_overlayLabelTextValue = @"fs df dsf dsf ds fds fas das d asd \nas das d\na das d ";
//
//	CATextLayer* flippingViewOverlayLabel = [CATextLayer layer];
//	flippingViewOverlayLabel.string = _overlayLabelTextValue;
//	flippingViewOverlayLabel.frame =
//	    CGRectMake (0, 0, _flippingViewDimensions.width - 20, _flippingViewDimensions.height - 20);
//	flippingViewOverlayLabel.wrapped = YES;
//	flippingViewOverlayLabel.foregroundColor = [UIColor blackColor].CGColor;
//	flippingViewOverlayLabel.alignmentMode = kCAAlignmentCenter;
//	UIFont* fontToApply = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
//	[flippingViewOverlayLabel setFontSize:fontToApply.pointSize];
//	flippingViewOverlayLabel.font = (__bridge CFTypeRef)(fontToApply.fontName);
//	self.flapOpened = NO;
//	self.parentView = [UIView new];
//	self.parentView.frame = CGRectMake (0, 0, _flippingViewDimensions.width, _flippingViewDimensions.height);
//	self.parentView.layer.backgroundColor = [UIColor greenColor].CGColor;
//
//	self.flippingLayer = [CALayer layer];
//	self.flippingLayer.frame = CGRectMake (0, 0, _flippingViewDimensions.width, _flippingViewDimensions.height);
//	self.flippingLayer.backgroundColor = [UIColor clearColor].CGColor;
//	flippingViewOverlayLabel.position = self.flippingLayer.position;
//	if (self.blurredImageEffectValue != BlurredImageEffectNone) {
//		self.flippingLayer.contents =
//		    (__bridge id)[[self backgroundImageFromBlurredEffectValue:self.blurredImageEffectValue]
//			imageByApplyingAlpha:_flapOverlayViewAlpha]
//			.CGImage;
//	} else {
//		if (self.overlayBackgroundImage) {
//			self.flippingLayer.contents =
//			    (__bridge id)[_overlayBackgroundImage imageByApplyingAlpha:_flapOverlayViewAlpha].CGImage;
//		} else {
//			self.flippingLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
//		}
//	}
//
//	[self setupPositionAndAnchorPoint];
//	[self.flippingLayer addSublayer:flippingViewOverlayLabel];
//	[self.parentView.layer addSublayer:self.flippingLayer];
//	[self.view addSubview:self.parentView];
//	CATransform3D perspective = CATransform3DIdentity;
//	perspective.m34 = -1.0 / 500.0;
//	self.flippingLayer.sublayerTransform = perspective;
//
//	UITapGestureRecognizer* tapRecognizer =
//	    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (animateFlippingLayer)];
//	[self.parentView addGestureRecognizer:tapRecognizer];
//}
//
//- (UIImage*)backgroundImageFromBlurredEffectValue:(BlurredImageEffect)blurredImageEffectValue {
//	NSString* blurredImageName = @"";
//	if (blurredImageEffectValue == BlurredImageEffectSpotlight) {
//		blurredImageName = @"blur-spotlight";
//	} else if (blurredImageEffectValue == BlurredImageEffectBlack) {
//		blurredImageName = @"blur-black";
//	} else if (blurredImageEffectValue == BlurredImageEffectColorful) {
//		blurredImageName = @"blur-colorful";
//	} else if (blurredImageEffectValue == BlurredImageEffectBlue) {
//		blurredImageName = @"blur-blue";
//	}
//	UIImage* im = [UIImage imageNamed:blurredImageName];
//	return im;
//}
//
//- (void)setupPositionAndAnchorPoint {
//	CGPoint flappingLayerPosition;
//	CGPoint flappingLayerAnchorPoint;
//
//	if (self.flapOpeningModeValue == JKFlapOpeningMode3D) {
//		if (self.flapOpening3DModeValue == JKFlapOpeningMode3DTop) {
//			flappingLayerPosition = CGPointMake (_flippingViewDimensions.width / 2.0, 0);
//			flappingLayerAnchorPoint = CGPointMake (0.5, 0);
//			self.animatingPropertyKeyPath = @"transform.rotation.x";
//		} else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DLeft) {
//			flappingLayerPosition = CGPointMake (0, _flippingViewDimensions.height / 2.0);
//			flappingLayerAnchorPoint = CGPointMake (0, 0.5);
//			self.animatingPropertyKeyPath = @"transform.rotation.y";
//		} else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DBottom) {
//			flappingLayerPosition =
//			    CGPointMake (_flippingViewDimensions.width / 2.0, _flippingViewDimensions.height);
//			flappingLayerAnchorPoint = CGPointMake (0.5, 1);
//			self.animatingPropertyKeyPath = @"transform.rotation.x";
//		} else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DRight) {
//			flappingLayerPosition =
//			    CGPointMake (_flippingViewDimensions.width, _flippingViewDimensions.height / 2.0);
//			flappingLayerAnchorPoint = CGPointMake (1, 0.5);
//			self.animatingPropertyKeyPath = @"transform.rotation.y";
//		}
//	} else {
//		if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionTopLeft) {
//			flappingLayerPosition = CGPointMake (0, 0);
//			flappingLayerAnchorPoint = CGPointMake (0, 0);
//		} else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionBottomLeft) {
//			flappingLayerPosition = CGPointMake (0, _flippingViewDimensions.height);
//			flappingLayerAnchorPoint = CGPointMake (0, 1);
//		} else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionBottomRight) {
//			flappingLayerPosition =
//			    CGPointMake (_flippingViewDimensions.width, _flippingViewDimensions.height);
//			flappingLayerAnchorPoint = CGPointMake (1, 1);
//		} else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionTopRight) {
//			flappingLayerPosition = CGPointMake (1, 0);
//			flappingLayerAnchorPoint = CGPointMake (_flippingViewDimensions.width, 0);
//		}
//		self.animatingPropertyKeyPath = @"transform.rotation.z";
//	}
//	self.flippingLayer.position = flappingLayerPosition;
//	self.flippingLayer.anchorPoint = flappingLayerAnchorPoint;
//}
//
//- (void)animateFlippingLayer {
//	CGFloat fromVal;
//	CGFloat toVal;
//	CGColorRef toColorValue;
//	CGColorRef fromColorValue;
//	CATransform3D transformToApply;
//
//	if (!self.flapOpened) {
//		fromVal = 0;
//		toVal = degreesToRadians (_flapOpeningAngle);
//		toColorValue = [UIColor redColor].CGColor;
//		fromColorValue = [UIColor blackColor].CGColor;
//	} else {
//		fromVal = degreesToRadians (_flapOpeningAngle);
//		toVal = 0;
//		toColorValue = [UIColor blackColor].CGColor;
//		fromColorValue = [UIColor redColor].CGColor;
//	}
//
//	if (self.flapOpeningModeValue == JKFlapOpeningMode2D) {
//		if (self.flapOpening2DDirectionValue == JKFlapOpening2DDirectionAnticlockwise) {
//			toVal = -1 * toVal;
//		}
//		transformToApply = CATransform3DMakeRotation (toVal, 0, 0, 1);
//	} else if (self.flapOpeningModeValue == JKFlapOpeningMode3D) {
//		if (self.flapOpening3DModeValue == JKFlapOpeningMode3DTop ||
//		    self.flapOpening3DModeValue == JKFlapOpeningMode3DBottom) {
//			transformToApply = CATransform3DMakeRotation (toVal, 1, 0, 0);
//		} else {
//			transformToApply = CATransform3DMakeRotation (toVal, 0, 1, 0);
//		}
//	}
//
//	CABasicAnimation* rotation3DAnimation = [CAKeyframeAnimation animationWithKeyPath:self.animatingPropertyKeyPath
//										 function:ElasticEaseOut
//										fromValue:fromVal
//										  toValue:toVal];
//	self.flapOpened = !self.flapOpened;
//	CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
//	animationGroup.animations = @[ rotation3DAnimation ];
//	animationGroup.duration = _animationDuration;
//	animationGroup.delegate = self;
//	animationGroup.fillMode = kCAFillModeBoth;
//	[self.flippingLayer addAnimation:animationGroup forKey:RotationAnimationKey];
//	self.flippingLayer.transform = transformToApply;
//}
//
//- (void)animationDidStop:(CAAnimation*)anim finished:(BOOL)flag {
//	if ([self.delegate conformsToProtocol:@protocol (AnimationCompleteProtocol)] &&
//	    [self.delegate respondsToSelector:@selector (flipAnimationEnded)]) {
//		[self.delegate flipAnimationEnded];
//	}
//}
//
//- (void)animationDidStart:(CAAnimation*)anim {
//	if ([self.delegate conformsToProtocol:@protocol (AnimationCompleteProtocol)] &&
//	    [self.delegate respondsToSelector:@selector (flipAnimationBegan)]) {
//		[self.delegate flipAnimationBegan];
//	}
//}
//
//static inline CGFloat degreesToRadians (CGFloat degrees) {
//	return degrees * (M_PI / 180.0);
//}
//

@end
