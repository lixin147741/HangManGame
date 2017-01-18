//
//  NSError+HangManError.h
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *hangManErrorDomain;

typedef NS_ENUM(NSInteger, HangManErrorCode) {
    HangManErrorCodeJsonPraseError = -1,
    HangManErrorCodeSessionError = -2
};

@interface NSError (HangManError)

+ (NSError *)errorWithParseJsonFail;

+ (NSError *)errorWithSessionError;

@end
