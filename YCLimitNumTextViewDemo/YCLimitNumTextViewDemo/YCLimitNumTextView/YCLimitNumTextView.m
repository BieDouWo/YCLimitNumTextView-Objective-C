//
//  YCLimitNumTextView.m
//  ArlaGenieLamp
//
//  Created by yuchengguo on 15/1/16.
//  Copyright (c) 2015年 YuChengGuo. All rights reserved.
//

#import "YCLimitNumTextView.h"

//占位的颜色
#define PLACEHOLDER_RGB [UIColor colorWithRed:(187)/255.0f green:(186)/255.0f blue:(194)/255.0f alpha:(0.8)]

@interface YCLimitNumTextView ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UILabel *limitNumLabel;

@end

@implementation YCLimitNumTextView

#pragma mark- 初始化
- (id)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initView];
}
- (void)initView
{
    if (_placeholderLabel != nil) {
        return;
    }
    _placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    _placeholderLabel.textColor = PLACEHOLDER_RGB;
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    
    _limitNumLabel = [[UILabel alloc] init];
    _limitNumLabel.textAlignment = NSTextAlignmentRight;
    _limitNumLabel.textColor = PLACEHOLDER_RGB;
    _limitNumLabel.font = [UIFont systemFontOfSize:12];
    _limitNumLabel.backgroundColor = [UIColor clearColor];
    
    self.delegate = self;
    self.font = [UIFont systemFontOfSize:14];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
     _placeholderLabel.font = font;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self setLimitNumberLabel];
}
#pragma mark- 设置位置
- (void)setLimitNumberLabel
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    _placeholderLabel.frame = CGRectMake(5, 5, w, 20.f);
    _limitNumLabel.frame = CGRectMake(x + w - 65.f, y + h - 20.f, 60.f, 20.f);
    
    //必须在这里add
    [self addSubview:_placeholderLabel];
    
    //必须设置到父view
    [self.superview addSubview:_limitNumLabel];
}
#pragma mark- 设置限制输入的最大数
- (void)setLimitNum:(NSInteger)limitNum
{
    _limitNum = limitNum;
    _limitNumLabel.text = [NSString stringWithFormat:@"0/%zd",_limitNum];
}
#pragma mark- 设置占位字符
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _placeholderLabel.text = placeholder;
}
#pragma mark- 设置文字
- (void)setText:(NSString *)text
{
    [super setText:text];
    
    //是否有输入
    if (self.text.length <= 0) {
        _placeholderLabel.hidden = NO;
    }else{
        _placeholderLabel.hidden = YES;
    }
}
#pragma mark- UITextView代理
//即将改变输入框的内容
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //计算输入的字符个数
    NSString *str = [NSString stringWithFormat:@"%@%@",textView.text,text];
    long textNum = 0;
    if (text.length == 0) {
        textNum = textView.text.length - 1;
    }else{
        textNum = str.length;
    }
    
    //是否有输入
    if (textNum <= 0) {
        _placeholderLabel.hidden = NO;
    }else{
        _placeholderLabel.hidden = YES;
    }
    
    //判断输入的字符个数是否超标
    if(textNum > _limitNum){
        //超标取范围内的字符
        NSString *sub = [str substringToIndex:_limitNum];
        self.text = sub;
        _limitNumLabel.text = [NSString stringWithFormat:@"%zd/%zd", _limitNum, _limitNum];
        _limitNumLabel.textColor = [UIColor redColor];
        return NO;   //不允许输入
    }else{
        _limitNumLabel.text = [NSString stringWithFormat:@"%zd/%zd", textNum > 0 ? textNum : 0, _limitNum];
        _limitNumLabel.textColor = PLACEHOLDER_RGB;
        return YES;  //允许输入
    }
}
//即将开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //_placeholderLabel.hidden = YES;
    return YES;
}
//即将结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (self.text.length == 0) {
       _placeholderLabel.hidden = NO;
    }
    //输入结束后在计算数目
    _limitNumLabel.text = [NSString stringWithFormat:@"%zd/%zd", (long)self.text.length, _limitNum];
    _limitNumLabel.textColor = PLACEHOLDER_RGB;
    
    return YES;
}

@end



