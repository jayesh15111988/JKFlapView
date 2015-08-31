//
//  UIImage+AlphaChange.m
//  JK3DFlapView
//
//  Created by Jayesh Kawli Backup on 8/30/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "UIImage+AlphaChange.h"

@implementation UIImage(AlphaChange)

- (UIImage*)imageByApplyingAlpha:(CGFloat)alpha {
	UIGraphicsBeginImageContextWithOptions (self.size, NO, 0.0f);
	CGContextRef ctx = UIGraphicsGetCurrentContext ();
	CGRect area = CGRectMake (0, 0, self.size.width, self.size.height);
	CGContextScaleCTM (ctx, 1, -1);
	CGContextTranslateCTM (ctx, 0, -area.size.height);
	CGContextSetBlendMode (ctx, kCGBlendModeMultiply);
	CGContextSetAlpha (ctx, alpha);
	CGContextDrawImage (ctx, area, self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext ();
	UIGraphicsEndImageContext ();
	return newImage;
}

@end
