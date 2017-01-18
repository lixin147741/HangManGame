//
//  NSError+HangManError.m
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import "NSError+HangManError.h"

NSString *hangManErrorDomain = @"hangManErrorDomain";

@implementation NSError (HangManError)

+ (NSError *)errorWithParseJsonFail {
    
    NSError *error = [NSError errorWithDomain:hangManErrorDomain code:HangManErrorCodeJsonPraseError userInfo:@{NSLocalizedDescriptionKey:@"解析错误"}];
    
    return error;
}

+ (NSError *)errorWithSessionError {
    
    NSError *error = [NSError errorWithDomain:hangManErrorDomain code:HangManErrorCodeSessionError userInfo:@{NSLocalizedDescriptionKey:@"Session失效，请重新开始游戏"}];
    
    return error;
}

@end
