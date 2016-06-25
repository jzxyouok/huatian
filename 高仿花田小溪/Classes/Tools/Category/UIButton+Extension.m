//
//  UIButton+Extension.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
+ (UIButton *)title:(NSString *)title imageName:(NSString *)imageName target:(id)target selector:(nullable SEL)selector font:(UIFont *)font titleColor:(UIColor *)titleColor
{
    UIButton *btn = [[self alloc] init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.titleLabel.font =font ;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
