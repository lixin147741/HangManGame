//
//  HangManNetworkIMP.m
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//
#import "HangManNetworkIMP.h"
#import "AFNetworking.h"
#import "NSObject+YYModel.h"
#import "NSError+HangManError.h"
#import "LXEnvironment.h"

// Action
static const NSString *startGameAction = @"startGame";
static const NSString *nextWordAction = @"nextWord";
static const NSString *guessWordAction = @"guessWord";
static const NSString *getResultAction = @"getResult";
static const NSString *submitResultAction = @"submitResult";

@interface HangManNetworkIMP ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HangManNetworkIMP

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        [_manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    }
    return self;
}

- (void)startGameWithSuccessBlock:(void (^)(LXStartGameModel *model))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock {
    
    NSDictionary *dic = @{@"playerId":[LXEnvironment playerId], @"action": startGameAction};
    [self.manager POST:[LXEnvironment baseURL] parameters:dic
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                                     LXStartGameModel *model = [LXStartGameModel modelWithJSON:responseObject];
                                     
                                     if ([responseObject isKindOfClass:[NSDictionary class]]) {
                                         NSDictionary *json = responseObject;
                                         
                                         NSDictionary *data = [json objectForKey:@"data"];
                                         model.numberOfWordsToGuess = [data objectForKey:@"numberOfWordsToGuess"];
                                         model.numberOfGuessAllowedForEachWord = [data objectForKey:@"numberOfGuessAllowedForEachWord"];
                                         
                                         if (successBlock) {
                                             successBlock(model);
                                         }
                                     }
                                     else {
                                         NSError *error = [NSError errorWithParseJsonFail];
                                         if (failureBlock) {
                                             failureBlock(error);
                                         }
                                     }
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     if (failureBlock) {
                                         failureBlock(error);
                                     }
                                 }];
}


- (void)giveMeAWordWithSessionId:(NSString *)sessionId
                    successBlock:(void (^)(LXWordModel *model))successBlock
                    failureBlock:(void (^)(NSError *error))failureBlock {
    
    NSDictionary *dic = @{@"sessionId":sessionId, @"action": nextWordAction};
    [self.manager POST:[LXEnvironment baseURL] parameters:dic
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   if ([responseObject isKindOfClass:[NSDictionary class]]) {
                       NSDictionary *json = responseObject;
                       
                       NSDictionary *data = [json objectForKey:@"data"];
                       
                       LXWordModel *model = [LXWordModel modelWithJSON:data];
                       
                       if (successBlock) {
                           successBlock(model);
                       }
                   }
                   else {
                       NSError *error = [NSError errorWithParseJsonFail];
                       if (failureBlock) {
                           failureBlock(error);
                       }
                   }
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   if (failureBlock) {
                       failureBlock(error);
                   }
               }];
    
}

- (void)guessWithSessionId:(NSString *)sessionId
                 character:(NSString *)ch
              successBlock:(void (^)(LXWordModel *model))successBlock
              failureBlock:(void (^)(NSError *error))failureBlock {
    
    NSDictionary *dic = @{@"sessionId":sessionId, @"action": guessWordAction, @"guess":ch};
    [self.manager POST:[LXEnvironment baseURL] parameters:dic
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   if ([responseObject isKindOfClass:[NSDictionary class]]) {
                       NSDictionary *json = responseObject;
                       
                       NSDictionary *data = [json objectForKey:@"data"];
                       
                       LXWordModel *model = [LXWordModel modelWithJSON:data];
                       
                       if (successBlock) {
                           successBlock(model);
                       }
                   }
                   else {
                       NSError *error = [NSError errorWithParseJsonFail];
                       if (failureBlock) {
                           failureBlock(error);
                       }
                   }
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   if (failureBlock) {
                       failureBlock(error);
                   }
               }];
    
}

- (void)getResultWithSessionId:(NSString *)sessionId
                  successBlock:(void (^)(LXResultModel *model))successBlock
                  failureBlock:(void (^)(NSError *error))failureBlock {
    
    NSDictionary *dic = @{@"sessionId":sessionId, @"action": getResultAction};
    [self.manager POST:[LXEnvironment baseURL] parameters:dic
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   if ([responseObject isKindOfClass:[NSDictionary class]]) {
                       NSDictionary *json = responseObject;
                       
                       NSDictionary *data = [json objectForKey:@"data"];
                       
                       LXResultModel *model = [LXResultModel modelWithJSON:data];
                       model.sessionId = [json objectForKey:@"sessionId"];
                       
                       if (successBlock) {
                           successBlock(model);
                       }
                   }
                   else {
                       NSError *error = [NSError errorWithParseJsonFail];
                       if (failureBlock) {
                           failureBlock(error);
                       }
                   }
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   if (failureBlock) {
                       failureBlock(error);
                   }
               }];
    
}

- (void)submitResultWithSessionId:(NSString *)sessionId
                     successBlock:(void (^)(LXResultModel *model))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock {
    
    NSDictionary *dic = @{@"sessionId":sessionId, @"action": submitResultAction};
    [self.manager POST:[LXEnvironment baseURL] parameters:dic
              progress:nil
               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   if ([responseObject isKindOfClass:[NSDictionary class]]) {
                       NSDictionary *json = responseObject;
                       
                       NSDictionary *data = [json objectForKey:@"data"];
                       
                       LXResultModel *model = [LXResultModel modelWithJSON:data];
                       model.message = [json objectForKey:@"message"];
                       
                       if (successBlock) {
                           successBlock(model);
                       }
                   }
                   else {
                       NSError *error = [NSError errorWithParseJsonFail];
                       if (failureBlock) {
                           failureBlock(error);
                       }
                   }
               }
               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   if (failureBlock) {
                       failureBlock(error);
                   }
               }];
}
@end
