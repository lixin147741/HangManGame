//
//  LXMainViewController.m
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import "LXMainViewController.h"
#import <UIKit/UIKit.h>
#import "HangManKit.h"
#import "LXWelcomeViewController.h"
#import "LXKeyBoardCollectionViewHandler.h"
#import "LXWordModel.h"
#import "Macros.h"
#import "SVProgressHUD.h"

@interface LXMainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *totalWordCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *completeWordCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *wrongGuessCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentWordWrongGuessLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWordCount;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *keyBoardCollectionView;


@property (nonatomic, strong) LXKeyBoardCollectionViewHandler *keyboardHandler;

@property (nonatomic, assign) NSInteger numberOfEachWordGuess;

@property (nonatomic, assign) BOOL hasSubmit;

@property (nonatomic, assign) NSInteger currentTriedCount;

@end

@implementation LXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNotification];
    [self setupKeyBoard];
    
    [self loginIfNeeded];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVC:) name:didStartGameNotifation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateVC:) name:didGuessWordNotification object:nil];
}

- (void)setupKeyBoard {
    self.keyBoardCollectionView.delegate = self.keyboardHandler;
    self.keyBoardCollectionView.dataSource = self.keyboardHandler;
}

#pragma mark - action
- (IBAction)resartGame:(id)sender {
    
    if (self.hasSubmit) {
        [self gameOver];
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"还有提交您的分数，确定重新开始游戏吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"重新开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self loginIfNeeded];
    }];
    
    UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"提交成绩" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self commitScore:nil];
    }];
    
    
    [alert addAction:okAction];
    [alert addAction:submitAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)skipWord:(id)sender {
    [self getNextWord];
}
- (IBAction)commitScore:(id)sender {
    
    [SVProgressHUD show];
    WEAK_SELF;
    [[HangManKit sharedInstance] submitResultWithSuccessBlock:^(LXResultModel *model) {
        STRONG_SELF;
        [SVProgressHUD dismiss];
        
        // 弹出关键信息
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"游戏结束" message:[NSString stringWithFormat:@"最终得分是%@", model.score] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"退出游戏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self loginIfNeeded];
            self.hasSubmit = YES;
        }];
        
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    } failureBlock:^(NSError *error) {
        STRONG_SELF;
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

#pragma mark - private method
- (void)loginIfNeeded {
    
    [self gotoLogin];
}

- (void)gotoLogin {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Welcome" bundle:[NSBundle mainBundle]];
    LXWelcomeViewController *welVC = [storyboard instantiateViewControllerWithIdentifier:@"LXWelcomeViewController"];
    
    [self presentViewController:welVC animated:YES completion:nil];
}

- (void)getUserScore {
    
    [SVProgressHUD show];
    WEAK_SELF;
    [[HangManKit sharedInstance] getResultWithSuccessBlock:^(LXResultModel *model) {
        STRONG_SELF;
        [SVProgressHUD dismiss];
        
        [self updateWithResultModel:model];
    } failureBlock:^(NSError *error) {
        STRONG_SELF;
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

- (void)updateWithResultModel:(LXResultModel *)model {
    
    self.completeWordCountLabel.text = [model.correctWordCount stringValue];
    self.wrongGuessCountLabel.text = [model.totalWrongGuessCount stringValue];
    self.scoreLabel.text = [model.score stringValue];
}

- (void)updateWithWordModel:(LXWordModel *)model {
    
    self.wordLabel.text = model.word;
    self.currentWordCount.text = [NSString stringWithFormat:@"当前第%@个", model.totalWordCount];
    self.currentTriedCount = [model.totalWordCount integerValue];

    [self updateCurrentWordWrongGuessStatus:[model.wrongGuessCountOfCurrentWord integerValue]];
    
    if ([self checkSuccessWithWord:model.word]) {
        // 鉴于这是一个低频的触发场景,多停留一会
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜" message:[NSString stringWithFormat:@"该单词是%@", model.word] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"下一个！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self getNextWord];
        }];
        
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)updateVC:(NSNotification *)noti {
    
    id model = noti.object;
    
    if ([model isKindOfClass:[LXWordModel class]]) {
        
        LXWordModel *model = noti.object;
        [self updateWithWordModel:model];
        [self getUserScore];

    } else if ([model isKindOfClass:[LXStartGameModel class]]) {
        self.hasSubmit = NO;
        LXStartGameModel *model = noti.object;
        [self startGameWithStartGameModel:model];
    }
    
}

- (void)startGameWithStartGameModel:(LXStartGameModel *)model {
    
    [self refreshKeyBoard];
        
    self.numberOfEachWordGuess = [model.numberOfGuessAllowedForEachWord integerValue];
    
    self.totalWordCountLabel.text = [model.numberOfWordsToGuess stringValue];
    
    [self updateCurrentWordWrongGuessStatus:0];
    
    [self getNextWord];
}

- (void)getNextWord {
    
    [self refreshKeyBoard];
    
    if ([[@(self.currentTriedCount) stringValue] isEqualToString: self.totalWordCountLabel.text]) {
        [SVProgressHUD showInfoWithStatus:@"恭喜您已经通关该游戏，你可以上传成绩并重新开始游戏"];
    }

    [SVProgressHUD show];
    WEAK_SELF;
    [[HangManKit sharedInstance] giveMeAWordWithSuccessBlock:^(LXWordModel *model) {
        STRONG_SELF;
        [SVProgressHUD dismiss];
        [self updateWithWordModel:model];
        
    } failureBlock:^(NSError *error) {
        STRONG_SELF;
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

- (BOOL)checkSuccessWithWord:(NSString *)word {
    if ([word containsString:@"*"]) {
        return NO;
    }
    
    return YES;
}

- (void)refreshKeyBoard {
    [self.keyboardHandler restart];
    [self.keyBoardCollectionView reloadData];
}

- (void)updateCurrentWordWrongGuessStatus:(NSInteger)currentWrongCount {
    
    self.currentWordWrongGuessLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)currentWrongCount, (long)self.numberOfEachWordGuess];
    
    if (currentWrongCount * 2 > self.numberOfEachWordGuess) {
        self.currentWordWrongGuessLabel.textColor = [UIColor redColor];
    } else {
        self.currentWordWrongGuessLabel.textColor = [UIColor blackColor];
    }
    
    if (currentWrongCount == self.numberOfEachWordGuess) {
        [self getNextWord];
    }
}

- (void)gameOver {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"结束" message:@"确定要退出游戏吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotoLogin];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:cancleAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - lazy load
- (LXKeyBoardCollectionViewHandler *)keyboardHandler {
    if (!_keyboardHandler) {
        _keyboardHandler = [[LXKeyBoardCollectionViewHandler alloc] init];
    }
    
    return _keyboardHandler;
}

@end
