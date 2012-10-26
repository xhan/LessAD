//
//  WebVC.h
//  LessAD
//
//  Created by xhan on 10/26/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityview;

@end
