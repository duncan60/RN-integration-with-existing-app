//
//  ReactMainController.m
//  ios
//
//  Created by Duncan Du [MIGOTP] on 2018/1/31.
//  Copyright © 2018年 Duncan. All rights reserved.
//

#import "ReactMainController.h"
#import <React/RCTRootView.h>

@implementation ReactMainController
- (IBAction)addRNViewPressed:(id)sender {
    NSLog(@"add RN View Button Pressed");
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
}
@end
