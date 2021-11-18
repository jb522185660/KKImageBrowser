//
//  KKImageBrowserContainerCell.h
//  KKImageBrowser_Example
//
//  Created by Hansen on 11/17/21.
//  Copyright © 2021 chenghengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKImageBrowserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKImageBrowserContainerCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *placeholderImage;//占位图
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *browserImageView;
@property (nonatomic, strong) KKImageBrowserModel *cellModel;
@property (nonatomic, weak) UIView *weakBackgroundView;

//用户单击0，用户双击1，用户下滑上滑退出2
@property (nonatomic, copy) void(^whenTapOneActionClick)(KKImageBrowserContainerCell *cell);
@property (nonatomic, copy) void(^whenTapTwoActionClick)(KKImageBrowserContainerCell *cell);
@property (nonatomic, copy) void(^whenNeedHideAction)(KKImageBrowserContainerCell *cell);
@property (nonatomic, copy) void(^whenChangeBackgroundAlpha)(CGFloat alpha);

@end

NS_ASSUME_NONNULL_END
