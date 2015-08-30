//
//  ViewController.h
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/29/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FlapOpening3DMode) {
    FlapOpeningMode3DTop,
    FlapOpeningMode3DLeft,
    FlapOpeningMode3DBottom,
    FlapOpeningMode3DRight,
    
};

typedef NS_ENUM(NSUInteger, FlapOpening2DDirection) {
    FlapOpening2DDirectionClockwise,
    FlapOpening2DDirectionAnticlockwise
};

typedef NS_ENUM(NSUInteger, FlapOpeningMode) {
    FlapOpeningMode2D,
    FlapOpeningMode3D
};

typedef NS_ENUM(NSUInteger, FlapOpening2DPosition) {
    FlapOpening2DPositionTopLeft,
    FlapOpening2DPositionBottomLeft,
    FlapOpening2DPositionBottomRight,
    FlapOpening2DPositionTopRight
};


@interface ViewController : UIViewController

@property (nonatomic, assign) FlapOpening3DMode flapOpening3DModeValue;
@property (nonatomic, assign) FlapOpening2DDirection flapOpening2DDirectionValue;
@property (nonatomic, assign) FlapOpeningMode flapOpeningModeValue;
@property (nonatomic, assign) FlapOpening2DPosition flapOpening2DPositionValue;

@end

