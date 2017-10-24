//
//  JMLogView.m
//  SmartCity-BNew
//
//  Created by TT_Cindy on 2017/3/31.
//  Copyright © 2017年 李潇. All rights reserved.
//

#import "JMLogView.h"
#import <UIView+SDAutoLayout.h>


@implementation JMLogView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self addSubview:self.cancelBtn];
        _cancelBtn.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self,0)
        .widthIs(60 * WIDTH)
        .heightIs(40 * HEIGHT);
        
        [self addSubview:self.copyButton];
        _copyButton.sd_layout.
        rightSpaceToView(self,100 * WIDTH)
        .topSpaceToView(self,0)
        .widthIs(60 * WIDTH)
        .heightIs(40 * HEIGHT);
        
        [self addSubview:self.sendButton];
        _sendButton.sd_layout.
        rightSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self,0)
        .widthIs(60 * WIDTH)
        .heightIs(40 * HEIGHT);
        
        [self addSubview:self.timeLabel];
        _timeLabel.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self.cancelBtn,1)
        .widthIs(280 * WIDTH)
        .heightIs(15 * HEIGHT);
        
        [self addSubview:self.urlLabel];
        _urlLabel.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self.timeLabel,1)
        .widthIs(60 * WIDTH)
        .heightIs(40 * HEIGHT);
        
        [self addSubview:self.urlTextView];
        _urlTextView.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self.urlLabel,1)
        .widthIs(280 * WIDTH)
        .heightIs(70 * HEIGHT);
        
        
        
        [self addSubview:self.parametersLabel];
        _parametersLabel.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self.urlTextView,1)
        .widthIs(280 * WIDTH)
        .heightIs(40 * HEIGHT);
        
        [self addSubview:self.parametersTextView];
        _parametersTextView.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self.parametersLabel,1)
        .widthIs(280 * WIDTH)
        .heightIs(80 * HEIGHT);
        
        [self addSubview:self.responseObjectLabel];
        _responseObjectLabel.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self.parametersTextView,1)
        .widthIs(280 * WIDTH)
        .heightIs(40 * HEIGHT);
        
        [self addSubview:self.responseObjectTextView];
        _responseObjectTextView.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .topSpaceToView(self.responseObjectLabel,1)
        .widthIs(280 * WIDTH)
        .heightIs(80 * HEIGHT);
        
        [self addSubview:self.afterButton];
        _afterButton.sd_layout.
        leftSpaceToView(self,10 * WIDTH)
        .bottomSpaceToView(self,1)
        .widthIs(100 * WIDTH)
        .heightIs(40 * HEIGHT);
        
        [self addSubview:self.nextButton];
        _nextButton.sd_layout.
        rightSpaceToView(self,10 * WIDTH)
        .bottomSpaceToView(self,1)
        .widthIs(100 * WIDTH)
        .heightIs(40 * HEIGHT);
        
    }
    return self;
}
- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        cancel.frame = CGRectMake(25 * WIDTH, 10 * HEIGHT, (300 - 50 ) * WIDTH, 30 * HEIGHT);
        [cancel setTitle:@"取消" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelBtn = cancel;
    }
    return _cancelBtn;
}
- (UIButton *)sendButton
{
    if (!_sendButton) {
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        cancel.frame = CGRectMake(25 * WIDTH, 10 * HEIGHT, (300 - 50 ) * WIDTH, 30 * HEIGHT);
        [cancel setTitle:@"发送" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _sendButton = cancel;
    }
    return _sendButton;
}
- (UIButton *)copyButton
{
    if (!_copyButton) {
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        cancel.frame = CGRectMake(25 * WIDTH, 10 * HEIGHT, (300 - 50 ) * WIDTH, 30 * HEIGHT);
        [cancel setTitle:@"复制" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _copyButton = cancel;
    }
    return _copyButton;
}

- (UIButton *)nextButton
{
    if (!_nextButton) {
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        cancel.frame = CGRectMake(25 * WIDTH, 10 * HEIGHT, (300 - 50 ) * WIDTH, 30 * HEIGHT);
        [cancel setTitle:@"下一个" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _nextButton = cancel;
    }
    return _nextButton;
}

- (UIButton *)afterButton
{
    if (!_afterButton) {
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        cancel.frame = CGRectMake(25 * WIDTH, 10 * HEIGHT, (300 - 50 ) * WIDTH, 30 * HEIGHT);
        [cancel setTitle:@"上一个" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _afterButton = cancel;
    }
    return _afterButton;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"时间：";
        _timeLabel.font = FONT_TEXTSIZE(14);
        _timeLabel.frame = CGRectMake(25 * WIDTH, 10 * HEIGHT, (300 - 50 ) * WIDTH, 30 * HEIGHT);
    }
    return _timeLabel;
}
- (UILabel *)urlLabel
{
    if (!_urlLabel) {
        _urlLabel = [[UILabel alloc]init];
        _urlLabel.text = @"url：";
        _urlLabel.frame = CGRectMake(25 * WIDTH, 10 * HEIGHT, (300 - 50 ) * WIDTH, 30 * HEIGHT);
        
    }
    return _urlLabel;
}
- (UITextView *)urlTextView
{
    if (!_urlTextView) {
        UITextView *textView = [[UITextView alloc]init];
        textView.frame = CGRectMake(25 * WIDTH, 51 * HEIGHT, (300 - 50 ) * WIDTH, 200 * HEIGHT);
        textView.backgroundColor = [UIColor whiteColor];
        _urlTextView = textView;
    }
    return _urlTextView;
}

- (UILabel *)parametersLabel
{
    if (!_parametersLabel) {
        _parametersLabel = [[UILabel alloc]init];
        _parametersLabel.text = @"上传参数：";
    }
    return _parametersLabel;
}

- (UITextView *)parametersTextView
{
    if (!_parametersTextView) {
        UITextView *textView = [[UITextView alloc]init];
        textView.frame = CGRectMake(25 * WIDTH, 51 * HEIGHT, (300 - 50 ) * WIDTH, 200 * HEIGHT);
        textView.backgroundColor = [UIColor whiteColor];
        _parametersTextView = textView;
    }
    return _parametersTextView;
}

- (UILabel *)responseObjectLabel
{
    if (!_responseObjectLabel) {
        _responseObjectLabel = [[UILabel alloc]init];
        _responseObjectLabel.text = @"接口返回数据：";
    }
    return _responseObjectLabel;
}

- (UITextView *)responseObjectTextView
{
    if (!_responseObjectTextView) {
        UITextView *textView = [[UITextView alloc]init];
        textView.frame = CGRectMake(25 * WIDTH, 51 * HEIGHT, (300 - 50 ) * WIDTH, 200 * HEIGHT);
        textView.backgroundColor = [UIColor whiteColor];
        
        _responseObjectTextView = textView;
    }
    return _responseObjectTextView;
}
@end
