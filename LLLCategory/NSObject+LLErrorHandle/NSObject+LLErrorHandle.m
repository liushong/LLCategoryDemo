//
//  NSObject+LLErrorHandle.m
//  LLErrorHandle
//
//  Created by liushong on 2018/10/10.
//  Copyright © 2018年 JZ. All rights reserved.
//

#import "NSObject+LLErrorHandle.h"
#import <objc/runtime.h>

@implementation NSArray (LLErrorHandle)
+(void)load{
    [super load];
    //无论怎样 都要保证方法只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //交换NSArray中的objectAtIndex方法
        [objc_getClass("__NSArrayI") SystemSelector:@selector(objectAtIndex:) swizzledSelector:@selector(ll_objectAtIndex:) error:nil];
        [objc_getClass("__NSSingleObjectArrayI") SystemSelector:@selector(objectAtIndex:) swizzledSelector:@selector(ll_objectAtIndex2:) error:nil];
        //交换NSArray中的objectAtIndexedSubscript方法
        [objc_getClass("__NSArrayI") SystemSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(ll_objectAtIndexedSubscript:) error:nil];
        [objc_getClass("__NSSingleObjectArrayI") SystemSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(ll_objectAtIndexedSubscript2:) error:nil];
    });
}
- (id)ll_objectAtIndexedSubscript:(NSUInteger)idx{
    if (idx < self.count) {
        return [self ll_objectAtIndexedSubscript:idx];
    }else{
//        NSLog(@" 你的 NSArray数组已经越界了 但是已经帮你处理好了  %ld   %ld", idx, self.count);
        return nil;
    }
}
- (id)ll_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self ll_objectAtIndex:index];
    }else{
//        NSLog(@" 你的 NSArray数组已经越界了 但是已经帮你处理好了  %ld   %ld", index, self.count);
        return nil;
    }
}
- (id)ll_objectAtIndexedSubscript2:(NSUInteger)idx{
    if (idx < self.count) {
        return [self ll_objectAtIndexedSubscript2:idx];
    }else{
        //        NSLog(@" 你的 NSArray数组已经越界了 但是已经帮你处理好了  %ld   %ld", idx, self.count);
        return nil;
    }
}
- (id)ll_objectAtIndex2:(NSUInteger)index{
    if (index < self.count) {
        return [self ll_objectAtIndex2:index];
    }else{
        //        NSLog(@" 你的 NSArray数组已经越界了 但是已经帮你处理好了  %ld   %ld", index, self.count);
        return nil;
    }
}
@end

@implementation NSMutableArray (LLErrorHandle)
+(void)load{
    [super load];
    //无论怎样 都要保证方法只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //交换NSMutableArray中的方法
        [objc_getClass("__NSArrayM") SystemSelector:@selector(objectAtIndex:) swizzledSelector:@selector(jz_objectAtIndex:) error:nil];
        [objc_getClass("__NSSingleObjectArrayM") SystemSelector:@selector(objectAtIndex:) swizzledSelector:@selector(ll_objectAtIndex2:) error:nil];
        //交换NSMutableArray中的方法
        [objc_getClass("__NSArrayM") SystemSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(jz_objectAtIndexedSubscript:) error:nil];
        [objc_getClass("__NSSingleObjectArrayM") SystemSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(jz_objectAtIndexedSubscript2:) error:nil];
    });
}
- (id)jz_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self jz_objectAtIndex:index];
    }else{
//        NSLog(@" 你的NSMutableArray数组已经越界 帮你处理好了%ld   %ld   %@", index, self.count, [self class]);
        return nil;
    }
}
- (id)jz_objectAtIndexedSubscript:(NSUInteger)index{
    if (index < self.count) {
        return [self jz_objectAtIndexedSubscript:index];
    }else{
//        NSLog(@" 你的NSMutableArray数组已经越界 帮你处理好了%ld   %ld   %@", index, self.count, [self class]);
        return nil;
    }
}
- (id)jz_objectAtIndex2:(NSUInteger)index{
    if (index < self.count) {
        return [self jz_objectAtIndex2:index];
    }else{
        //        NSLog(@" 你的NSMutableArray数组已经越界 帮你处理好了%ld   %ld   %@", index, self.count, [self class]);
        return nil;
    }
}
- (id)jz_objectAtIndexedSubscript2:(NSUInteger)index{
    if (index < self.count) {
        return [self jz_objectAtIndexedSubscript2:index];
    }else{
        //        NSLog(@" 你的NSMutableArray数组已经越界 帮你处理好了%ld   %ld   %@", index, self.count, [self class]);
        return nil;
    }
}
@end

@implementation UILabel (LLErrorHandle)
+(void)load{
    [super load];
    //无论怎样 都要保证方法只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //交换setText方法
        [objc_getClass("UILabel") SystemSelector:@selector(setText:) swizzledSelector:@selector(ll_setText:) error:nil];
    });
}
-(void)ll_setText:(NSString *)text {
    if ([text isKindOfClass:[NSString class]] && text.length) {
        return [self ll_setText:text];
    } else {
//        NSLog(@" 你的 UILabel.text值为空 但是已经帮你处理好了");
        return [self ll_setText:@" "];
    }
}
@end

@implementation NSObject (LLSwizzleMethod)
/**
 *  对系统方法进行替换
 *
 *  @param systemSelector 被替换的方法
 *  @param swizzledSelector 实际使用的方法
 *  @param error            替换过程中出现的错误消息
 *
 *  @return 是否替换成功
 */
+ (BOOL)SystemSelector:(SEL)systemSelector swizzledSelector:(SEL)swizzledSelector error:(NSError *)error{
    Method systemMethod = class_getInstanceMethod(self, systemSelector);
    if (!systemMethod) {
        return [[self class] unrecognizedSelector:systemSelector error:error];
    }
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!swizzledMethod) {
        return [[self class] unrecognizedSelector:swizzledSelector error:error];
    }
    if (class_addMethod([self class], systemSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod([self class], swizzledSelector, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, swizzledMethod);
    }
    return YES;
}
+ (BOOL)unrecognizedSelector:(SEL)selector error:(NSError *)error{
    NSString *errorString = [NSString stringWithFormat:@"%@类没有找到%@", NSStringFromClass([self class]), NSStringFromSelector(selector)];
    error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey:errorString}];
    return NO;
}
@end
