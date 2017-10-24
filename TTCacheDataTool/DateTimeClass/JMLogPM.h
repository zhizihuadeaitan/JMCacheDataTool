//
//  JMLogPM.h
//  SmartCity-BNew
//
//  Created by TT_Cindy on 2017/3/30.
//  Copyright © 2017年 李潇. All rights reserved.
//

#import "JMPropertyModel.h"

@interface JMLogPM : JMPropertyModel

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *body;
@property (nonatomic, strong) NSString *return_value;
@property (nonatomic, strong) NSString *time;

@end
