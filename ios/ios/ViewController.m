//
//  ViewController.m
//  ios
//
//  Created by Duncan Du [MIGOTP] on 2018/1/31.
//  Copyright © 2018年 Duncan. All rights reserved.
//

#import "ViewController.h"
#import <React/RCTRootView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
    // Dispose of any resources that can be recreated.
}

- (IBAction)addRNViewPressed:(id)sender {
    NSLog(@"add RN View Button Pressed");
    
    // 加入 RN View， RNExistingApp RN 註冊的名稱
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                moduleName: @"RNExistingApp"
                         initialProperties:
     @{
       @"message" : @"Hello, I'm come from iOS"
       }
                             launchOptions: nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
//    [self showAlert];
    
}

@end
