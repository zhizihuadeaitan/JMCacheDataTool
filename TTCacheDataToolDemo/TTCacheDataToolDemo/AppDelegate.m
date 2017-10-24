//
//  AppDelegate.m
//  TTCacheDataToolDemo
//
//  Created by TT_Cindy on 2017/10/24.
//  Copyright © 2017年 TT_Cindy. All rights reserved.
//

#import "AppDelegate.h"
#import "JMCacheDataTool.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
{
    UIButton *_moveRedPacket;
    NSInteger _currentCount;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[ViewController alloc]init];
#if DEBUG
    [self creatMoveRedPacketUI];
    
#else
    
#endif
    _currentCount  = 0;
    // Override point for customization after application launch.
    return YES;
}
//创建移动UI
- (void)creatMoveRedPacketUI{
    if (!_moveRedPacket) {
        UIButton *moveRedPacket = [UIButton buttonWithType:UIButtonTypeCustom];
        UIPanGestureRecognizer   *  panTouch    =   [[UIPanGestureRecognizer  alloc]initWithTarget:self action:@selector(handlePan:)];
        [moveRedPacket addGestureRecognizer:panTouch];
        
        [moveRedPacket setTitle:@"日志" forState:UIControlStateNormal];
        moveRedPacket.frame = CGRectMake(SCREEN_WIDTH - 60 * HEIGHT, 64, 60 * HEIGHT, 60 * HEIGHT);
        moveRedPacket.layer.cornerRadius = 60 * HEIGHT / 2;
        [moveRedPacket addTarget:self action:@selector(resignWindow) forControlEvents:UIControlEventTouchUpInside];
        moveRedPacket.backgroundColor = [UIColor redColor];
        _moveRedPacket = moveRedPacket;
    }
    
    [self.window  addSubview:_moveRedPacket];
    
}
/**
 *  处理拖动手势
 *
 *  @param recognizer 拖动手势识别器对象实例
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    //视图前置操作
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.window];
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    recognizer.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.window];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        //计算速度向量的长度，当他小于200时，滑行会很短
        CGPoint velocity = [recognizer velocityInView:self.window];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866
        
        //基于速度和速度因素计算一个终点
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor),
                                         center.y + (velocity.y * slideFactor));
        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
        finalPoint.x = MIN(MAX(finalPoint.x, cornerRadius),
                           self.window.bounds.size.width - cornerRadius);
        finalPoint.y = MIN(MAX(finalPoint.y, cornerRadius),
                           self.window.bounds.size.height - cornerRadius);
        
        //使用 UIView 动画使 view 滑行到终点
        [UIView animateWithDuration:slideFactor*2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             recognizer.view.center = finalPoint;
                         }
                         completion:nil];
    }
}
- (JMLogView *)logView
{
    if (!_logView) {
        _logView = [[JMLogView alloc]init];
        UIPanGestureRecognizer   *  panTouch    =   [[UIPanGestureRecognizer  alloc]initWithTarget:self action:@selector(handlePan:)];
        [_logView addGestureRecognizer:panTouch];
        _logView.backgroundColor = [UIColor grayColor];
        _logView.frame = CGRectMake(0, 64, 300 * WIDTH, 500 * HEIGHT);
    }
    return _logView;
}
/**
 *  关闭悬浮的window
 */
- (void)resignWindow
{
    [self.window addSubview:self.logView];
    
    [self log];
    
    
    [_logView.cancelBtn addTarget:self action:@selector(resignLogView:) forControlEvents:UIControlEventTouchUpInside];
    [_logView.sendButton addTarget:self action:@selector(sendLog:) forControlEvents:UIControlEventTouchUpInside];
    [_logView.copyButton addTarget:self action:@selector(copyMessage:) forControlEvents:UIControlEventTouchUpInside];
    [_logView.nextButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [_logView.afterButton addTarget:self action:@selector(after:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)log{
    JMLogPM *logPM;
    if (self.logArr.count >0) {
        logPM = self.logArr[_currentCount];
        
    }
    _logView.timeLabel.text = [NSString stringWithFormat:@"时间：%@",logPM.time];
    _logView.urlTextView.text = [NSString stringWithFormat:@"%@",logPM.url];
    _logView.responseObjectTextView.text = [NSString stringWithFormat:@"%@",logPM.return_value];
    _logView.parametersTextView.text = [NSString stringWithFormat:@"%@",logPM.body];
}
- (void)next:(UIButton *)sender
{
    if (_currentCount>0) {
        _currentCount --;
        [self log];
        
    }
}
- (void)after:(UIButton *)sender
{
    DLog(@"=====%lu",(unsigned long)self.logArr.count);
    if (self.logArr.count - 1 <= _currentCount) {
        return;
    }
    _currentCount ++;
    [self log];
    
}
- (void)resignLogView:(UIButton *)sender
{
    _currentCount = 0;
    [sender.superview removeFromSuperview];
    
}
- (void)sendLog:(UIButton *)sender
{
    JMLogPM *logPM;
    if (self.logArr.count >0) {
        logPM = self.logArr[_currentCount];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:logPM.time forKey:@"time"];
        [dic setObject:logPM.url forKey:@"url"];
        [dic setObject:logPM.body forKey:@"body"];
        [dic setObject:logPM.return_value forKey:@"return_value"];
        
        NSString *logStr = [NSString stringWithFormat:@"时间：%@\n url：%@\n 上传参数：%@\n 返回数据：%@",logPM.time,logPM.url,logPM.body,logPM.return_value];
        
        //[JMCacheDataTool sendLogToQYWechat:logStr];//发送到企业微信
    }
    
    
}




- (void)copyMessage:(UIButton *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    JMLogPM *logPM;
    if (self.logArr.count >0) {
        logPM = self.logArr[_currentCount];
    }
    
    NSString *logStr = [NSString stringWithFormat:@"时间：%@\n url：%@\n parameters：%@\n responseObject：%@",logPM.time,logPM.url,logPM.body,logPM.return_value];
    pasteboard.string = logStr;
}
- (NSArray *)logArr{
    
    if (!_logArr) {
        _logArr = [[NSArray alloc]init];
        
    }
    NSArray *arr = [JMCacheDataTool readLogData];
    
    if (arr.count >0) {
        _logArr = [JMCacheDataTool readLogDataEveryDayDateStr:arr[0]];
        
    }
    return _logArr;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
