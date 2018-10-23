//
//  NSString+LLStringConnection.h
//  sdktest
//
//  Created by JIMU on 15/5/11.
//  Copyright (c) 2015年 jimu. All rights reserved.
//
NS_ASSUME_NONNULL_BEGIN
#import <Foundation/Foundation.h>

@interface NSString (LLStringConnection)

- (id)objectForKeyedSubscript:(id <NSCopying>)key;

@end
NS_ASSUME_NONNULL_END
