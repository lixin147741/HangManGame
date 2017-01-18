//
//  LXKeyBoardCollectionViewHandler.h
//  HangMan
//
//  Created by 李鑫 on 17/1/18.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *didGuessWordNotification;

@interface LXKeyBoardCollectionViewHandler : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (void)restart;

@end
