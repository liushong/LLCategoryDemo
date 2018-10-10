//
//  NSString+LLStringConnection.m
//  sdktest
//
//  Created by JIMU on 15/5/11.
//  Copyright (c) 2015年 jimu. All rights reserved.
//

#import "NSString+LLStringConnection.h"

@implementation NSString (LLStringConnection)

- (id)objectForKeyedSubscript:(id <NSCopying>)key
{
    if (key == nil || [(NSString *)key isKindOfClass:[NSNull class]] || [(NSString *)key isEqual:@"<null>"] || [(NSString *)key isEqual:@"null"]) return self;
    return [self stringByAppendingFormat:@"%@",key];
}

@end
