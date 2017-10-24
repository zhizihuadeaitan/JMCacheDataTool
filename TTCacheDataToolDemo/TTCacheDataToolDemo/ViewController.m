//
//  ViewController.m
//  TTCacheDataToolDemo
//
//  Created by TT_Cindy on 2017/10/24.
//  Copyright © 2017年 TT_Cindy. All rights reserved.
//

#import "ViewController.h"
#import <AFHTTPSessionManager.h>
#import "JMCacheDataTool.h"
@interface ViewController ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *bodyDic = @{@"name":@"",
                              @"password":@""
                              };
    NSString *url = @"";
    [_sessionManager POST:url parameters:bodyDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [JMCacheDataTool saveLogDataUrl:url body:bodyDic reValue:responseObject];
        DLog(@"\n===接口：\n%@\n===返回值：\n%@\n===上传参数：\n%@",url,[responseObject yy_modelToJSONString],bodyDic) ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [JMCacheDataTool saveLogDataUrl:url body:bodyDic reValue:error];
        DLog(@"\n===接口：\n%@\n===返回Error：\n%@\n===上传参数：\n%@",url,error,bodyDic) ;

    }];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
