//
//  KKImageBrowserContainerCell.m
//  KKImageBrowser_Example
//
//  Created by Hansen on 11/17/21.
//  Copyright © 2021 chenghengsheng. All rights reserved.
//

#import "KKImageBrowserContainerCell.h"
#import <SDWebImage/SDWebImage.h>

@interface KKImageBrowserContainerCell () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapTwoGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapOneGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, assign) CGPoint panBeginPoint;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation KKImageBrowserContainerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (UIWindow *)alertWindow {
    if (_alertWindow == nil) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _alertWindow.rootViewController = [[UIViewController alloc] init];
        _alertWindow.windowLevel = UIWindowLevelAlert;
        _alertWindow.backgroundColor = [UIColor clearColor];
    }
    return _alertWindow;
}

- (void)setupSubviews {
    self.backgroundColor = [UIColor clearColor];
    //
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    self.scrollView.multipleTouchEnabled = YES;
    self.scrollView.maximumZoomScale = 4;
    self.scrollView.minimumZoomScale = 1;
    [self.contentView addSubview:self.scrollView];
    //
    self.browserImageView = [[UIImageView alloc] init];
    self.browserImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.browserImageView];
    //
    [self addGestureRecognizer];
}

- (void)addGestureRecognizer {
    self.tapOneGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOneClick:)];
    [self addGestureRecognizer:self.tapOneGestureRecognizer];
    //
    self.tapTwoGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapTwoClick:)];
    self.tapTwoGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:self.tapTwoGestureRecognizer];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(whenPanClick:)];
    self.panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:self.panGestureRecognizer];
    //
    [self.tapOneGestureRecognizer requireGestureRecognizerToFail:self.tapTwoGestureRecognizer];
    [self.tapOneGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
    [self.tapTwoGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(whenLongPress:)];
    [self addGestureRecognizer:self.longPressGestureRecognizer];
}

//单击手势
- (void)whenTapOneClick:(id)sender {
    //单击
    if (self.whenTapOneActionClick) {
        self.whenTapOneActionClick(self);
    }
}

//双击手势
- (void)whenTapTwoClick:(UITapGestureRecognizer *)sender {
    //双击
    if (self.whenTapTwoActionClick) {
        self.whenTapTwoActionClick(self);
    }
    //双击图片，进行放大处理
    UIScrollView *scrollView = self.scrollView;
    UIView *zoomView = [self viewForZoomingInScrollView:scrollView];
    CGPoint point = [sender locationInView:zoomView];
    //判断图片是否在双击点上
    if (!CGRectContainsPoint(zoomView.bounds, point)){
        return;
    }
    NSInteger normalScale = 1;
    if (scrollView.zoomScale >= scrollView.maximumZoomScale) {
        [scrollView setZoomScale:normalScale animated:YES];
    }else{
        CGFloat zoomScale = scrollView.zoomScale;
        zoomScale = 4;
        if (zoomScale >= scrollView.maximumZoomScale) {
            zoomScale = scrollView.maximumZoomScale;
        }
        CGFloat width = scrollView.frame.size.width/zoomScale;
        CGFloat height = scrollView.frame.size.height/zoomScale;
        CGFloat x = point.x - width/2.0;
        CGFloat y = point.y - height/2.0;
        [scrollView zoomToRect:CGRectMake(x, y, width, height) animated:YES];
    }
}

//拖动手势
- (void)whenPanClick:(UIPanGestureRecognizer *)sender {
    //
    if (self.scrollView.zoomScale != 1) {
        return;
    }
    //如果上级已经在滚动中，则取消当前试图移动手势
    UICollectionView *collectionView = (UICollectionView *)self.superview;
    if ([collectionView isKindOfClass:[UICollectionView class]]) {
        if (collectionView.dragging||collectionView.decelerating) {
            return;
        }
    }
    CGPoint point = [sender locationInView:self];
    CGPoint translation = [sender translationInView:self];
    CGPoint center = self.browserImageView.center;
    CGFloat maxHeight = self.bounds.size.height * 0.3;//阈值
    if (sender.state == UIGestureRecognizerStateBegan) {
        // Star.
        self.panBeginPoint = point;
    } else if (sender.state == UIGestureRecognizerStateCancelled || sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateRecognized || sender.state == UIGestureRecognizerStateFailed) {
        // End.
        //满足隐藏的条件
        if (sender.state == UIGestureRecognizerStateEnded) {
            if (fabs(point.y - self.panBeginPoint.y) > maxHeight) {
                //单击
                if (self.whenNeedHideAction) {
                    self.whenNeedHideAction(self);
                }
                return;
            }
        }
        //没有满足取消隐藏的条件
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.center = center;
            self.weakBackgroundView.alpha = 1;
            self.scrollView.transform = CGAffineTransformIdentity;
            if (self.whenChangeBackgroundAlpha) {
                self.whenChangeBackgroundAlpha(1);
            }
        }];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        // Change.
        center.x += (point.x - self.panBeginPoint.x);
        center.y += (point.y - self.panBeginPoint.y);
        self.scrollView.center = center;
        CGFloat value = 1 - fabs(translation.y)/self.frame.size.height;
        self.weakBackgroundView.alpha = value;
        self.scrollView.transform = CGAffineTransformMakeScale(value, value);
        if (self.whenChangeBackgroundAlpha) {
            self.whenChangeBackgroundAlpha(value);
        }
    }
}

- (void)whenLongPress:(UILongPressGestureRecognizer *)sender {
    NSLog(@"长按");
    if (sender.state == UIGestureRecognizerStateBegan) {
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet
        ];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消保存图片");
            weakSelf.alertWindow.hidden = YES;
        }];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确认保存图片");
            weakSelf.alertWindow.hidden = YES;
            UIImageWriteToSavedPhotosAlbum(self.browserImageView.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
        }];
        [alertControl addAction:cancel];
        [alertControl addAction:confirm];
        
        [self.alertWindow makeKeyAndVisible];
        [self.alertWindow.rootViewController presentViewController:alertControl animated:YES completion:nil];
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError: (NSError*)error contextInfo:(id)contextInfo{
    if (error == nil) {
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:@"保存成功" preferredStyle: UIAlertControllerStyleAlert
        ];
        __weak typeof(self) weakSelf = self;
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确认保存图片");
            weakSelf.alertWindow.hidden = YES;
        }];
        [alertControl addAction:confirm];
        
        [self.alertWindow makeKeyAndVisible];
        [self.alertWindow.rootViewController presentViewController:alertControl animated:YES completion:nil];
    }
}

- (void)setCellModel:(KKImageBrowserModel *)cellModel {
    _cellModel = cellModel;
    self.scrollView.zoomScale = 1.0f;
    if (cellModel.image) {
        [self.browserImageView setImage:cellModel.image];
    }else{
        UIImage *placeholderImage = self.placeholderImage;
        [self.browserImageView sd_setImageWithURL:cellModel.url placeholderImage:placeholderImage];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    self.browserImageView.frame = f1;
    //
    CGRect f2 = bounds;
    self.scrollView.frame = f2;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.browserImageView;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self];
        if (fabs(translation.x) > fabs(translation.y) ) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}

@end
