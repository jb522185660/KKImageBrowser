//
//  KKImageBrowserModel.m
//  KKImageBrowser_Example
//
//  Created by Hansen on 11/17/21.
//  Copyright © 2021 chenghengsheng. All rights reserved.
//

#import "KKImageBrowserModel.h"

@implementation KKImageBrowserModel

- (instancetype)initWithURL:(NSURL *)url toView:(UIView *)toView {
    if (self = [self init]) {
        self.url = url;
        self.toView = toView;
    }
    return self;
}

@end
