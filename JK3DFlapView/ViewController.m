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
//	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[viewInducingVibrancy]-10-|"
//									  options:kNilOptions
//									  metrics:nil
//									    views:NSDictionaryOfVariableBindings (
//										      viewInducingVibrancy)]];
//	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-164-[viewInducingVibrancy(200)]"
//									  options:kNilOptions
//									  metrics:nil
//									    views:NSDictionaryOfVariableBindings (
//										      viewInducingVibrancy)]];
//	[self.view addConstraints:[NSLayoutConstraint
//				      constraintsWithVisualFormat:@"H:|[vibrantLabel]|"
//							  options:kNilOptions
//							  metrics:nil
//							    views:NSDictionaryOfVariableBindings (vibrantLabel)]];
//	[self.view addConstraints:[NSLayoutConstraint
//				      constraintsWithVisualFormat:@"V:|[vibrantLabel]|"
//							  options:kNilOptions
//							  metrics:nil
//							    views:NSDictionaryOfVariableBindings (vibrantLabel)]];
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
    UIView* parentView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 300, 200)];
    parentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:parentView];
    
    UIView* childView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    [childView setBackgroundColor:[UIColor yellowColor]];
    [parentView addSubview:childView];
    
    CABasicAnimation* rotateAnimation = [CABasicAnimation animation];
    rotateAnimation.keyPath = @"transform";
    rotateAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //Pivot on the right edge (y axis rotation)
    childView.layer.anchorPoint = CGPointMake(0.0, 1.0);
    CATransform3D theTransform = CATransform3DIdentity;
    theTransform.m34 = -1/500.0;
    //theTransform = CATransform3DTranslate(theTransform, 0, -100, 0);
    theTransform = CATransform3DRotate(theTransform, ((-120*M_PI)/180.0), 1, 0, 0);
    
    
    rotateAnimation.toValue = [NSValue valueWithCATransform3D:theTransform];
    
    rotateAnimation.duration = 6;
    
    // leaves presentation layer in final state; preventing snap-back to original state
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.fillMode = kCAFillModeBoth;
    
    rotateAnimation.repeatCount = 0;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotateAnimation.delegate = self;
    [childView.layer addAnimation:rotateAnimation forKey:@"transform"];
}

@end
