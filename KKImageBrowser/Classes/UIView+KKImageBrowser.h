//
//  UIView+KKImageBrowser.h
//  KKImageBrowser_Example
//
//  Created by Hansen on 11/18/21.
//  Copyright © 2021 chenghengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KKImageBrowser)

- (UIImage *)screenshotsImageWithScale:(CGFloat)scale;

- (UIImage *)screenshotsImage;

@end

NS_ASSUME_NONNULL_END
