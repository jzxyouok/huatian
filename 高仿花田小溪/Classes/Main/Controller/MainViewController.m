//
//  MainViewController.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "MainViewController.h"
#import "HomeTableViewController.h"
#import "MallsTableViewController.h"
@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)setup
{
    self.tabBar.tintColor = [UIColor blackColor];
    [self addViewController:[[HomeTableViewController alloc] init] title:NSLocalizedString(@"tab_theme", @"")];
    [self addViewController:[[MallsTableViewController alloc] init] title:NSLocalizedString(@"tab_malls", @"")];
}


- (void)addViewController:(UIViewController *)childController title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tb_%zd",self.childViewControllers.count ]];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tb_%zd_selected",self.childViewControllers.count ]];
    childController.tabBarItem.tag = self.childViewControllers.count ;
    [self addChildViewController:nav];
}

@end
