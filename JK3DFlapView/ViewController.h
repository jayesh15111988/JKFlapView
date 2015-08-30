//
//  ViewController.h
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/29/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FlapOpeningMode) {
    FlapOpeningModeTop,
    FlapOpeningModeLeft,
    FlapOpeningModeBottom,
    FlapOpeningModeright
};


@interface ViewController : UIViewController

@property (nonatomic, assign) FlapOpeningMode flapOpeningMode;

@end

