//
//  BlurView.m
//  高仿花田小溪
//
//  Created by 祥云创想 on 16/6/24.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "BlurView.h"
#import "MallsCategoryHeader.h"

static NSString *CategoryCellReuseIdentifier = @"CategoryCellReuseIdentifier";
@interface BlurView()
TableView_(tableView)
 // 里面放置的都是MallsCategoryHeader, 保存了是否显示, 是否关闭
@property(nonatomic, strong) NSMutableArray<MallsCategoryHeader *> *selectedArray;
/// 底部的Logo
ImageView_(bottomView)
/// 底部的分割线
ImageView_(underLine)
@end


@implementation BlurView

- (instancetype)initWithEffect:(UIVisualEffect *)effect
{
    if (self == [super initWithEffect:effect]) {
        [self setupUI];
    }
    return self;
}

//设置UI
- (void)setupUI
{
    [self addSubview:self.tableView];
    [self addSubview:self.bottomView];
    [self addSubview:self.underLine];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(@40);
        make.bottom.equalTo(self.underLine.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
        make.height.equalTo(@27);
    }];
    
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-10);
    }];
    
}

- (NSMutableArray<MallsCategoryHeader *> *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}


- (void)setCategories:(NSMutableArray *)categories
{
    _categories = categories;
    [self.tableView reloadData];
}

- (void)setIsMalls:(BOOL)isMalls
{
    _isMalls = isMalls;
    if (isMalls) {
        self.tableView.rowHeight = 40;
    }
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    //商城
    if (self.isMalls) {
        return self.categories.count;
    }
    //非商城
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.isMalls) {
        // 如果是商城, 返回子序列的个数
        
        if (self.selectedArray.count > 0) {
            for (int i = 0; i<self.selectedArray.count; i++) {
                if (i == section) {
                    MallsCategoryHeader *header = self.selectedArray[section];
                    if (header.isShow) {
                        //返回模型中的数据
#warning 模型为确定
                        return 10;
                    }
                }
            }
        }
    }
    //非商城
    return self.categories.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellReuseIdentifier forIndexPath:indexPath];
     cell.backgroundColor = [UIColor clearColor];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.textLabel.textAlignment = NSTextAlignmentCenter;
     cell.textLabel.font = [UIFont fontWithName:@"CODE LIGHT" size:14];
     if (self.categories.count) {
         if (self.isMalls) {
             cell.textLabel.text = @"商城的蒙版";
         }else
         {
             cell.textLabel.text = @"非商城商城的蒙版";
         }
     }

     
     return cell;
 }


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isMalls) {
        return 80;
    }
    return 0;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (<#condition#>) {
//        <#statements#>
//    }
//}




- (UIImageView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"l_regist"]];
    }
    return _bottomView;
}

- (UIImageView *)underLine
{
    if (!_underLine) {
        _underLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"underLine"]];
    }
    return _underLine;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CategoryCellReuseIdentifier];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 60;
    }
    return _tableView;
}
@end
