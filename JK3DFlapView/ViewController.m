//
//  ViewController.m
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/29/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:effect];
	UIVisualEffectView *viewInducingVibrancy = [[UIVisualEffectView alloc] initWithEffect:effect];
    viewInducingVibrancy.frame = CGRectMake(0, 0, 128, 128);
	[viewWithBlurredBackground.contentView addSubview:viewInducingVibrancy];
	UILabel *vibrantLabel = [UILabel new];
	vibrantLabel.text = @"fs df dsf dsf ds fds f";
    vibrantLabel.frame = CGRectMake(0, 0, 128, 44);
	vibrantLabel.textAlignment = NSTextAlignmentCenter;
	[viewInducingVibrancy addSubview:vibrantLabel];


	CALayer *doorLayer = [CALayer layer];
	doorLayer.frame = CGRectMake (0, 0, 128, 128);
	doorLayer.position = CGPointMake (150, 150);
	doorLayer.anchorPoint = CGPointMake (0.5, 0);
    [doorLayer addSublayer:viewInducingVibrancy.layer];
	[self.view.layer addSublayer:doorLayer]; // apply perspective transform
	CATransform3D perspective = CATransform3DIdentity;
	perspective.m34 = -1.0 / 500.0;
	self.view.layer.sublayerTransform = perspective; // apply swinging animation
	
    
    CABasicAnimation* colorChangeAnimation = [CABasicAnimation animation];
    colorChangeAnimation.toValue = (__bridge id)[UIColor yellowColor].CGColor;
    colorChangeAnimation.keyPath = @"backgroundColor";
    
    CABasicAnimation* animation1 = [CABasicAnimation animation];
    animation1.delegate = self;
    animation1.keyPath = @"transform.rotation.x";
    animation1.fromValue = @(0);
    animation1.toValue = @(90*(M_PI/180.0));
    animation1.fillMode = kCAFillModeBoth;
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[colorChangeAnimation, animation1];
    animationGroup.duration = 2.0;
    animationGroup.repeatCount = 2;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.fillMode = kCAFillModeBoth;
    [doorLayer addAnimation:animationGroup forKey:@"translateAnimation"];
}

@end
