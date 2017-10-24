//
//  AppDelegate.h
//  TTCacheDataToolDemo
//
//  Created by TT_Cindy on 2017/10/24.
//  Copyright © 2017年 TT_Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMLogView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIButton *button;
@property (nonatomic, strong) JMLogView *logView;
@property (nonatomic, strong) NSArray *logArr;

- (void)creatMoveRedPacketUI;
@property (strong, nonatomic) UIWindow *window;


@end

