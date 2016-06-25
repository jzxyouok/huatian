//
//  NewFeatureCell.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "NewFeatureCell.h"

@interface NewFeatureCell()
ImageView_(imageView)
@end

@implementation NewFeatureCell

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    
//    if (self) {
//        
//        
//    }
//    
//    return self;
//}


- (void)setImg:(UIImage *)img
{
    _img = img;
    self.imageView.image =img;
    
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
//        [_imageView setImage:_img];
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _imageView;
}
@end
