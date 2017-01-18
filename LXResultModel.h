//
//  LXResultModel.h
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXResultModel : NSObject

@property (nonatomic, copy) NSString *palyerId;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSNumber *totalWordCount;
@property (nonatomic, strong) NSNumber *correctWordCount;
@property (nonatomic, strong) NSNumber *totalWrongGuessCount;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, copy) NSString *datetime;

@end
