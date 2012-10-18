//
//  RootVC.m
//  LessAD
//
//  Created by xhan on 10/18/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()

@end

@implementation RootVC



- (void)viewDidLoad
{
    [super viewDidLoad];

}



- (void)viewDidUnload {
    [self setSwitcher:nil];
    [self setBlockCntLabel:nil];
    [self setVersionLabel:nil];
    [super viewDidUnload];
}

- (IBAction)onSwitchPressed:(id)sender {
}
@end
