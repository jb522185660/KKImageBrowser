//
//  UIView+KKImageBrowser.m
//  KKImageBrowser_Example
//
//  Created by Hansen on 11/18/21.
//  Copyright © 2021 chenghengsheng. All rights reserved.
//

#import "UIView+KKImageBrowser.h"

@implementation UIView (KKImageBrowser)

- (UIImage *)screenshotsImageWithScale:(CGFloat)scale {
    CGRect bounds = self.bounds;
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, scale);
    //    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)screenshotsImage {
    UIImage *image = [self screenshotsImageWithScale:0.0];
    return image;
}

@end
