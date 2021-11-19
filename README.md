# KKImageBrowser

[![Build Status](https://img.shields.io/badge/Github-QMKKXProduct-brightgreen.svg)](https://github.com/HansenCCC/KKImageBrowser)
[![Build Status](https://img.shields.io/badge/platform-ios-orange.svg)](https://github.com/HansenCCC/KKImageBrowser)
[![Build Status](https://img.shields.io/badge/HansenCCC-Github-blue.svg)](https://github.com/HansenCCC)
[![Build Status](https://img.shields.io/badge/HansenCCC-知乎-lightgrey.svg)](https://www.zhihu.com/people/EngCCC)
[![Build Status](https://img.shields.io/badge/已上架AppStore-Apple-success.svg)](https://apps.apple.com/cn/app/ios%E5%AE%9E%E9%AA%8C%E5%AE%A4/id1568656582)

### 这是一个非常实用的图片浏览工具。（仿微信图片预览）
2020年的代码吧，当时是在做自己的项目。然后看到微信预览图片的效果挺酷的，就仿了一个出来。现在整理出来把他传到GitHub，供大家参考和使用。

### 效果


------------

### 依赖
KKImageBrowser依赖SDWebImage。

### 如何使用
1、首先Podfile导入
```
#建议在使用的时候指定版本号
pod 'KKImageBrowser', '~> 0.1.3'
```
2、工程使用
```objective-c
//首先导入头文件 #import <KKImageBrowser/KKImageBrowser.h>

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
```

***

----------

# 我
#### Created by 程恒盛 on 2019/10/24.
#### Copyright © 2019 力王. All rights reserved.
#### QQ:2534550460@qq.com  GitHub:https://github.com/HansenCCC  tel:13767141841
#### copy请标明出处，感谢，谢谢阅读

----------

#### 你还对这些感兴趣吗

1、[iOS实现HTML H5秒开、拦截请求替换资源、优化HTML加载速度][1]

2、[超级签名中最重要的一步：跳过双重认证，自动化脚本添加udid并下载描述文件（证书和bundleid不存在时，会自动创建）][2]

3、[脚本自动化批量修改ipa的icon、启动图、APP名称等(demo只修改icon，其他原理一样)、重签ipa][3]

4、[QMKKXProduct iOS技术分享][4]

5、[KKFileBrowser 快速预览本地文件（可以查看数据库）][5]

6、[KKImageBrowser 图片预览功能（仿微信图片预览） ][5]

  [1]: https://github.com/HansenCCC/KKQuickDraw
  [2]: https://github.com/HansenCCC/HSAddUdids
  [3]: https://github.com/HansenCCC/HSIPAReplaceIcon
  [4]: https://github.com/HansenCCC/QMKKXProduct
  [5]: https://github.com/HansenCCC/KKFileBrowser
  [6]: https://github.com/HansenCCC/KKImageBrowser



## 更新
 
```
2021.11.18  0.1.3版本，完善基本功能
2021.11.18  0.1.2版本，调整代码接口【不建议使用此版本】
2021.11.18  0.1.1版本，上传代码相关【不建议使用此版本】
2021.11.16  0.1.0版本，新的版本从这里开始【不建议使用此版本】

```
