//
//  ImageBrowserViewController.h
//  高仿花田小溪
//
//  Created by Lee on 16/6/28.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBrowserViewController : UICollectionViewController
@property(nonatomic, strong) NSArray *imageUrls;
//点击的当前图片的索引
@property(nonatomic, weak)NSIndexPath *indexPath;
@end
