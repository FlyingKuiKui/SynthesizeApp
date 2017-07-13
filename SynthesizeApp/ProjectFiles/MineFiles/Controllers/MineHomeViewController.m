//
//  MineHomeViewController.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/3/18.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "MineHomeViewController.h"
#import "MineHomeTableViewCell.h"

@interface MineHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy) NSArray *dataArray;

@end

@implementation MineHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _kScreenWidth, _kScreenHeight) style:UITableViewStylePlain];
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerNib: [UINib nibWithNibName:@"MineHomeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineHomeTableViewCell"];
    [self.view addSubview:tabView];
    self.dataArray = @[@[@{@"imgName":@"",@"title":@""}],
                       @[@{@"imgName":@"",@"title":@"我的二维码"},
                         @{@"imgName":@"",@"title":@""}]];
    
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    debugLog(@"section == %lu", (unsigned long)[self.dataArray count]);
    return [self.dataArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    debugLog(@"%lu", (unsigned long)[self.dataArray[section] count]);
    return [self.dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHomeTableViewCell"];
    cell._dataDic = self.dataArray[indexPath.section][indexPath.row];
    return cell;
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
