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
@property (nonatomic, strong) JKFlippingView* flippingView3DDemo1;
@property (nonatomic, strong) JKFlippingView* flippingView3DDemo2;
@property (nonatomic, strong) JKFlippingView* flippingView2DDemo1;
@property (nonatomic, strong) JKFlippingView* flippingView2DDemo2;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_flippingView3DDemo1 =
	    [[JKFlippingView alloc] init3DFlapWithOpeningMode:JKFlapOpeningMode3DTop andFlipviewSize:CGSizeZero];
	_flippingView3DDemo2 =
	    [[JKFlippingView alloc] init3DFlapWithOpeningMode:JKFlapOpeningMode3DLeft andFlipviewSize:CGSizeZero];
	_flippingView2DDemo1 = [[JKFlippingView alloc] init2DFlapWithPosition:JKFlapOpening2DPositionTopLeft
						and2DModeFlapOpeningDirection:JKFlapOpening2DDirectionClockwise
							      andFlipviewSize:CGSizeZero];
	_flippingView2DDemo2 = [[JKFlippingView alloc] init2DFlapWithPosition:JKFlapOpening2DPositionTopRight
						and2DModeFlapOpeningDirection:JKFlapOpening2DDirectionAnticlockwise
							      andFlipviewSize:CGSizeZero];

	_flippingView3DDemo1.translatesAutoresizingMaskIntoConstraints = NO;
	_flippingView3DDemo2.translatesAutoresizingMaskIntoConstraints = NO;
	_flippingView2DDemo1.translatesAutoresizingMaskIntoConstraints = NO;
	_flippingView2DDemo2.translatesAutoresizingMaskIntoConstraints = NO;

	_flippingView3DDemo1.blurredImageEffectValue = JKBlurredImageEffectColorful;
	_flippingView3DDemo2.blurredImageEffectValue = JKBlurredImageEffectSpotlight;
	_flippingView2DDemo1.blurredImageEffectValue = JKBlurredImageEffectBlue;
	_flippingView2DDemo2.blurredImageEffectValue = JKBlurredImageEffectNone;

	_flippingView3DDemo1.overlayLabelTextValue =
	    @"This is 3D\nMultiline Flip view\n Rotating from top\nWith colorful overlay";
	_flippingView3DDemo1.delegate = self;
	_flippingView3DDemo1.backgroundColor = [UIColor greenColor];

	_flippingView3DDemo2.overlayLabelTextValue =
	    @"This is 3D\nMultiline Flip view\n Rotating from leftnWith spotlight overlay";
	_flippingView3DDemo2.delegate = self;
	_flippingView3DDemo2.backgroundColor = [UIColor yellowColor];

	_flippingView2DDemo1.overlayLabelTextValue =
	    @"This is 2D\nMultiline Flip view\n Rotating from top left corner\nWith colorful blue shaded overlay";
	_flippingView2DDemo1.delegate = self;
	_flippingView2DDemo1.backgroundColor = [UIColor redColor];

	_flippingView2DDemo2.overlayLabelTextValue =
	    @"This is 2D\nMultiline Flip view\n Rotating from top right corner\nWith transparent black shaded overlay";
	_flippingView2DDemo2.delegate = self;
	_flippingView2DDemo2.backgroundColor = [UIColor lightGrayColor];

	[self.view addSubview:_flippingView3DDemo1];
	[self.view addSubview:_flippingView3DDemo2];
	[self.view addSubview:_flippingView2DDemo1];
	[self.view addSubview:_flippingView2DDemo2];

	NSDictionary* views = NSDictionaryOfVariableBindings (_flippingView3DDemo1, _flippingView3DDemo2,
							      _flippingView2DDemo1, _flippingView2DDemo2);

	[self.view
	    addConstraints:[NSLayoutConstraint
			       constraintsWithVisualFormat:
				   @"H:|-10-[_flippingView3DDemo1(_flippingView3DDemo2)]-[_flippingView3DDemo2]-10-|"
						   options:kNilOptions
						   metrics:nil
						     views:views]];
	[self.view
	    addConstraints:[NSLayoutConstraint
			       constraintsWithVisualFormat:
				   @"H:|-10-[_flippingView2DDemo1(_flippingView2DDemo2)]-[_flippingView2DDemo2]-10-|"
						   options:kNilOptions
						   metrics:nil
						     views:views]];

	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-75-[_flippingView3DDemo1(200)]"
									  options:kNilOptions
									  metrics:nil
									    views:views]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-75-[_flippingView3DDemo2(200)]"
									  options:kNilOptions
									  metrics:nil
									    views:views]];

	[self.view
	    addConstraints:[NSLayoutConstraint
			       constraintsWithVisualFormat:@"V:[_flippingView3DDemo1]-[_flippingView2DDemo1(200)]"
						   options:kNilOptions
						   metrics:nil
						     views:views]];
	[self.view
	    addConstraints:[NSLayoutConstraint
			       constraintsWithVisualFormat:@"V:[_flippingView3DDemo2]-[_flippingView2DDemo2(200)]"
						   options:kNilOptions
						   metrics:nil
						     views:views]];
}

// This is update overlay layer and label sizes in case user is making use of Auto Layout.
- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	[_flippingView3DDemo1 updateSize];
	[_flippingView3DDemo2 updateSize];
	[_flippingView2DDemo1 updateSize];
	[_flippingView2DDemo2 updateSize];
}

#pragma Optional delegate methods to indicate beginning and ending of flip animation each time activity begins.

- (void)flipAnimationBegan {
}

- (void)flipAnimationEnded {
}

@end
