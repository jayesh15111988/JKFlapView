//
//  ViewController.m
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/29/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <AHEasing/CAKeyframeAnimation+AHEasing.h>
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer *doorLayer;
@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString *animatingPropertyKeyPath;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.flapOpeningMode = FlapOpeningModeTop;
	CATextLayer *vibrantLabel = [CATextLayer layer];
	vibrantLabel.string = @"fs df dsf dsf ds fds fas das d asd ";
	vibrantLabel.frame = CGRectMake (0, 32, 128, 64);
	vibrantLabel.wrapped = YES;
	vibrantLabel.alignmentMode = kCAAlignmentCenter;
	[vibrantLabel setFontSize:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0].pointSize];
	self.flapOpened = NO;
	UIView *parentView = [UIView new];
	parentView.frame = CGRectMake (0, 0, 128, 128);
	parentView.center = CGPointMake (150, 150);
	parentView.backgroundColor = [UIColor greenColor];
	parentView.layer.contents = (__bridge id)[UIImage imageNamed:@"sp.jpg"].CGImage;

	self.doorLayer = [CALayer layer];
	self.doorLayer.frame = CGRectMake (0, 0, 128, 128);
	self.doorLayer.backgroundColor = [UIColor clearColor].CGColor;
	self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"blur.jpg"].CGImage;
	self.doorLayer.opacity = 0.9;

	[self setupPositionAndAnchorPoint];
	[self.doorLayer addSublayer:vibrantLabel];
	[parentView.layer addSublayer:self.doorLayer];
	[self.view addSubview:parentView];
	CATransform3D perspective = CATransform3DIdentity;
	perspective.m34 = -1.0 / 500.0;
	self.view.layer.sublayerTransform = perspective;

	UITapGestureRecognizer *tapRecognizer =
	    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (animateDoorLayer)];
	[parentView addGestureRecognizer:tapRecognizer];
}

- (void)setupPositionAndAnchorPoint {
	CGPoint flappingLayerPosition;
	CGPoint flappingLayerAnchorPoint;
	if (self.flapOpeningMode == FlapOpeningModeTop) {
		flappingLayerPosition = CGPointMake (64, 0);
		flappingLayerAnchorPoint = CGPointMake (0.5, 0);
		self.animatingPropertyKeyPath = @"transform.rotation.x";
	} else if (self.flapOpeningMode == FlapOpeningModeBottom) {
		flappingLayerPosition = CGPointMake (64, 128);
		flappingLayerAnchorPoint = CGPointMake (0.5, 1);
		self.animatingPropertyKeyPath = @"transform.rotation.x";
	} else if (self.flapOpeningMode == FlapOpeningModeLeft) {
		flappingLayerPosition = CGPointMake (0, 64);
		flappingLayerAnchorPoint = CGPointMake (0, 0.5);
		self.animatingPropertyKeyPath = @"transform.rotation.y";
	} else if (self.flapOpeningMode == FlapOpeningModeright) {
		flappingLayerPosition = CGPointMake (128, 64);
		flappingLayerAnchorPoint = CGPointMake (1, 0.5);
		self.animatingPropertyKeyPath = @"transform.rotation.y";
	}
	self.doorLayer.position = flappingLayerPosition;
	self.doorLayer.anchorPoint = flappingLayerAnchorPoint;
}

- (void)animateDoorLayer {

	CABasicAnimation *colorChangeAnimation = [CABasicAnimation animation];
	colorChangeAnimation.keyPath = @"backgroundColor";

	CGFloat fromVal;
	CGFloat toVal;
	CGColorRef toColorValue;
	CGColorRef fromColorValue;

	if (!self.flapOpened) {
		fromVal = 0;
		toVal = 110 * (M_PI / 180.0);
		toColorValue = [UIColor redColor].CGColor;
		fromColorValue = [UIColor blackColor].CGColor;
	} else {
		fromVal = 110 * (M_PI / 180.0);
		toVal = 0;
		toColorValue = [UIColor blackColor].CGColor;
		fromColorValue = [UIColor redColor].CGColor;
	}

	colorChangeAnimation.toValue = (__bridge id)toColorValue;
	colorChangeAnimation.fromValue = (__bridge id)fromColorValue;
	CABasicAnimation *chase = [CAKeyframeAnimation animationWithKeyPath:self.animatingPropertyKeyPath
								   function:ElasticEaseOut
								  fromValue:fromVal
								    toValue:toVal];
	self.flapOpened = !self.flapOpened;
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = @[ chase ];
	animationGroup.duration = 0.75;
	animationGroup.removedOnCompletion = NO;
	// animationGroup.delegate = self;
	animationGroup.fillMode = kCAFillModeBoth;
	[self.doorLayer addAnimation:animationGroup forKey:@"translateAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	NSLog (@"Stopped");
}

@end
