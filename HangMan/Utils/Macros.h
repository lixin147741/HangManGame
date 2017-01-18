//
//  Macros.h
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF __strong typeof(self) self = weakSelf; if (!self) return

#define LXScreenWidth [UIScreen mainScreen].bounds.size.width
