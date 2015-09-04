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
#import "JKFlippingView.h"

@interface ViewController () <AnimationCompleteDelegate>

@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString* animatingPropertyKeyPath;
@property (nonatomic, strong) JKFlippingView* flippingView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_flippingView = [[JKFlippingView alloc] init3DFlapWithOpeningMode:JKFlapOpeningMode3DBottom
							  andFlipviewSize:CGSizeMake (150, 150)];
	_flippingView.translatesAutoresizingMaskIntoConstraints = NO;
	_flippingView.blurredImageEffectValue = JKBlurredImageEffectColorful;
	_flippingView.overlayLabelTextValue = @"This is my \n3D overlay view\n that's it\n Meg Ryan";
	_flippingView.delegate = self;
	_flippingView.backgroundColor = [UIColor greenColor];
	[self.view addSubview:_flippingView];
	[self.view addConstraints:[NSLayoutConstraint
				      constraintsWithVisualFormat:@"H:|-50-[_flippingView]-50-|"
							  options:kNilOptions
							  metrics:nil
							    views:NSDictionaryOfVariableBindings (_flippingView)]];
	[self.view addConstraints:[NSLayoutConstraint
				      constraintsWithVisualFormat:@"V:|-100-[_flippingView]-100-|"
							  options:kNilOptions
							  metrics:nil
							    views:NSDictionaryOfVariableBindings (_flippingView)]];
}

// This is update overlay layer and label sizes in case user is making use of Auto Layout.
- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	[_flippingView updateSize];
}

#pragma Optional delegate methods to indicate beginning and ending of flip animation each time activity begins.

- (void)flipAnimationBegan {
}

- (void)flipAnimationEnded {
}

@end
