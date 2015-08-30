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

static NSString* const RotationAnimationKey = @"viewRotationAnimation";

@interface ViewController ()

@property (nonatomic, strong) CALayer* doorLayer;
@property (nonatomic, strong) UIView* parentView;
@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString* animatingPropertyKeyPath;
@property (nonatomic, assign) CGFloat flapOpeningAngle;
@property (nonatomic, assign) CGFloat flapOverlayViewAlpha;
@property (nonatomic, strong) UIImage* overlayLayerBackgroundImage;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, strong) NSString* overlayLabelTextValue;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.flapOpeningAngle = 120.0;
    _animationDuration = 0.75f;
	self.flapOpening3DModeValue = FlapOpeningMode3DTop;
	self.flapOpeningModeValue = FlapOpeningMode2D;
	self.flapOpening2DPositionValue = FlapOpening2DPositionBottomRight;
	self.flapOpening2DDirectionValue = FlapOpening2DDirectionAnticlockwise;
	self.overlayLayerBackgroundImage = [UIImage imageNamed:@"blur2.jpg"];
	self.flapOverlayViewAlpha = 1.0;
	_overlayLabelTextValue = @"fs df dsf dsf ds fds fas das d asd ";

	CATextLayer* vibrantLabel = [CATextLayer layer];
	vibrantLabel.string = _overlayLabelTextValue;
	vibrantLabel.frame = CGRectMake (0, 32, 128, 64);
	vibrantLabel.wrapped = YES;
	vibrantLabel.alignmentMode = kCAAlignmentCenter;
	[vibrantLabel setFontSize:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0].pointSize];
	self.flapOpened = NO;
	self.parentView = [UIView new];
	self.parentView.frame = CGRectMake (0, 0, 128, 128);
	self.parentView.center = CGPointMake (150, 150);
	self.parentView.layer.contents = (__bridge id)[UIImage imageNamed:@"sp.jpg"].CGImage;

	self.doorLayer = [CALayer layer];
	self.doorLayer.frame = CGRectMake (0, 0, 128, 128);
	self.doorLayer.backgroundColor = [UIColor clearColor].CGColor;
	self.doorLayer.contents =
	    (__bridge id)[[UIImage imageNamed:@"blur.jpg"] imageByApplyingAlpha:_flapOverlayViewAlpha].CGImage;

	[self setupPositionAndAnchorPoint];
	[self.doorLayer addSublayer:vibrantLabel];
	[self.parentView.layer addSublayer:self.doorLayer];
	[self.view addSubview:self.parentView];
	CATransform3D perspective = CATransform3DIdentity;
	perspective.m34 = -1.0 / 500.0;
	self.doorLayer.sublayerTransform = perspective;

	UITapGestureRecognizer* tapRecognizer =
	    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (animateDoorLayer)];
	[self.parentView addGestureRecognizer:tapRecognizer];
}

- (void)setupPositionAndAnchorPoint {
    CGPoint flappingLayerPosition;
    CGPoint flappingLayerAnchorPoint;
    if (self.flapOpeningModeValue == FlapOpeningMode3D) {
        if (self.flapOpening3DModeValue == FlapOpeningMode3DTop) {
            flappingLayerPosition = CGPointMake (64, 0);
            flappingLayerAnchorPoint = CGPointMake (0.5, 0);
            self.animatingPropertyKeyPath = @"transform.rotation.x";
        } else if (self.flapOpening3DModeValue == FlapOpeningMode3DLeft) {
            flappingLayerPosition = CGPointMake (0, 64);
            flappingLayerAnchorPoint = CGPointMake (0, 0.5);
            self.animatingPropertyKeyPath = @"transform.rotation.y";
        } else if (self.flapOpening3DModeValue == FlapOpeningMode3DBottom) {
            flappingLayerPosition = CGPointMake (64, 128);
            flappingLayerAnchorPoint = CGPointMake (0.5, 1);
            self.animatingPropertyKeyPath = @"transform.rotation.x";
        } else if (self.flapOpening3DModeValue == FlapOpeningMode3DRight) {
            flappingLayerPosition = CGPointMake (128, 64);
            flappingLayerAnchorPoint = CGPointMake (1, 0.5);
            self.animatingPropertyKeyPath = @"transform.rotation.y";
        }
    } else {
        if (self.flapOpening2DPositionValue == FlapOpening2DPositionTopLeft) {
            flappingLayerPosition = CGPointMake (0, 0);
            flappingLayerAnchorPoint = CGPointMake (0, 0);
        } else if (self.flapOpening2DPositionValue == FlapOpening2DPositionBottomLeft) {
            flappingLayerPosition = CGPointMake (0, 128);
            flappingLayerAnchorPoint = CGPointMake (0, 1);
        } else if (self.flapOpening2DPositionValue == FlapOpening2DPositionBottomRight) {
            flappingLayerPosition = CGPointMake (128, 128);
            flappingLayerAnchorPoint = CGPointMake (1, 1);
        } else if (self.flapOpening2DPositionValue == FlapOpening2DPositionTopRight) {
            flappingLayerPosition = CGPointMake (1, 0);
            flappingLayerAnchorPoint = CGPointMake (128, 0);
        }
        self.animatingPropertyKeyPath = @"transform.rotation.z";
    }
    self.doorLayer.position = flappingLayerPosition;
    self.doorLayer.anchorPoint = flappingLayerAnchorPoint;
}

- (void)animateDoorLayer {

	CABasicAnimation* colorChangeAnimation = [CABasicAnimation animation];
	colorChangeAnimation.keyPath = @"backgroundColor";

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

	if (self.flapOpeningModeValue == FlapOpeningMode2D) {
		if (self.flapOpening2DDirectionValue == FlapOpening2DDirectionAnticlockwise) {
			toVal = -1 * toVal;
		}
		transformToApply = CATransform3DMakeRotation (toVal, 0, 0, 1);
	} else if (self.flapOpeningModeValue == FlapOpeningMode3D) {
		if (self.flapOpening3DModeValue == FlapOpeningMode3DTop ||
		    self.flapOpening3DModeValue == FlapOpeningMode3DBottom) {
			transformToApply = CATransform3DMakeRotation (toVal, 1, 0, 0);
		} else {
			transformToApply = CATransform3DMakeRotation (toVal, 0, 1, 0);
		}
	}

	colorChangeAnimation.toValue = (__bridge id)toColorValue;
	colorChangeAnimation.fromValue = (__bridge id)fromColorValue;
	CABasicAnimation* chase = [CAKeyframeAnimation animationWithKeyPath:self.animatingPropertyKeyPath
								   function:ElasticEaseOut
								  fromValue:fromVal
								    toValue:toVal];
	self.flapOpened = !self.flapOpened;
	CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = @[ chase ];
	animationGroup.duration = _animationDuration;
	animationGroup.delegate = self;
	animationGroup.fillMode = kCAFillModeBoth;
	[self.doorLayer addAnimation:animationGroup forKey:@"rotationAnimation"];
	self.doorLayer.transform = transformToApply;
}

- (void)animationDidStop:(CAAnimation*)anim finished:(BOOL)flag {
	if ([self.delegate conformsToProtocol:@protocol (AnimationCompleteProtocol)] &&
	    [self.delegate respondsToSelector:@selector (flapAnimationEnded)]) {
		[self.delegate flapAnimationEnded];
	}
}

static inline CGFloat degreesToRadians (CGFloat degrees) {
	return degrees * (M_PI / 180.0);
}

@end
