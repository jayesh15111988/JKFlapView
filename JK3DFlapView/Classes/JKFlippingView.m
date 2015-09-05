//
//  JK3DFlippingView.m
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/30/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <BlocksKit/BlocksKit+UIKit.h>
#import "UIImage+AlphaChange.h"
#import "JKFlippingView.h"

static NSString* const RotationAnimationKey = @"viewRotationAnimation";

@interface JKFlippingView ()

@property (nonatomic, strong) CALayer* flippingLayer;
@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString* animatingPropertyKeyPath;
@property (nonatomic, assign) CGSize flippingViewDimensions;
@property (nonatomic, strong) UITapGestureRecognizer* tapRecognizer;
@property (nonatomic, strong) CATextLayer* flippingViewOverlayLabel;
@property (nonatomic, strong) UIFont* overlayLabelFont;

@property (nonatomic, assign) JKFlapOpeningMode flapOpeningModeValue;
@property (nonatomic, assign) JKFlapOpening2DDirection flapOpening2DDirectionValue;
@property (nonatomic, assign) JKFlapOpening2DPosition flapOpening2DPositionValue;
@property (nonatomic, assign) JKFlapOpening3DMode flapOpening3DModeValue;

@end

@implementation JKFlippingView

- (instancetype)init2DFlapWithPosition:(JKFlapOpening2DPosition)flapOpeningPosition
	 and2DModeFlapOpeningDirection:(JKFlapOpening2DDirection)flapOpeningDirection
		       andFlipviewSize:(CGSize)flippingViewSize {
	if (self = [super init]) {
		_flapOpeningModeValue = JKFlapOpeningMode2D;
		_flapOpening2DPositionValue = flapOpeningPosition;
		_flapOpening2DDirectionValue = flapOpeningDirection;
		_flippingViewDimensions = flippingViewSize;
		[self setupDefaultParametersValues];
	}
	return (JKFlippingView*)[self setupFlipView];
	;
}

- (instancetype)init3DFlapWithOpeningMode:(JKFlapOpening3DMode)flapOpening3DMode
			  andFlipviewSize:(CGSize)flippingViewSize {
	if (self = [super init]) {
		_flapOpeningModeValue = JKFlapOpeningMode3D;
		_flapOpening3DModeValue = flapOpening3DMode;
		_flippingViewDimensions = flippingViewSize;
		[self setupDefaultParametersValues];
	}
	return (JKFlippingView*)[self setupFlipView];
}

- (void)setupDefaultParametersValues {
	_flapOpeningAngle = -110.0;
	_animationDuration = 0.5f;
	_blurredImageEffectValue = JKBlurredImageEffectNone;
	_flapOverlayViewAlpha = 0.7;

	_flapOpened = NO;
	self.frame = CGRectMake (0, 0, _flippingViewDimensions.width, _flippingViewDimensions.height);

	_flippingLayer = [CALayer layer];
	_flippingLayer.frame = CGRectMake (0, 0, self.frame.size.width, self.frame.size.height);
	_flippingLayer.backgroundColor = [UIColor clearColor].CGColor;

	CATransform3D perspective = CATransform3DIdentity;
	perspective.m34 = -1.0 / 500.0;
	_flippingLayer.sublayerTransform = perspective;
	_flipAnimationEasingFunction = ElasticEaseOut;
}

- (UIView*)setupFlipView {
	_flippingViewOverlayLabel = [CATextLayer layer];
	_flippingViewOverlayLabel.frame = CGRectMake (0, 0, self.frame.size.width - 20, self.frame.size.height - 20);
	_flippingViewOverlayLabel.wrapped = YES;
	_flippingViewOverlayLabel.contentsScale = [UIScreen mainScreen].scale;
	_flippingViewOverlayLabel.magnificationFilter = kCAFilterNearest;
	_flippingViewOverlayLabel.alignmentMode = kCAAlignmentCenter;
	_overlayLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
	[_flippingViewOverlayLabel setFontSize:_overlayLabelFont.pointSize];
	_flippingViewOverlayLabel.font = (__bridge CFTypeRef)(_overlayLabelFont.fontName);

	_flippingViewOverlayLabel.string = _overlayLabelTextValue;
	_flippingViewOverlayLabel.position = self.flippingLayer.position;
	[self setupPositionAndAnchorPoint];
	[self.flippingLayer addSublayer:_flippingViewOverlayLabel];
	[self.layer addSublayer:self.flippingLayer];

	[self bk_whenTapped:^{
	  [self animateFlippingLayer];
	}];
	return self;
}

- (void)setOverlayLabelTextValue:(NSString*)overlayLabelTextValue {
	_flippingViewOverlayLabel.string = overlayLabelTextValue;
	_overlayLabelTextValue = overlayLabelTextValue;
}

- (UIImage*)backgroundImageFromBlurredEffectValue:(JKBlurredImageEffect)blurredImageEffectValue {
	NSString* blurredImageName = @"";
	if (blurredImageEffectValue == JKBlurredImageEffectSpotlight) {
		blurredImageName = @"JK3DFlap-blur-spotlight";
	} else if (blurredImageEffectValue == JKBlurredImageEffectBlack) {
		blurredImageName = @"JK3DFlap-blur-black";
	} else if (blurredImageEffectValue == JKBlurredImageEffectColorful) {
		blurredImageName = @"JK3DFlap-blur-colorful";
	} else if (blurredImageEffectValue == JKBlurredImageEffectBlue) {
		blurredImageName = @"JK3DFlap-blur-blue";
	}
	UIImage* overlayImage = [UIImage imageNamed:blurredImageName];
	return overlayImage;
}

- (void)setupPositionAndAnchorPoint {
	CGPoint flappingLayerPosition;
	CGPoint flappingLayerAnchorPoint;

	if (self.flapOpeningModeValue == JKFlapOpeningMode3D) {
		if (self.flapOpening3DModeValue == JKFlapOpeningMode3DTop) {
			flappingLayerPosition = CGPointMake (self.frame.size.width / 2.0, 0);
			flappingLayerAnchorPoint = CGPointMake (0.5, 0);
			self.animatingPropertyKeyPath = @"transform.rotation.x";
		} else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DLeft) {
			flappingLayerPosition = CGPointMake (0, self.frame.size.height / 2.0);
			flappingLayerAnchorPoint = CGPointMake (0, 0.5);
			self.animatingPropertyKeyPath = @"transform.rotation.y";
		} else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DBottom) {
			flappingLayerPosition =
			    CGPointMake (_flippingViewDimensions.width / 2.0, self.frame.size.height);
			flappingLayerAnchorPoint = CGPointMake (0.5, 1);
			self.animatingPropertyKeyPath = @"transform.rotation.x";
		} else if (self.flapOpening3DModeValue == JKFlapOpeningMode3DRight) {
			flappingLayerPosition =
			    CGPointMake (_flippingViewDimensions.width, self.frame.size.height / 2.0);
			flappingLayerAnchorPoint = CGPointMake (1, 0.5);
			self.animatingPropertyKeyPath = @"transform.rotation.y";
		}
	} else {
		if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionTopLeft) {
			flappingLayerPosition = CGPointMake (0, 0);
			flappingLayerAnchorPoint = CGPointMake (0, 0);
		} else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionBottomLeft) {
			flappingLayerPosition = CGPointMake (0, self.frame.size.height);
			flappingLayerAnchorPoint = CGPointMake (0, 1);
		} else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionBottomRight) {
			flappingLayerPosition = CGPointMake (_flippingViewDimensions.width, self.frame.size.height);
			flappingLayerAnchorPoint = CGPointMake (1, 1);
		} else if (self.flapOpening2DPositionValue == JKFlapOpening2DPositionTopRight) {
			flappingLayerPosition = CGPointMake (1, 0);
			flappingLayerAnchorPoint = CGPointMake (self.frame.size.width, 0);
		}
		self.animatingPropertyKeyPath = @"transform.rotation.z";
	}
	self.flippingLayer.position = flappingLayerPosition;
	self.flippingLayer.anchorPoint = flappingLayerAnchorPoint;
}

- (void)setBlurredImageEffectValue:(JKBlurredImageEffect)blurredImageEffectValue {
	if (blurredImageEffectValue != JKBlurredImageEffectNone) {
		self.flippingLayer.contents =
		    (__bridge id)[[self backgroundImageFromBlurredEffectValue:blurredImageEffectValue]
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
}

- (void)updateSize {
	_flippingLayer.frame = CGRectMake (0, 0, self.frame.size.width, self.frame.size.height);
	CGFloat labelHeight = [self heightForText:_overlayLabelTextValue andFontApplied:_overlayLabelFont];
	_flippingViewOverlayLabel.frame =
	    CGRectMake (10, (self.frame.size.height - labelHeight) / 2.0, self.frame.size.width - 20, labelHeight);
}

- (CGFloat)heightForText:(NSString*)text andFontApplied:(UIFont*)fontApplied {
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake (0, 0, self.frame.size.width - 20, CGFLOAT_MAX)];
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	label.font = fontApplied;
	label.text = text;
	[label sizeToFit];
	return label.frame.size.height + 10;
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
			// Sorry for this hack, but I am not sure why animation sucks big time while rotating around
			// Y-Axis.
			if (toVal != 0) {
				toVal = M_PI - toVal;
			}
		}
	}

	CABasicAnimation* rotation3DAnimation = [CAKeyframeAnimation animationWithKeyPath:self.animatingPropertyKeyPath
										 function:_flipAnimationEasingFunction
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
	if ([self.delegate conformsToProtocol:@protocol (AnimationCompleteDelegate)] &&
	    [self.delegate respondsToSelector:@selector (flipAnimationEnded)]) {
		[self.delegate flipAnimationEnded];
	}
}

- (void)animationDidStart:(CAAnimation*)anim {
	if ([self.delegate conformsToProtocol:@protocol (AnimationCompleteDelegate)] &&
	    [self.delegate respondsToSelector:@selector (flipAnimationBegan)]) {
		[self.delegate flipAnimationBegan];
	}
}

static inline CGFloat degreesToRadians (CGFloat degrees) {
	return degrees * (M_PI / 180.0);
}

@end
