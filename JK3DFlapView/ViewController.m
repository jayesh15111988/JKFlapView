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
	//	UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	//	UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:effect];
	//	UIVisualEffectView *viewInducingVibrancy = [[UIVisualEffectView alloc] initWithEffect:effect];
	//	[viewWithBlurredBackground.contentView addSubview:viewInducingVibrancy];
	//	UILabel *vibrantLabel = [UILabel new];
	//	vibrantLabel.text = @"fs df dsf dsf ds fds f";
	//    vibrantLabel.textAlignment = NSTextAlignmentCenter;
	//
	//	[self.view setBackgroundColor:[UIColor yellowColor]];
	//	vibrantLabel.translatesAutoresizingMaskIntoConstraints = NO;
	//	viewInducingVibrancy.translatesAutoresizingMaskIntoConstraints = NO;
	//	[viewInducingVibrancy.contentView addSubview:vibrantLabel];
	//
	//    UIView* overlayView = [UIView new];
	//    overlayView.translatesAutoresizingMaskIntoConstraints = NO;
	//    overlayView.backgroundColor = [UIColor colorWithRed:0.2 green:0.1 blue:0.5 alpha:1.0];
	//    [viewInducingVibrancy addSubview:overlayView];
	//    viewInducingVibrancy.clipsToBounds = NO;
	//
	//	[self.view addSubview:viewInducingVibrancy];
	//	[self.view addConstraints:[NSLayoutConstraint
	// constraintsWithVisualFormat:@"H:|-10-[viewInducingVibrancy]-10-|"
	//									  options:kNilOptions
	//									  metrics:nil
	//									    views:NSDictionaryOfVariableBindings
	//(
	//										      viewInducingVibrancy)]];
	//	[self.view addConstraints:[NSLayoutConstraint
	// constraintsWithVisualFormat:@"V:|-164-[viewInducingVibrancy(200)]"
	//									  options:kNilOptions
	//									  metrics:nil
	//									    views:NSDictionaryOfVariableBindings
	//(
	//										      viewInducingVibrancy)]];
	//	[self.view addConstraints:[NSLayoutConstraint
	//				      constraintsWithVisualFormat:@"H:|[vibrantLabel]|"
	//							  options:kNilOptions
	//							  metrics:nil
	//							    views:NSDictionaryOfVariableBindings
	//(vibrantLabel)]];
	//	[self.view addConstraints:[NSLayoutConstraint
	//				      constraintsWithVisualFormat:@"V:|[vibrantLabel]|"
	//							  options:kNilOptions
	//							  metrics:nil
	//							    views:NSDictionaryOfVariableBindings
	//(vibrantLabel)]];
	//
	//    [self.view addConstraints:[NSLayoutConstraint
	//                               constraintsWithVisualFormat:@"H:|[overlayView]|"
	//                               options:kNilOptions
	//                               metrics:nil
	//                               views:NSDictionaryOfVariableBindings (overlayView)]];
	//    [self.view addConstraints:[NSLayoutConstraint
	//                               constraintsWithVisualFormat:@"V:|[overlayView]|"
	//                               options:kNilOptions
	//                               metrics:nil
	//                               views:NSDictionaryOfVariableBindings (overlayView)]];
	//
	//    CABasicAnimation* rotateAnimation = [CABasicAnimation animation];
	//    rotateAnimation.keyPath = @"transform";
	//    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	//
	//    //Pivot on the right edge (y axis rotation)
	//    overlayView.layer.anchorPoint = CGPointMake(0.0, 1.0);
	//    CATransform3D theTransform = CATransform3DIdentity;
	//    theTransform.m34 = -1/500.0;
	//    //theTransform = CATransform3DTranslate(theTransform, 0, -100, 0);
	//    theTransform = CATransform3DRotate(theTransform, ((-120*M_PI)/180.0), 1, 0, 0);
	//
	//
	//    rotateAnimation.toValue = [NSValue valueWithCATransform3D:theTransform];
	//
	//    rotateAnimation.duration = 6;
	//
	//    // leaves presentation layer in final state; preventing snap-back to original state
	//    rotateAnimation.removedOnCompletion = NO;
	//    rotateAnimation.fillMode = kCAFillModeBoth;
	//
	//    rotateAnimation.repeatCount = 0;
	//    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	//    rotateAnimation.delegate = self;
	//    [overlayView.layer addAnimation:rotateAnimation forKey:@"transform"];

	UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	UIVisualEffectView *viewWithBlurredBackground = [[UIVisualEffectView alloc] initWithEffect:effect];
	UIVisualEffectView *viewInducingVibrancy = [[UIVisualEffectView alloc] initWithEffect:effect];
    viewInducingVibrancy.frame = CGRectMake(0, 0, 128, 256);
	[viewWithBlurredBackground.contentView addSubview:viewInducingVibrancy];
	UILabel *vibrantLabel = [UILabel new];
	vibrantLabel.text = @"fs df dsf dsf ds fds f";
    vibrantLabel.backgroundColor = [UIColor redColor];
    vibrantLabel.frame = CGRectMake(0, 0, 200, 44);
	vibrantLabel.textAlignment = NSTextAlignmentCenter;
	viewInducingVibrancy.translatesAutoresizingMaskIntoConstraints = NO;
	[viewInducingVibrancy.contentView.layer addSublayer:vibrantLabel.layer];
    viewInducingVibrancy.clipsToBounds = YES;

	CALayer *doorLayer = [CALayer layer];
    doorLayer.masksToBounds = YES;
	doorLayer.frame = CGRectMake (0, 0, 128, 256);
	doorLayer.position = CGPointMake (150, 150);
	doorLayer.anchorPoint = CGPointMake (0, 0.5);
    [doorLayer addSublayer:viewInducingVibrancy.layer];
	[self.view.layer addSublayer:doorLayer]; // apply perspective transform
	CATransform3D perspective = CATransform3DIdentity;
	perspective.m34 = -1.0 / 500.0;
	//doorLayer.transform = perspective; // apply swinging animation
	CABasicAnimation *animation = [CABasicAnimation animation];
	animation.keyPath = @"transform.rotation.x";
    animation.fromValue = @(0);
	animation.toValue = @(M_PI_4);
	animation.duration = 2.0;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
	//animation.repeatCount = 1;
	//animation.autoreverses = YES;
    animation.fillMode = kCAFillModeBoth;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
	//[doorLayer addAnimation:animation forKey:nil];
    
    CABasicAnimation* colorChangeAnimation = [CABasicAnimation animation];
    colorChangeAnimation.toValue = (__bridge id)[UIColor yellowColor].CGColor;
    colorChangeAnimation.keyPath = @"backgroundColor";
    
    CABasicAnimation* animation1 = [CABasicAnimation animation];
    animation1.delegate = self;
    animation1.keyPath = @"transform.rotation.x";
    animation1.fromValue = @(0);
    animation1.toValue = @(120*(M_PI/180.0));
    animation1.fillMode = kCAFillModeBoth;
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[colorChangeAnimation, animation1];
    animationGroup.duration = 2.0;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.fillMode = kCAFillModeBoth;
    [doorLayer addAnimation:animationGroup forKey:@"translateAnimation"];
}

@end
