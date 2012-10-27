//
//  PLAlertView.m
//  QiuBai
//
//  Created by xu xhan on 12/17/11.
//  Copyright (c) 2011 Less Everything. All rights reserved.
//

#import "PLAlertView.h"


#if __has_feature(objc_arc)
#define SAFE_ARC_PROP_RETAIN strong
#define SAFE_ARC_RETAIN(x) (x)
#define SAFE_ARC_RELEASE(x)
#define SAFE_ARC_AUTORELEASE(x) (x)
#define SAFE_ARC_BLOCK_COPY(x) (x)
#define SAFE_ARC_BLOCK_RELEASE(x)
#define SAFE_ARC_SUPER_DEALLOC()
#define SAFE_ARC_AUTORELEASE_POOL_START() @autoreleasepool {
#define SAFE_ARC_AUTORELEASE_POOL_END() }
#else
#define SAFE_ARC_PROP_RETAIN retain
#define SAFE_ARC_RETAIN(x) ([(x) retain])
#define SAFE_ARC_RELEASE(x) ([(x) release])
#define SAFE_ARC_AUTORELEASE(x) ([(x) autorelease])
#define SAFE_ARC_BLOCK_COPY(x) (Block_copy(x))
#define SAFE_ARC_BLOCK_RELEASE(x) (Block_release(x))
#define SAFE_ARC_SUPER_DEALLOC() ([super dealloc])
#define SAFE_ARC_AUTORELEASE_POOL_START() NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#define SAFE_ARC_AUTORELEASE_POOL_END() [pool release];
#endif

@implementation _PLAlertView

- (void)setBlock:(void (^)(int,BOOL))block;
{
    _blockDelegate = SAFE_ARC_BLOCK_COPY(block);
    self.delegate = self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _blockDelegate(buttonIndex,alertView.cancelButtonIndex == buttonIndex);
}
- (void)dealloc
{
    SAFE_ARC_BLOCK_RELEASE(_blockDelegate);
    SAFE_ARC_SUPER_DEALLOC();
}
@end


extern void PLAlert(NSString*title,NSString*body,NSString*cancel,NSString*button,void (^block)(int index,BOOL isCancel))
{
    _PLAlertView*v= [[_PLAlertView alloc] initWithTitle:title
                                                        message:body
                                                       delegate:nil
                                              cancelButtonTitle:cancel
                                              otherButtonTitles:button,nil];
    [v setBlock:block];
    
    //    va_list args;
    //    va_start(args, buttons);
    //    NSString* button = NULL;
    //    while (YES) {
    //        button = va_arg(args, NSString*);
    //        if (!button) {
    //            break;
    //        }
    //        [v addButtonWithTitle:button];
    //    }
    //    va_end(args);
    [v show];
    SAFE_ARC_RELEASE(v);
//    [v release];
    
}