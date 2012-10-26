//
//  WebVC.m
//  LessAD
//
//  Created by xhan on 10/26/12.
//  Copyright (c) 2012 xhan. All rights reserved.
//

#import "WebVC.h"
#import "LessAD.h"
@interface WebVC ()

@end

@implementation WebVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.title isEqualToString:@"关于"]) {
            [self.webview loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"info.html" withExtension:nil]]];
    }
    if ([self.title isEqualToString:@"帮助"]) {
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kProjectURL]]];
    }


}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityview stopAnimating];
}


- (void)viewDidUnload {
    [self setWebview:nil];
    [self setActivityview:nil];
    [super viewDidUnload];
}
@end
