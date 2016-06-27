//
//  NetworkTool.h
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXHttpTool.h"
#import "Categorys.h"

@interface NetworkTool : NSObject
-(void)getHomeListDataWithCurrentPage:(int)currentPage selectedCategry:(Categorys *)selectedCategorys block:(void(^)(id json))block failure:(void(^)(NSError *error))failure;

-(void)getCategoriesData:(void(^)(id json))block failure:(void(^)(NSError *error))failure;

-(void)getTop10DataWithActionType:(NSString *)actionType block:(void(^)(id json))block failure:(void(^)(NSError *error))failure;

-(void)getArticleDetailDataWithDetailID:(NSString *)ID block:(void(^)(id json))block failure:(void(^)(NSError *error))failure;

@end
