//
//  KKImageBrowser.m
//  KKImageBrowser_Example
//
//  Created by Hansen on 11/18/21.
//  Copyright © 2021 chenghengsheng. All rights reserved.
//

#import "KKImageBrowser.h"
#import "KKImageBrowserContainerView.h"
#import "UIView+KKImageBrowser.h"

@interface KKImageBrowser ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) KKImageBrowserContainerView *containerView;

@end

@implementation KKImageBrowser

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgImageView];
    UIImage *bgImage = [UIApplication sharedApplication].keyWindow.screenshotsImage;
    self.bgImageView.image = bgImage;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showImageBrowser];
    });
}

- (void)needUpdateIndex:(NSInteger )index{
    self.title = [NSString stringWithFormat:@"%ld / %ld",index + 1,self.images.count];
}

- (void)showImageBrowser {
    KKImageBrowserContainerView *containerView = [[KKImageBrowserContainerView alloc] init];
    containerView.images = self.images;
    containerView.index = self.index;
    __weak typeof(self) weakSelf = self;
    containerView.whenDidHideImageBrowser = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    containerView.whenChangeBackgroundAlpha = ^(CGFloat alpha) {
        //TODO
    };
    containerView.whenNeedUpdateIndex = ^(NSInteger index) {
        [weakSelf needUpdateIndex:index];
    };
    [containerView showToView:self.view];
    self.containerView = containerView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.bgImageView.frame = bounds;
}

- (void)toPopBack {
    [self.containerView removeShow];
}

#pragma mark - setters

- (void)setIndex:(NSInteger)index {
    _index = index;
    [self needUpdateIndex:index];
}

#pragma mark - getters

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}

@end
