//
//  LXKeyBoardCollectionViewHandler.m
//  HangMan
//
//  Created by 李鑫 on 17/1/18.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import "LXKeyBoardCollectionViewHandler.h"
#import "LXKeyModel.h"
#import "Macros.h"
#import "HangManKit.h"
#import "SVProgressHUD.h"

NSString *didGuessWordNotification = @"didGuessWordNotification";

@interface LXKeyBoardCollectionViewHandler ()

@property (nonatomic, copy) NSArray *keyArray;

@end

@implementation LXKeyBoardCollectionViewHandler

- (void)restart {
    self.keyArray = nil;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arr = [self.keyArray objectAtIndex:indexPath.section];
    LXKeyModel *model = [arr objectAtIndex:indexPath.row];
    
    if (!model.isSelected) {
        model.isSelected = YES;
    } else {
        return;
    }
    
    [SVProgressHUD show];
    WEAK_SELF;
    [[HangManKit sharedInstance] guessWithCharacter:model.key successBlock:^(LXWordModel *model) {
        STRONG_SELF;
        [SVProgressHUD dismiss];
        
        [collectionView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didGuessWordNotification" object:model];
        
    } failureBlock:^(NSError *error) {
        STRONG_SELF;
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.keyArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *arr = [self.keyArray objectAtIndex:section];
    return arr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"keyBoardCollectionViewCell" forIndexPath:indexPath];
    
    NSArray *arr = [self.keyArray objectAtIndex:indexPath.section];
    LXKeyModel *model = [arr objectAtIndex:indexPath.row];
    
    UILabel *label = [cell viewWithTag:1];
    label.text = model.key;
    cell.backgroundColor = model.isSelected ? [UIColor grayColor] : [UIColor greenColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
// 动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arr = [self.keyArray objectAtIndex:indexPath.section];
    NSInteger count = arr.count;
    
    return CGSizeMake(MAX((LXScreenWidth - 40)/count - 10, 10), 200.0/self.keyArray.count);
}


//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

//动态设置某组头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(LXScreenWidth, 0);
    }
    return CGSizeMake(LXScreenWidth, 5);
}

//动态设置某组尾视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSArray *arr = [self.keyArray objectAtIndex:section];
    NSInteger count = arr.count;
    if (section == count - 1) {
        return CGSizeMake(LXScreenWidth, 0);
    }
    return CGSizeMake(LXScreenWidth, 5);
}

#pragma mark - lazy load
- (NSArray *)keyArray {
    if (!_keyArray) {
        _keyArray = [self constructKeyArray];
    }
    
    return _keyArray;
}

- (NSArray *)constructKeyArray {
    NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
    NSArray *arr = @[
  @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I"],
  @[@"G",@"K",@"L",@"M",@"N",@"O",@"P",@"Q"],
  @[@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]
  ];
    
    
    for (NSArray *a in arr) {
        NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
        for (NSString *c in a) {
            [tmpArr addObject:[LXKeyModel modelWithKey:c]];
        }
        [mutableArr addObject:[tmpArr copy]];
    }
    
    return [mutableArr copy];
}

@end
