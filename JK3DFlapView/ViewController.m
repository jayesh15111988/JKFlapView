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

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
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
    UIView* parentView = [UIView new];
    parentView.frame = CGRectMake(0, 0, 128, 128);
    parentView.center = CGPointMake(150, 150);
    parentView.backgroundColor = [UIColor greenColor];
    
    
    self.doorLayer = [CALayer layer];
	self.doorLayer.frame = CGRectMake (0, 0, 128, 128);
	self.doorLayer.position = CGPointMake (64, 0);
	self.doorLayer.anchorPoint = CGPointMake (0.5, 0);
	[self.doorLayer addSublayer:viewInducingVibrancy.layer];
    [parentView.layer addSublayer:self.doorLayer];
	[self.view addSubview:parentView];
	CATransform3D perspective = CATransform3DIdentity;
	perspective.m34 = -1.0 / 500.0;
	self.view.layer.sublayerTransform = perspective;
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateDoorLayer)];
    [parentView addGestureRecognizer:tapRecognizer];
}

- (void)animateDoorLayer {
    
    CABasicAnimation *colorChangeAnimation = [CABasicAnimation animation];
    colorChangeAnimation.toValue = (__bridge id)[UIColor yellowColor].CGColor;
    colorChangeAnimation.keyPath = @"backgroundColor";
    
    CABasicAnimation *animation1 = [CABasicAnimation animation];
    animation1.delegate = self;
    animation1.keyPath = @"transform.rotation.x";
    
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
    animationGroup.animations = @[ colorChangeAnimation, animation1];
    animationGroup.duration = 1.0;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.fillMode = kCAFillModeBoth;
    [self.doorLayer addAnimation:animationGroup forKey:@"translateAnimation"];
}

@end
