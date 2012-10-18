//
//  AppController.m
//  LessAD
//
//  Created by xhan on 10/18/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "AppController.h"

@implementation AppController

static AppController*_share = nil;

+ (id)controller
{
    if (!_share) {
        _share = [[self alloc] init];
    }
    return _share;
}

+ (void)release
{
    _share = nil;
}
- (id)init
{
//    NSLog(@"init!");
    if (!_share) {
//        NSLog(@"alloc!");
        self = [super init];
        _share = self;
    }

    return _share;
}




- (IBAction)onSwitchValueChanged:(id)sender
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"ok" message:@"fuck" delegate:nil
                                          cancelButtonTitle:@"good"
                                          otherButtonTitles:nil];
    [alert show];
    
}


@end
