//
//  AppDelegate.m
//  Calculator
//
//  Created by Apri on 3/13/16.
//  Copyright © 2016 Apri. All rights reserved.
//

#import "AppDelegate.h"
#import "LRViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //创建视图控制器对象
    LRViewController * rootVC = [[LRViewController alloc] init];
    
    //让根视图等于视图控制器
    self.window.rootViewController = rootVC;
    //显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

@end
