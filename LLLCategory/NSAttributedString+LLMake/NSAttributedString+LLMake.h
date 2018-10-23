//
//  NSAttributedString+LLMake.h
//  AXAttributedStringDemo
//
//  Created by liushong on 2018/10/9.
//  Copyright © 2018年 liushong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>

@class LLAttributedStringMaker;
@interface NSAttributedString (LLMake)
+ (NSAttributedString *)makeAttributedString:(void(NS_NOESCAPE ^)(LLAttributedStringMaker *make))block;
@end

@class LLAttributedStringChain;
@interface LLAttributedStringMaker : NSObject
- (LLAttributedStringChain *(^)(NSString *text))text;
- (NSAttributedString *)install;
@end

@interface LLAttributedStringChain : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableAttributedString *> *attributedStrings;
- (LLAttributedStringChain *(^)(UIColor *color))foregroundColor;
- (LLAttributedStringChain *(^)(UIColor *color))backgroundColor;
- (LLAttributedStringChain *(^)(UIFont *font))font;
- (LLAttributedStringChain *(^)(NSUnderlineStyle style))underline;
- (LLAttributedStringChain *(^)(UIColor *color))underlineColor;
- (LLAttributedStringChain *(^)(CGFloat offset))baseline;
- (LLAttributedStringChain *(^)(NSUnderlineStyle style))strike;
- (LLAttributedStringChain *(^)(UIColor *color))strikeColor;
- (LLAttributedStringChain *(^)(NSParagraphStyle *style))paragraphStyle;
- (LLAttributedStringChain *(^)(NSString *link))link;
- (void)buildSubAttributedString;
@end
