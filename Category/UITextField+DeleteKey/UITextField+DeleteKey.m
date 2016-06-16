//
//  UITextField+DeleteKey.m
//  XBJob
//
//  Created by xiao on 15/12/21.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import "UITextField+DeleteKey.h"
#import <objc/runtime.h>

// 这是通知的名称
//NSString * const XBTextFieldDidDeleteBackwardNotification = @"com.whojun.textfield.did.notification";

@implementation UITextField (DeleteKey)

+ (void)load {
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(ex_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)ex_deleteBackward {
    [self ex_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <EXTextFieldDelegate> delegate  = (id<EXTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    // 发送通知，这里使用代理就不发送通知了
//    [[NSNotificationCenter defaultCenter] postNotificationName:XBTextFieldDidDeleteBackwardNotification object:self];
}

@end
