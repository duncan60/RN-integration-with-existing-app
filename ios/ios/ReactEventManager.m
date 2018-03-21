//
//  ReactEventManager.m
//  ios
//
//  Created by Duncan Du [MIGOTP] on 2018/2/1.
//  Copyright © 2018年 Duncan. All rights reserved.
//

#import "ReactEventManager.h"
#import <React/RCTLog.h>

@implementation ReactEventManager

RCT_EXPORT_MODULE();

// 定義Events
- (NSArray<NSString *> *)supportedEvents
{
    return @[@"eventToRN"];
}

RCT_EXPORT_METHOD(showNativeAlert:(NSString *)message)
{
    RCTLogInfo(@"from RN Message %@", message);
    // sendEvent
    [self sendEventWithName:@"eventToRN" body:@"test RN integration with existing app"];
    
    // alert
    UIViewController *presentingController = RCTPresentedViewController();
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];

    [alertController addAction:ok];

    [presentingController presentViewController:alertController animated:YES completion: nil];
   // [presentingController dismissViewControllerAnimated:YES completion:nil];
}

@end
