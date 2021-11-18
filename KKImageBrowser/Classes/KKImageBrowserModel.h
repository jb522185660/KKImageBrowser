//
//  KKImageBrowserModel.h
//  KKImageBrowser_Example
//
//  Created by Hansen on 11/17/21.
//  Copyright © 2021 chenghengsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKImageBrowserModel : NSObject

@property (nonatomic, weak) UIView *toView;//一般填imageView，可不填
@property (nonatomic, strong) NSURL *url;//网络的图片资源或者本地的图片资源
@property (nonatomic, strong) UIImage *image;//image优先级高于url

- (instancetype)initWithURL:(NSURL *)url toView:(UIView *)toView;

@end

NS_ASSUME_NONNULL_END
