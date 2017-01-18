//
//  HangManPersistenceIMP.m
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import "HangManPersistenceIMP.h"

static NSString *sessionIdKey = @"sessionId";

@implementation HangManPersistenceIMP

- (void)setSessionId:(NSString *)sessionId {

    [[NSUserDefaults standardUserDefaults] setObject:sessionId forKey:sessionIdKey];
}

- (NSString *)getSessionId {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:sessionIdKey];
}

@end
