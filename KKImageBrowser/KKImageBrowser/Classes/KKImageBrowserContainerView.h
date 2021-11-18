//
//  KKImageBrowserContainerView.h
//  KKImageBrowser_Example
//
//  Created by Hansen on 11/17/21.
//  Copyright © 2021 chenghengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKImageBrowserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKImageBrowserContainerView : UIView

@property (nonatomic, strong) UIImage *placeholderImage;//占位图
@property (nonatomic, strong) NSArray <KKImageBrowserModel *> *images;
@property (nonatomic, assign) NSInteger index;//当前下标，下标不能大于image.count
@property (nonatomic, copy) void (^whenDidShowImageBrowser)(void);
@property (nonatomic, copy) void (^whenDidHideImageBrowser)(void);
@property (nonatomic, copy) void (^whenNeedUpdateIndex)(NSInteger index);
@property (nonatomic, copy) void (^whenChangeBackgroundAlpha)(CGFloat alpha);


- (void)showToView:(UIView *)toView;

- (void)removeShow;

@end

NS_ASSUME_NONNULL_END
