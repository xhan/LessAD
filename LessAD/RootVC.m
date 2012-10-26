//
//  RootVC.m
//  LessAD
//
//  Created by xhan on 10/18/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "RootVC.h"
#import "LessAD.h"
@interface RootVC ()

@end

@implementation RootVC
{
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:PLIST_FILE];
    self.versionLabel.text = VERSION;
    self.blockCntLabel.text =   [[plist objectForKey:KEYBLOCKCNT] description] ;
    self.switcher.on = [[plist objectForKey:KEYON] boolValue];
}

- (void)viewDidUnload {
    [self setSwitcher:nil];
    [self setBlockCntLabel:nil];
    [self setVersionLabel:nil];
    [super viewDidUnload];
}

- (IBAction)onSwitchPressed:(UISwitch*)sender {
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:PLIST_FILE];
    [plist setObject:@(sender.on) forKey:KEYON];
    [plist writeToFile:PLIST_FILE atomically:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (segue.identifier) {
        ((UIViewController*)segue.destinationViewController).title = segue.identifier;
    }
    
}

@end
