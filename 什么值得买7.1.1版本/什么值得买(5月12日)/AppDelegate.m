//
//  AppDelegate.m
//  什么值得买(5月12日)
//
//  Created by Wang_ruzhou on 16/5/12.
//  Copyright © 2016年 Wang_ruzhou. All rights reserved.
//

#import "AppDelegate.h"
#import "HMTabBarViewController.h"
#import "HMUserAccount.h"
#import<libkern/OSAtomic.h>
#import <RongIMKit/RongIMKit.h>
#import "HMGlobalApperance.h"
#import "ZZNetworkHandler.h"




@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ZZNetworkHandler startMonitoring];
    
    // 向微博客户端程序注册第三方应用
    [WeiboSDK registerApp:kAppKey];
    //初始化融云
    [self configureRongYun];
    //全局定制
    [HMGlobalApperance configureGlobalApperance];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    HMTabBarViewController *tab = [[HMTabBarViewController alloc] init];
    
    self.window.rootViewController = tab;
    
    [self.window makeKeyAndVisible];

    
    return YES;
}


/** 初始化融云 */
- (void)configureRongYun{
    
    [[RCIM sharedRCIM] initWithAppKey:@"pvxdm17jxjazr"];
    
    [[RCIM sharedRCIM] connectWithToken:@"tzKb9I9fsboKoVsC2rn/yy8nIw4YEFm9bQo6U/nEZBnKYvSfMlN988HcEIWtnyo3JLfnwco2cWYfLmrYxTxSPvHCblTYo0wq" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%@", @(status));
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    
    return [WeiboSDK handleOpenURL:url delegate:self];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WeiboSDK handleOpenURL:url delegate:self];
}


#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
        
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        
        NSDictionary *dict = authorizeResponse.mj_keyValues;
        
        HMUserAccount *userAccount = [HMUserAccount mj_objectWithKeyValues:dict];
        
        [NSKeyedArchiver archiveRootObject:userAccount toFile:kAccountPath];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HMUserAccountDidHandleUserDataNotification object:nil];
    }
    
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}



@end
