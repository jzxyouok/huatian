//
//  Article.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "Article.h"
#import "MJExtension.h"
@implementation Article
MJCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
