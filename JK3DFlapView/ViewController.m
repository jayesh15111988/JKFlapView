//
//  ViewController.m
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/29/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer *doorLayer;
@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString* animatingPropertyKeyPath;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.flapOpeningMode = FlapOpeningModeTop;
	UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
	UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:effect];
	UIVisualEffectView *viewInducingVibrancy = [[UIVisualEffectView alloc] initWithEffect:effect];
	viewInducingVibrancy.frame = CGRectMake (0, 0, 128, 128);
	[viewWithBlurredBackground.contentView addSubview:viewInducingVibrancy];
	UILabel *vibrantLabel = [UILabel new];
	vibrantLabel.text = @"fs df dsf dsf ds fds f";
	vibrantLabel.frame = CGRectMake (0, 0, 128, 44);
	vibrantLabel.textAlignment = NSTextAlignmentCenter;
	[viewInducingVibrancy addSubview:vibrantLabel];
	self.flapOpened = NO;
	UIView *parentView = [UIView new];
	parentView.frame = CGRectMake (0, 0, 128, 128);
	parentView.center = CGPointMake (150, 150);
	parentView.backgroundColor = [UIColor greenColor];

	self.doorLayer = [CALayer layer];
	self.doorLayer.frame = CGRectMake (0, 0, 128, 128);
    self.flapOpeningMode = FlapOpeningModeright;
    
    [self setupPositionAndAnchorPoint];
	[self.doorLayer addSublayer:viewInducingVibrancy.layer];
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
	colorChangeAnimation.toValue = (__bridge id)[UIColor yellowColor].CGColor;
	colorChangeAnimation.keyPath = @"backgroundColor";

	CABasicAnimation *animation1 = [CABasicAnimation animation];
	animation1.delegate = self;
	animation1.keyPath = self.animatingPropertyKeyPath;
	if (!self.flapOpened) {
		animation1.fromValue = @(0);
		animation1.toValue = @(110 * (M_PI / 180.0));
	} else {
		animation1.fromValue = @(110 * (M_PI / 180.0));
		animation1.toValue = @(0);
	}

	self.flapOpened = !self.flapOpened;
	animation1.fillMode = kCAFillModeBoth;
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = @[animation1];
	animationGroup.duration = 1.0;
	animationGroup.removedOnCompletion = NO;
	animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	animationGroup.fillMode = kCAFillModeBoth;
	[self.doorLayer addAnimation:animationGroup forKey:@"translateAnimation"];
}

@end
