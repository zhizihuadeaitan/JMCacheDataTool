//
//  JMLogView.h
//  SmartCity-BNew
//
//  Created by TT_Cindy on 2017/3/31.
//  Copyright © 2017年 TTCindy. All rights reserved.
//

#import <UIKit/UIKit.h>
//屏幕适配
#define IS_HOTSPOT_CONNECTED                (APP_STATUSBAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?20:0)
#define HOTSPOT_STATUSBAR_HEIGHT            20
#define SYS_STATUSBAR_HEIGHT                        20
#define APP_STATUSBAR_HEIGHT                (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))

#define WIDTH ([UIScreen mainScreen].bounds.size.width / 375)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height / (667+IS_HOTSPOT_CONNECTED))
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//字体size
#define FONT_TEXTSIZE(size) [UIFont systemFontOfSize:size * HEIGHT]
@interface JMLogView : UIView
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *urlLabel;
@property (nonatomic, strong) UITextView *urlTextView;

@property (nonatomic, strong) UILabel *parametersLabel;
@property (nonatomic, strong) UILabel *responseObjectLabel;
@property (nonatomic, strong) UITextView *parametersTextView;
@property (nonatomic, strong) UITextView *responseObjectTextView;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *copyButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *afterButton;

@end
