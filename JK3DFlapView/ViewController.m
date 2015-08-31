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

static NSString* const RotationAnimationKey = @"viewRotationAnimation";

@interface ViewController () <AnimationCompleteDelegate>

@property (nonatomic, strong) CALayer* flippingLayer;
@property (nonatomic, assign) BOOL flapOpened;
@property (nonatomic, strong) NSString* animatingPropertyKeyPath;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	JKFlippingView* flippingView = [[JKFlippingView alloc] init3DFlapWithOpeningMode:JKFlapOpeningMode3DBottom
									 andFlipviewSize:CGSizeMake (200, 200)];
	flippingView.overlayLabelTextValue = @"asdasdasd\nasdasd\nasdasd";
	flippingView.blurredImageEffectValue = JKBlurredImageEffectColorful;
	flippingView.delegate = self;
	UIView* flipView = [flippingView outputFlipView];
	flipView.backgroundColor = [UIColor redColor];
	[self.view addSubview:flipView];
}

- (void)flipAnimationBegan {
}

- (void)flipAnimationEnded {
}

@end
