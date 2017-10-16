//
//  YCLimitNumTextView.h
//  ArlaGenieLamp
//
//  Created by yuchengguo on 15/1/16.
//  Copyright (c) 2015年 YuChengGuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCLimitNumTextView : UITextView
@property (nonatomic, copy) NSString *placeholder; //占位字符
@property (nonatomic, assign) NSInteger limitNum;  //限制的字数

@end
