//
//  AppDelegate.h
//  LessAD
//
//  Created by xhan on 10/18/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//


/*
    on storyboard app with ARC support:
    1. after storyboard initialized, the app delegate's application did finished will be invoked
    2. custom object created in storyboard, will be release soon, we need to retain it ourself
        (in this case, i used a static ivar to refer the initialized instance, so it woun't be 
        released automatically)
    
    TODO: the first response usage
 
 
 */



#import <UIKit/UIKit.h>
@class AppController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppController*control;




@end
