//
//  LXKeyModel.h
//  HangMan
//
//  Created by 李鑫 on 17/1/18.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXKeyModel : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign) BOOL isSelected;

+ (LXKeyModel *)modelWithKey:(NSString *)key;

@end
