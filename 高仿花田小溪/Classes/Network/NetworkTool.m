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
    [LXHttpTool post:@"http://m.htxq.net/servlet/SysArticleServlet?action=mainList" parameters:parameters success:^(id json) {
        
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
@end
