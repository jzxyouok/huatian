//
//  BlurView.h
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BlurViewDelegate

@end



@interface BlurView : UIVisualEffectView<UITableViewDelegate, UITableViewDataSource>
//分类数组
mArray_(categories)
// 是否是商城的蒙版
BOOL_(isMalls)
@property(nonatomic, weak) id<BlurViewDelegate> delegate;
@end
