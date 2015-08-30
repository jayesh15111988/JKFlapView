//
//  JK3DFlippingView.h
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/30/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JK3DFlapViewEnumsCollection.h"

@protocol AnimationCompleteProtocol <NSObject>

@optional
- (void)flipAnimationEnded;
- (void)flipAnimationBegan;

@end

@interface JK3DFlippingView : NSObject

- (instancetype)init3DFlapWithOpeningMode:(JKFlapOpening3DMode)flapOpening3DMode andFlipviewSize:(CGSize)flippingViewSize;
- (instancetype)init2DFlapWithPosition:(JKFlapOpening2DPosition)flapOpeningPosition and2DModeFlapOpeningDirection:(JKFlapOpening2DDirection)flapOpeningDirection andFlipviewSize:(CGSize)flippingViewSize;
- (UIView*)outputFlipView;

@property (nonatomic, assign) JKBlurredImageEffect blurredImageEffectValue;

@property (nonatomic, assign, readonly) BOOL flapOpened;

@property (nonatomic, strong) UIImage* overlayBackgroundImage;
@property (nonatomic, assign) CGFloat flapOpeningAngle;
@property (nonatomic, assign) CGFloat flapOverlayViewAlpha;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, strong) NSString* overlayLabelTextValue;

@property (nonatomic, weak) id<AnimationCompleteProtocol> delegate;

@end
