//
//  LXKeyModel.m
//  HangMan
//
//  Created by 李鑫 on 17/1/18.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import "LXKeyModel.h"

@implementation LXKeyModel

+ (LXKeyModel *)modelWithKey:(NSString *)key {
    LXKeyModel *model = [[LXKeyModel alloc] init];
    model.key = key;
    model.isSelected = NO;
    
    return model;
}

@end
