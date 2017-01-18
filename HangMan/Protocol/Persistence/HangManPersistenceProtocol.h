//
//  HangManPersistenceProtocol.h
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HangManPersistenceProtocol <NSObject>

- (void)setSessionId:(NSString *)sessionId;

- (NSString *)getSessionId;

@end
