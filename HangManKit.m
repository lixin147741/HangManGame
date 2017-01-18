//
//  HangManKit.m
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import "HangManKit.h"
#import "HangManPersistenceIMP.h"
#import "HangManNetworkIMP.h"
#import "NSError+HangManError.h"

@interface HangManKit ()

@property (nonatomic, strong) id<HangManNetworkProtocol> network;
@property (nonatomic, strong) id<HangManPersistenceProtocol> persistence;


@end

@implementation HangManKit

+ (instancetype)sharedInstance {
    
    static HangManKit *hangManKit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hangManKit = [[self alloc] init];
        hangManKit.network = [[HangManNetworkIMP alloc] init];
        hangManKit.persistence = [[HangManPersistenceIMP alloc] init];
        
    });
    return hangManKit;
}

- (BOOL)isLogin {
    NSString *sessionId = [_persistence getSessionId];
    return sessionId.length > 0;
}

- (void)startGameWithSuccessBlock:(void (^)(LXStartGameModel *model))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock {
    
    [_network startGameWithSuccessBlock:^(LXStartGameModel *model) {
        
        // 存储sessionId
        [_persistence setSessionId:model.sessionId];
        
        if (successBlock) {
            successBlock(model);
        }
        
    } failureBlock:failureBlock];
    
}

- (void)giveMeAWordWithSuccessBlock:(void (^)(LXWordModel *model))successBlock
                       failureBlock:(void (^)(NSError *error))failureBlock {
    
    // 获取Session，获取失败就返回错误
    NSString *sessionId = [_persistence getSessionId];
    if (sessionId.length == 0) {
        if (failureBlock) {
            failureBlock([NSError errorWithSessionError]);
        }
        return;
    }
    
    [_network giveMeAWordWithSessionId:sessionId
                          successBlock:successBlock
                          failureBlock:failureBlock];
    
}

- (void)guessWithCharacter:(NSString *)ch
              successBlock:(void (^)(LXWordModel *model))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock {
    
    // 获取Session，获取失败就返回错误
    NSString *sessionId = [_persistence getSessionId];
    if (sessionId.length == 0) {
        if (failureBlock) {
            failureBlock([NSError errorWithSessionError]);
        }
        return;
    }
    
    [_network guessWithSessionId:sessionId
                       character:ch
                    successBlock:successBlock
                    failureBlock:failureBlock];
    
    
}

- (void)getResultWithSuccessBlock:(void (^)(LXResultModel *model))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock {
    
    // 获取Session，获取失败就返回错误
    NSString *sessionId = [_persistence getSessionId];
    if (sessionId.length == 0) {
        if (failureBlock) {
            failureBlock([NSError errorWithSessionError]);
        }
        return;
    }
    
    [_network getResultWithSessionId:sessionId
                        successBlock:successBlock
                        failureBlock:failureBlock];
    
}

- (void)submitResultWithSuccessBlock:(void (^)(LXResultModel *model))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock {
    
    // 获取Session，获取失败就返回错误
    NSString *sessionId = [_persistence getSessionId];
    if (sessionId.length == 0) {
        if (failureBlock) {
            failureBlock([NSError errorWithSessionError]);
        }
        return;
    }
    
    [_network submitResultWithSessionId:sessionId
                           successBlock:successBlock
                           failureBlock:failureBlock];
    
}

@end
