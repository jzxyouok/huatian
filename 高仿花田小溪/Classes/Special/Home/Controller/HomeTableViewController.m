//
//  HomeTableViewController.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "HomeTableViewController.h"
#import "BlurView.h"
#import "Categorys.h"
#import "Author.h"
#import "Article.h"
#import "TitleBtn.h"
#import "HomeArticleCell.h"
#import "NetworkTool.h"
#import "TopViewController.h"
#import "DetailViewController.h"

#import "MJRefresh.h"

@interface HomeTableViewController ()<BlurViewDelegate>
@property(nonatomic, strong) BlurView *blurView;
// 所有的主题分ZX类  
@property(nonatomic, strong) NSMutableArray<Categorys *> *categories;
// 文章数组
@property(nonatomic, strong) NSMutableArray<Article *> *articles;
// 当前页
int_(currentPage)
// 选中的分类
DIYObj_(Categorys, selectedCategry)
DIYObj_(TitleBtn, titleBtn)
DIYObj_(NetworkTool, tools)
//是否加载更多
BOOL_(isToLoadMore)
//左侧按钮
Button_(menuBtn)

@end

static NSString *HomeArticleReuseIdentifier = @"HomeArticleReuseIdentifier";
@implementation HomeTableViewController

//懒加载

- (NetworkTool *)tools
{
    if (!_tools) {
        _tools = [[NetworkTool alloc] init];
    }
    return _tools;
}

- (NSMutableArray *)categories
{
    if (!_categories) {
        _categories = [NSMutableArray array];
    }
    return _categories;
}

- (NSMutableArray *)articles
{
    if (!_articles) {
        _articles = [NSMutableArray array];
    }
    return _articles;
}
- (TitleBtn *)titleBtn
{
    if (!_titleBtn) {
        _titleBtn = [[TitleBtn alloc] init];
    }
    return _titleBtn;
}
- (BlurView *)blurView
{
    if (!_blurView) {
        _blurView = [[BlurView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        _blurView.categories = self.categories;
        _blurView.delegate = self;
    }
    return _blurView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    //
    [self setRefresh];
    
    [self getCategories];
}
//基本配置
- (void)setup
{
    self.currentPage = 0;
    self.isToLoadMore = NO;

    //左按钮
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    menuBtn.lx_size = CGSizeMake(20, 20);
    [menuBtn addTarget:self action:@selector(selectedCategory:) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn = menuBtn;
    //右按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"TOP" style:UIBarButtonItemStylePlain target:self action:@selector(toTop)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    //
    self.navigationItem.titleView = self.titleBtn;
    
    
    //tableView配置
    //注册
    [self.tableView registerClass:[HomeArticleCell class] forCellReuseIdentifier:HomeArticleReuseIdentifier];
    self.tableView.rowHeight = 330;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
//    self.
    
}

//设置刷新控件
- (void)setRefresh
{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    self.tableView.mj_footer.hidden = YES;
}

//请求第一次数据列表
- (void)getNewData
{
     self.currentPage = 0;
    [self.articles removeAllObjects];
    
    [self.tools getHomeListDataWithCurrentPage:self.currentPage selectedCategry:self.selectedCategry block:^(id json) {
        
        [self.tableView.mj_header endRefreshing];
        
        if ([json isKindOfClass:[NSString class]]) {
            if ([json isEqualToString:@"已经到最后"] )//显示蒙版
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"已经到最后了";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:2];
                self.currentPage -= 1;
                return ;
            }
        }
        if ([json isKindOfClass:[NSArray class]]) {
            [self.articles addObjectsFromArray:json];
            self.isToLoadMore = NO;
            [self.tableView reloadData];
        }
        

    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        self.isToLoadMore = NO;
        // 获取数据失败后
        self.currentPage -= 1;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网路异常";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:2];
        LXLog(@"%@",error);
    }];
}

//请求更多
- (void)getMoreData
{
    [self.tools getHomeListDataWithCurrentPage:self.currentPage selectedCategry:self.selectedCategry block:^(id json) {
        
        [self.tableView.mj_header endRefreshing];
        
        if ([json isKindOfClass:[NSString class]]) {
            if ([json isEqualToString:@"已经到最后"] )//显示蒙版
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"已经到最后了";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hideAnimated:YES afterDelay:2];
                self.currentPage -= 1;
                return ;
            }
        }
        if ([json isKindOfClass:[NSArray class]]) {
            [self.articles addObjectsFromArray:json];
            //            self.articles = json;
            self.isToLoadMore = NO;
            [self.tableView reloadData];
        }
        
        //        LXLog(@"%@",json);
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        self.isToLoadMore = NO;
        // 获取数据失败后
        self.currentPage -= 1;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网路异常";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:2];
        LXLog(@"%@",error);
    }];
}
//请求Categories
- (void)getCategories
{
    [self.tools getCategoriesData:^(id json) {
        
        if ([json isKindOfClass:[NSArray class]]) {
            [self.categories addObjectsFromArray:json];
        }

    } failure:^(NSError *error) {
        
    }];
}


- (void)toTop
{
    TopViewController *topVC = [[TopViewController alloc] init];
    [self.navigationController pushViewController:topVC animated:YES];
}

//弹出蒙版及动画
- (void)selectedCategory:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {

        [self.tableView addSubview:self.blurView];
        //设置blurView的约束
        [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tableView);

            make.top.equalTo(self.navigationController.navigationBar.mas_top).offset(44);

            make.size.mas_equalTo(CGSizeMake(MY_WIHTE, MY_HEIGHT-49-64));
        }];
        // 设置transform
        self.blurView.transform = CGAffineTransformMakeTranslation(0, -MY_HEIGHT);
        
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
      if (btn.selected) {
            //旋转
            btn.transform = CGAffineTransformMakeRotation((CGFloat)M_PI_2);
            //复原
            self.blurView.transform = CGAffineTransformIdentity;

            self.tableView.scrollEnabled = NO;
      }else
      {
          //复原
          btn.transform = CGAffineTransformIdentity;
          self.blurView.transform = CGAffineTransformMakeTranslation(0, -MY_HEIGHT);
          self.tableView.scrollEnabled = YES;
      }
        
    } completion:^(BOOL finished) {
        if (!btn.selected) {
            [self.blurView removeFromSuperview];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeArticleReuseIdentifier forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.articles.count) {
        Article *article = self.articles[indexPath.row];
//        LXLog(@"name -- %@",article.desc);
        cell.article = article;
        
        //添加点击头像按钮的点击事件
    }
    
    if (self.articles.count && indexPath.row == self.articles.count - 1 && !self.isToLoadMore) {
        self.isToLoadMore = YES;

        self.currentPage += 1;
        LXLog(@"%zd",self.currentPage);
        [self getMoreData];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = self.articles[indexPath.row];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.article = article;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - BlurViewDelegate
- (void)blurView:(BlurView *)blurView didSelectCategory:(id)Category
{
    //去掉高斯效果（点击按钮事件）
    [self selectedCategory:self.menuBtn];
    self.selectedCategry = Category;
    [self getNewData];
}

@end
