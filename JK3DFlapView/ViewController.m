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

@property (nonatomic, strong) CALayer* flippingLayer;
@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString* animatingPropertyKeyPath;
@property (nonatomic, strong) JKFlippingView* flippingView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_flippingView =
	    [[JKFlippingView alloc] init3DFlapWithOpeningMode:JKFlapOpeningMode3DBottom
					      andFlipviewSize:CGSizeMake (150, 150)
				     andOverlayLabelTextValue:@"This is my \n3D overlay view\n that's it\n Meg Ryan"];
	//_flippingView.translatesAutoresizingMaskIntoConstraints = NO;
	_flippingView.blurredImageEffectValue = JKBlurredImageEffectColorful;
	_flippingView.delegate = self;
	_flippingView.backgroundColor = [UIColor greenColor];
	[self.view addSubview:_flippingView];
	//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_flippingView]-50-|"
	//    options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_flippingView)]];
	//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_flippingView]-100-|"
	//    options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(_flippingView)]];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	NSLog (@"Flipping View size Before %@", NSStringFromCGRect (_flippingView.frame));
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	NSLog (@"Flipping View size After %@", NSStringFromCGRect (_flippingView.frame));
}

- (void)flipAnimationBegan {
}

- (void)flipAnimationEnded {
}

@end
