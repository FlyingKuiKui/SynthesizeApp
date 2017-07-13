//
//  WSKAppUpdateManager.m
//  SynthesizeApp
//
//  Created by 王盛魁 on 2017/4/28.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "WSKAppUpdateManager.h"

//本app的唯一识别码(这个码我去iTunes找的简书的现在是3.4.1) 跳转appStore需要真机
static const NSString *APPID = @"888237539";
//设置点击取消更新的总共展示次数 超过次数就不在提示更新版本了
static const int maxChannelCount = 3;

@interface WSKAppUpdateManager ()
@property (nonatomic,copy) NSString *locVersion;
@property (nonatomic,copy) NSString *updatePlistPath;

@end

@implementation WSKAppUpdateManager
+ (void)_checkVersionUpadateWithForce:(BOOL)isForce{
    NSString *appStoreUrl = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",APPID];
    WSKAppUpdateManager *manager=[[WSKAppUpdateManager alloc]init];
    manager.locVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    manager.updatePlistPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject] stringByAppendingPathComponent:@"/update.plist"];
    [[AFHTTPSessionManager manager] GET:appStoreUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //判断是否有结果
        if(responseObject[@"resultCount"]>0){
            //取出线上的版本号
            NSString *onlineVersion = [responseObject[@"results"] firstObject][@"version"];
            switch ([manager compareOnlineVersion:onlineVersion LocalVersion:manager.locVersion]) {
                //线上的版本小  不做操作
                case -1:
                    break;
                //版本相同   不做操作
                case 0:
                    //也许是app更新完成后 需要清空之前取消次数
                    [manager clearPlistCancelCount];
                    break;
                //线上的版本大 说明本地要进行更新操作
                case 1:
                  //是否强制更新
                    [manager showAlert:isForce];
                    break;
                default:
                    break;
            };
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败苹果服务器挂了 不做操作
    }];
}
/**
 版本比较方法
 @param onlineVersionOne  线上版本
 @param localVersion 本地项目版本
 @return 比较结果
 */
- (NSComparisonResult)compareOnlineVersion:(NSString *)onlineVersionOne
                                 LocalVersion:(NSString *)localVersion {
    NSArray *versionOneArr = [onlineVersionOne componentsSeparatedByString:@"."];
    NSArray *versionTwoArr = [localVersion componentsSeparatedByString:@"."];
    NSInteger pos = 0;
    while ([versionOneArr count] > pos || [versionTwoArr count] > pos) {
        NSInteger versionOne = [versionOneArr count] > pos ? [[versionOneArr objectAtIndex:pos] integerValue] : 0;
        NSInteger versionTwo = [versionTwoArr count] > pos ? [[versionTwoArr objectAtIndex:pos] integerValue] : 0;
        if (versionOne < versionTwo) {
            //版本2大
            return NSOrderedAscending;
        }
        else if (versionOne > versionTwo) {
            //版本1大
            return NSOrderedDescending;
        }
        pos++;
    }
    //版本相同
    return NSOrderedSame;
}
/**
 更新弹窗
 @param isforce 是否为强制弹窗
 */
-(void)showAlert:(BOOL)isforce{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"有新版本了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //跳转到appStore 须真机测试看效果
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id=%@?mt=8",APPID]] options:@{} completionHandler:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //增加取消次数
            [self addClickCancelCount];
        });
    }];
    
    UIViewController *VC = [self getCurrentVC];
    if (isforce) {
        //添加按钮
        [alertVC addAction:OKAction];
        [VC presentViewController:alertVC animated:YES completion:nil];
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //这个需要文件创建读写费时就异步啦
            NSInteger chanelCount = [self getClickCancelCount];
            dispatch_async(dispatch_get_main_queue(), ^{
                //看是否弹出最大次数 弹出窗体
                if (chanelCount < maxChannelCount) {
                    //添加按钮
                    [alertVC addAction:OKAction];
                    [alertVC addAction:cancelAction];
                    [VC presentViewController:alertVC animated:YES completion:nil];
                }
            });
        });
    }
}
/**
    版本更新把取消更新次数重置方法
 */
-(void)clearPlistCancelCount{
    //先判断plist是否存在 不存在可以先不考虑 等有更新在创建文件就可以
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.updatePlistPath]) {
        //判断plist文件中存的版本
        NSString *plistVersion = [NSDictionary dictionaryWithContentsOfFile:self.updatePlistPath][@"plistVersion"];
        //如果plist文件中版本不同则更新plist文件中版本号并清空取消次数
        if (![plistVersion isEqualToString:self.locVersion]) {
            NSMutableDictionary *updateDic = [NSMutableDictionary dictionaryWithContentsOfFile:self.updatePlistPath];
            [updateDic setValue:@(0) forKey:@"cancelCount"];
            [updateDic setValue:self.locVersion forKey:@"plistVersion"];
            [updateDic writeToFile:self.updatePlistPath atomically:YES];
        }
    }
}
/**
 增加点击取消次数
 */
- (void)addClickCancelCount{
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:_updatePlistPath];
    if (result) {
        NSMutableDictionary *updateDic=[NSMutableDictionary dictionaryWithContentsOfFile:_updatePlistPath];
        NSNumber *cancelNumber = updateDic[@"cancelCount"];
        [updateDic setValue:  @([cancelNumber integerValue]+1) forKey:@"cancelCount"];
        [updateDic writeToFile:_updatePlistPath atomically:YES];
    }
}
/**
 获取点击取消次数
 */
- (NSInteger)getClickCancelCount{
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:_updatePlistPath];
    if (result) {
        NSNumber *cancelNumber=[NSDictionary dictionaryWithContentsOfFile:_updatePlistPath][@"cancelCount"];
        return  [cancelNumber integerValue];
    }else{
        //创建时将本地版本加入plist文件
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@(0),@"cancelCount",self.locVersion,@"plistVersion",nil];
        [dic writeToFile:_updatePlistPath atomically:YES];
        return 0;
    }
    return 0;
}
/**
 获取当前的ViewController
 */
- (UIViewController *)getCurrentVC{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *currentVC = keyWindow.rootViewController;
    while (currentVC.presentedViewController){
        currentVC = currentVC.presentedViewController;
        if ([currentVC isKindOfClass:[UINavigationController class]]){
            currentVC = [(UINavigationController *)currentVC visibleViewController];
        }else if ([currentVC isKindOfClass:[UITabBarController class]]){
            currentVC = [(UITabBarController *)currentVC selectedViewController];
        }
    }
    return currentVC;
}
@end
