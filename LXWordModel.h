//
//  LXWordModel.h
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXWordModel : NSObject

@property (nonatomic, copy) NSString *word;
@property (nonatomic, strong) NSNumber *totalWordCount;
@property (nonatomic, strong) NSNumber *wrongGuessCountOfCurrentWord;

@end
