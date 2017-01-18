//
//  LXStartGameModel.h
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXStartGameModel : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, strong) NSNumber *numberOfWordsToGuess;
@property (nonatomic, strong) NSNumber *numberOfGuessAllowedForEachWord;

@end
