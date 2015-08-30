//
//  JK3DFlapViewEnumsCollection.h
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/30/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#ifndef JK3DFlapView_JK3DFlapViewEnumsCollection_h
#define JK3DFlapView_JK3DFlapViewEnumsCollection_h

typedef NS_ENUM (NSUInteger, JKFlapOpening3DMode) {
	JKFlapOpeningMode3DTop,
	JKFlapOpeningMode3DLeft,
	JKFlapOpeningMode3DBottom,
	JKFlapOpeningMode3DRight,
};

typedef NS_ENUM (NSUInteger, JKFlapOpening2DDirection) {
	JKFlapOpening2DDirectionClockwise,
	JKFlapOpening2DDirectionAnticlockwise
};

typedef NS_ENUM (NSUInteger, JKFlapOpeningMode) { JKFlapOpeningMode2D, JKFlapOpeningMode3D };

typedef NS_ENUM (NSUInteger, JKFlapOpening2DPosition) {
	JKFlapOpening2DPositionTopLeft,
	JKFlapOpening2DPositionBottomLeft,
	JKFlapOpening2DPositionBottomRight,
	JKFlapOpening2DPositionTopRight
};

typedef NS_ENUM (NSUInteger, JKBlurredImageEffect) {
	JKBlurredImageEffectNone,
	JKBlurredImageEffectSpotlight,
	JKBlurredImageEffectBlack,
	JKBlurredImageEffectColorful,
	JKBlurredImageEffectBlue
};

#endif
