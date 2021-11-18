//
//  KKViewController.m
//  KKImageBrowser
//
//  Created by chenghengsheng on 11/16/2021.
//  Copyright (c) 2021 chenghengsheng. All rights reserved.
//

#import "KKViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <KKImageBrowser/KKImageBrowser.h>

@interface __KKImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation __KKImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.imageView.frame = f1;
}

@end



@interface KKViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray <NSString *>*datum;

@end

@implementation KKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"KKImageBrowserDemo";
    [self setupSubviews];
    [self reloadLoadDatum];
}

- (void)setupSubviews {
    [self.view addSubview:self.collectionView];
}

- (void)reloadLoadDatum {
    self.datum = [[NSMutableArray alloc] init];
    NSArray *images = @[
        @"https://img1.baidu.com/it/u=3122136587,3938996930&fm=26&fmt=auto",
        @"https://img2.baidu.com/it/u=3356250985,1065949047&fm=26&fmt=auto",
        @"https://img1.baidu.com/it/u=3499283288,1860376714&fm=26&fmt=auto",
        @"https://img1.baidu.com/it/u=251049146,3905767606&fm=26&fmt=auto",
        @"https://img1.baidu.com/it/u=1677307154,4128866455&fm=26&fmt=auto",
        @"https://img0.baidu.com/it/u=3031084643,1334557890&fm=26&fmt=auto",
        @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fdb458e205aa6f42501bf89c83579f17aabf826c3b1f04-k0aNbf_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1639758641&t=86c8b55aa141e511cdaebae41da8e8ef",
    ];
    [self.datum addObjectsFromArray:images];
    [self.datum addObjectsFromArray:images];
    [self.datum addObjectsFromArray:images];
    [self.datum addObjectsFromArray:images];
    [self.datum addObjectsFromArray:images];
    [self.datum addObjectsFromArray:images];
    [self.datum addObjectsFromArray:images];
    //
    [self.collectionView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.collectionView.frame = f1;
    int row = 4;//一排展示几个
    CGFloat space = 8.f;//间隙
    CGFloat width = (bounds.size.width - (row - 1) * space) / row;
    CGFloat height = width;
    self.flowLayout.itemSize = CGSizeMake(width, height);
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    __KKImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"__KKImageCollectionViewCell" forIndexPath:indexPath];
    NSString *imageString = [self.datum objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageString]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datum.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //展示图片
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.datum.count; i ++) {
        NSString *imageString = self.datum[i];
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:index];
        KKImageBrowserModel *model = [[KKImageBrowserModel alloc] initWithURL:[NSURL URLWithString:imageString] toView:cell];
        [images addObject:model];
    }
    KKImageBrowser *vc = [[KKImageBrowser alloc] init];
    vc.images = images;
    vc.index = indexPath.row;
    [self presentViewController:vc animated:NO completion:nil];
}

#pragma mark - getters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[__KKImageCollectionViewCell class] forCellWithReuseIdentifier:@"__KKImageCollectionViewCell"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0.f;
        _flowLayout.minimumInteritemSpacing = 0.f;
    }
    return _flowLayout;
}

@end
