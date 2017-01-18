//
//  HangManNetworkProtocol.h
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXWordModel.h"
#import "LXResultModel.h"
#import "LXStartGameModel.h"

@protocol HangManNetworkProtocol <NSObject>

/**
    request URL
 
    https://strikingly-hangman.herokuapp.com/game/on
 
 */

/**
 curl -X POST https://strikingly-hangman.herokuapp.com/game/on -H "Content-Type:application/json" --data '{"playerId":"lixin147741@gmail.com", "action":"startGame"}'
 */
- (void)startGameWithSuccessBlock:(void (^)(LXStartGameModel *model))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock;


- (void)giveMeAWordWithSessionId:(NSString *)sessionId
                    successBlock:(void (^)(LXWordModel *model))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock;

- (void)guessWithSessionId:(NSString *)sessionId
                 character:(NSString *)ch
              successBlock:(void (^)(LXWordModel *model))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock;

- (void)getResultWithSessionId:(NSString *)sessionId
                  successBlock:(void (^)(LXResultModel *model))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock;

- (void)submitResultWithSessionId:(NSString *)sessionId
                     successBlock:(void (^)(LXResultModel *model))successBlock
                        failureBlock:(void (^)(NSError *error))failureBlock;




@end
