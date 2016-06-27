#import <UIKit/UIKit.h>
//
NSString * const GET_Categories = @"http://m.htxq.net/servlet/SysCategoryServlet?action=getList";

NSString * const POST_HomeList = @"http://m.htxq.net/servlet/SysArticleServlet?action=mainList";

NSString * const POST_TOP10List = @"http://ec.htxq.net/servlet/SysArticleServlet?currentPageIndex=0&pageSize=10";

NSString * const POST_ArticleDetail = @"http://m.htxq.net/servlet/SysArticleServlet?action=getArticleDetail";
