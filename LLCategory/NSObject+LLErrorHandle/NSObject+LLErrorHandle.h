//
//  NSObject+LLErrorHandle.h
//  LLErrorHandle
//
//  Created by liushong on 2018/10/10.
//  Copyright © 2018年 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//数组越界
@interface NSArray (LLErrorHandle)
@end

//数组越界
@interface NSMutableArray (LLErrorHandle)
@end

//文字为空
@interface UILabel (LLErrorHandle)
@end



@interface NSObject (LLSwizzleMethod)
/**
 *  对系统方法进行替换(交换实例方法)
 *
 *  @param systemSelector 被替换的方法
 *  @param swizzledSelector 实际使用的方法
 *  @param error            替换过程中出现的错误消息
 *
 *  @return 是否替换成功
 */
+ (BOOL)SystemSelector:(SEL)systemSelector swizzledSelector:(SEL)swizzledSelector error:(NSError *)error;
@end
