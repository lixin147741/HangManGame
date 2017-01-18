//
//  HangManKit.h
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HangManPersistenceProtocol.h"
#import "HangManNetworkProtocol.h"

@interface HangManKit : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isLogin;

- (void)startGameWithSuccessBlock:(void (^)(LXStartGameModel *model))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock;


- (void)giveMeAWordWithSuccessBlock:(void (^)(LXWordModel *model))successBlock
                       failureBlock:(void (^)(NSError *error))failureBlock;

- (void)guessWithCharacter:(NSString *)ch
              successBlock:(void (^)(LXWordModel *model))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;

- (void)getResultWithSuccessBlock:(void (^)(LXResultModel *model))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock;

- (void)submitResultWithSuccessBlock:(void (^)(LXResultModel *model))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock;


@end
