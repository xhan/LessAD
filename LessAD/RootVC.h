//
//  RootVC.h
//  LessAD
//
//  Created by xhan on 10/18/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootVC : UITableViewController
@property (weak, nonatomic) IBOutlet UISwitch *switcher;
@property (weak, nonatomic) IBOutlet UILabel *blockCntLabel;
- (IBAction)onSwitchPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;





@end
