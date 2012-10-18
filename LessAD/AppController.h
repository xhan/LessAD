//
//  AppController.h
//  LessAD
//
//  Created by xhan on 10/18/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppController : NSObject<NSCoding>

+ (id)controller;
+ (void)release;
- (IBAction)onSwitchValueChanged:(id)sender;
@end
