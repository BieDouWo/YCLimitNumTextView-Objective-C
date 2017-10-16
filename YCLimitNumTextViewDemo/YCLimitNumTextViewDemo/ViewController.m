//
//  ViewController.m
//  YCLimitNumTextViewDemo
//
//  Created by 别逗我 on 2017/10/16.
//  Copyright © 2017年 YuChengGuo. All rights reserved.
//

#import "ViewController.h"
#import "YCLimitNumTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    YCLimitNumTextView *textView = [[YCLimitNumTextView alloc] init];
    textView.frame = CGRectMake(20, 64, [UIScreen mainScreen].bounds.size.width - 40, 200);
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius = 6;
    textView.layer.borderWidth = 1.0;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:textView];
    
    textView.limitNum = 10;
    textView.placeholder = @"请输入简介";
}

@end
