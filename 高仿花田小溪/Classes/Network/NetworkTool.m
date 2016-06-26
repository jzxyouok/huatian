//
//  NetworkTool.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/25.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "NetworkTool.h"
#import "MJExtension.h"
#import "Article.h"
#import "Categorys.h"
#import "Author.h"

@implementation NetworkTool

-(void)getHomeListDataWithCurrentPage:(int)currentPage selectedCategry:(Categorys *)selectedCategorys block:(void(^)(id json))block failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"currentPageIndex"] = [NSString stringWithFormat:@"%zd",currentPage];
    parameters[@"pageSize"] = @"5";
    //如果选择了分类就设置分类的请求ID
    if (selectedCategorys.ID) {
        parameters[@"cateId"] = selectedCategorys.ID;
    }
    [LXHttpTool post:POST_HomeList parameters:parameters success:^(id json) {
        
        if (json[@"status"]) {//获取数据成功   已经获取文章列表
            if ([json[@"msg"] isEqualToString:@"已经到最后"]) {
                block(@"已经到最后");
            }
            
            if (![json[@"result"] isKindOfClass:[NSNull class]]){
                //字典数组转模型数组
                NSArray *arr = json[@"result"];
                NSMutableArray *modelArr = [Article mj_objectArrayWithKeyValuesArray:arr];
                block(modelArr);
                
            }
        }

    } failure:^(NSError *error) {
        LXLog(@"%@",error);
        failure(error);
    }];
}

-(void)getCategoriesData:(void(^)(id json))block failure:(void(^)(NSError *error))failure
{
    [LXHttpTool get:GET_Categories parameters:nil success:^(id json) {
        LXLog(@"%@",json);
        if (json[@"status"]) {//获取数据成功   已经获取分类列表
            if ([json[@"msg"] isEqualToString:@"获取成功"]) {
                if (![json[@"result"] isKindOfClass:[NSNull class]]){
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [Categorys mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr);
                    //保存数据
                    [LXFileManager saveObject:modelArr byFileName:CategoriesKey];
                    
                }else
                {
                    [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];;
                }
            }
        }
    } failure:^(NSError *error) {
        LXLog(@"%@",error);
        failure(error);
        [[Tostal sharTostal] tostalMesg:@"请求数据失败" tostalTime:1];;
    }];
}

-(void)getTop10DataWithActionType:(NSString *)actionType block:(void(^)(id json))block failure:(void(^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"action"] = actionType;
    [LXHttpTool post:POST_TOP10List parameters:parameters success:^(id json) {
        
        if (json[@"status"]) {//获取数据成功   已经获取文章列表
            if ([json[@"msg"] isEqualToString:@"已经到最后"]) {
                block(@"已经到最后");
            }
            
            if (![json[@"result"] isKindOfClass:[NSNull class]]){
                
                //作者
                if ([actionType isEqualToString:@"topArticleAuthor"]) {
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [Author mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr);
                    
                }else if ([actionType isEqualToString:@"topContents"])//专栏
                {
                    //字典数组转模型数组
                    NSArray *arr = json[@"result"];
                    NSMutableArray *modelArr = [Article mj_objectArrayWithKeyValuesArray:arr];
                    block(modelArr);

                }
                
            }
        }
        
    } failure:^(NSError *error) {
        LXLog(@"%@",error);
        failure(error);
    }];
}

@end
