//
//  UILabel+LLCopyLabel.m
//  LLLCategoryDemo
//
//  Created by liushong on 2018/10/16.
//  Copyright © 2018年 liushong. All rights reserved.
//

#import "UILabel+LLCopyLabel.h"
#import <objc/runtime.h>

static NSString *llCanCopyKey = @"llCanCopyKey";

@implementation UILabel (LLCopyLabel)

- (void)setCanCopy:(BOOL)canCopy {
    if (self.canCopy == canCopy) {
        return;
    }
    [self pressAction:canCopy];
    objc_setAssociatedObject(self, &llCanCopyKey, @(canCopy), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canCopy {
    NSNumber *numberValue = objc_getAssociatedObject(self, &llCanCopyKey);
    return [numberValue intValue];
}

// 初始化设置
- (void)pressAction:(BOOL)canCopy {
    self.userInteractionEnabled = canCopy;
    static UILongPressGestureRecognizer *longPress = nil;
    if (canCopy) {
        longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 0.25;
        [self addGestureRecognizer:longPress];
    } else {
        [self removeGestureRecognizer:longPress];
    }
    
}

// 使label能够成为响应事件
- (BOOL)canBecomeFirstResponder {
    return YES;
}

// 自定义方法时才显示对就选项菜单，即屏蔽系统选项菜单
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(customCopy:)){
        return YES;
    }
    return NO;
}

- (void)customCopy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
}
- (void)longPressAction:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:self.copyString action:@selector(customCopy:)];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        menuController.menuItems = [NSArray arrayWithObjects:copyItem, nil];
        [menuController setTargetRect:self.frame inView:self.superview];
        [menuController setMenuVisible:YES animated:YES];
    }
}

-(NSString *)copyString {
    NSString *resultString = @"Copy";
    NSString *language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            resultString = @"拷贝";//zh-Hans
        } else if ([language rangeOfString:@"TW"].location != NSNotFound) {
            resultString = @"拷貝";//zh-TW
        } else {
            resultString = @"複製";//zh-HK/zh-Hant-MO
        }
    }
    return resultString;
}

@end
