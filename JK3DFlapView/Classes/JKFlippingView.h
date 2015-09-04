//
//  JK3DFlippingView.h
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/30/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AHEasing/CAKeyframeAnimation+AHEasing.h>
#import "JK3DFlapViewEnumsCollection.h"

@protocol AnimationCompleteDelegate <NSObject>

@optional
- (void)flipAnimationEnded;
- (void)flipAnimationBegan;

@end

@interface JKFlippingView : UIView

- (instancetype)init3DFlapWithOpeningMode:(JKFlapOpening3DMode)flapOpening3DMode
                          andFlipviewSize:(CGSize)flippingViewSize andOverlayLabelTextValue:(NSString*)overlayLabelTextValue;
- (instancetype)init2DFlapWithPosition:(JKFlapOpening2DPosition)flapOpeningPosition
	 and2DModeFlapOpeningDirection:(JKFlapOpening2DDirection)flapOpeningDirection
		       andFlipviewSize:(CGSize)flippingViewSize andOverlayLabelTextValue:(NSString*)overlayLabelTextValue;


@property (nonatomic, assign, readonly) BOOL flapOpened;

@property (nonatomic, assign) JKBlurredImageEffect blurredImageEffectValue;
@property (nonatomic, strong) UIImage* overlayBackgroundImage;
@property (nonatomic, assign) CGFloat flapOpeningAngle;
@property (nonatomic, assign) CGFloat flapOverlayViewAlpha;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) AHEasingFunction flipAnimationEasingFunction;

@property (nonatomic, weak) id<AnimationCompleteDelegate> delegate;

@end
