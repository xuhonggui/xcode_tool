//
//  UITextField+DeleteKey.h
//  XBJob
//
//  Created by xiao on 15/12/21.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EXTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;

@end


@interface UITextField (DeleteKey)


@property (weak, nonatomic) id<EXTextFieldDelegate> delegate;
/**
 *  监听删除按钮
 *  object:UITextField
 */
// 这是通知的名称
//extern NSString * const WJTextFieldDidDeleteBackwardNotification;



@end
