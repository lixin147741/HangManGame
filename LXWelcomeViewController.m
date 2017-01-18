//
//  LXWelcomeViewController.m
//  HangMan
//
//  Created by 李鑫 on 17/1/17.
//  Copyright © 2017年 Kee. All rights reserved.
//

#import "LXWelcomeViewController.h"
#import "LXEnvironment.h"
#import "HangManKit.h"
#import "Macros.h"
#import "SVProgressHUD.h"

NSString *didStartGameNotifation = @"didStartGameNotifation";

@interface LXWelcomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation LXWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameLabel.text = [LXEnvironment playerId];
}

- (IBAction)startBtnClicked:(id)sender {
    
    [SVProgressHUD show];
    WEAK_SELF;
    [[HangManKit sharedInstance] startGameWithSuccessBlock:^(LXStartGameModel *model) {
        STRONG_SELF;
        [SVProgressHUD dismiss];
        
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:didStartGameNotifation object:model];
        }];
        
    } failureBlock:^(NSError *error) {
        STRONG_SELF;
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}


@end
