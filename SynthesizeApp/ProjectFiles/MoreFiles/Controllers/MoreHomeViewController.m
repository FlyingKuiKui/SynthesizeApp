//
//  MoreHomeViewController.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "MoreHomeViewController.h"

@interface MoreHomeViewController ()<UISearchBarDelegate>

@end

@implementation MoreHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, _kScreenWidth, 40)];
//    searchBar.barStyle = UIBarStyleBlackOpaque;
//    searchBar.barTintColor = [UIColor redColor];
//    searchBar.tintColor = [UIColor blueColor];
//    searchBar.prompt = @"11111";
//    searchBar.text = @"22";
//    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.placeholder = @"请输入搜索的内容";
    searchBar.delegate = self;
    
    [self.view addSubview:searchBar];
}

#pragma mark - UISearchBarDelegate
// return NO to not become first responder
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索输入框将要开始编辑");
    return YES;
}
// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索输入框开始编辑");
}
// return NO to not resign first responder
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索输入框将要结束编辑");
    return YES;
}
// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索输入框结束编辑");
}
// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"搜索输入框内的内容 %@",searchText);
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"键盘新输入的内容 %@",text);
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    NSLog(@"点击键盘搜索按钮");
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"点击 BookmarkButton，需要设置属性showsBookmarkButton");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"点击 CancelButton，需要设置属性showsCancelButton");
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"点击 SearchResultsButton，需要设置属性showsSearchResultsButton");
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    NSLog(@"-------");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
