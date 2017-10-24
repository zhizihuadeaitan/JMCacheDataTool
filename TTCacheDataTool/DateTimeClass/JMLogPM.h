//
//  JMLogPM.h
//  SmartCity-BNew
//
//  Created by TT_Cindy on 2017/3/30.
//  Copyright © 2017年 TTCindy. All rights reserved.
//

#import <YYModel/YYModel.h>

@interface JMLogPM : NSObject
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *body;
@property (nonatomic, strong) NSString *return_value;
@property (nonatomic, strong) NSString *time;

@end
