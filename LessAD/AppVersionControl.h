//
//  AppVersionControl.h
//  Secret
//
//  Created by xu xhan on 7/30/11.
//  Copyright 2011 xu han. All rights reserved.
//


//TODO: this class could be splited to common lib

/*
 response JSON format from svr should be formated as below
 
 @format 
 
 {
    version: "1.0.1"
    build: 20
    change: "added editing ability to your artilces"
    url:    "url to download latest app"
 }
  
 things should be removed from here
 
 1. response handle<parser>
 2. request handle<make request>
 
 */



#import <Foundation/Foundation.h>
#import "HttpClient.h"

@class AppVersionControl;
@protocol AppVersionControlDelegate <NSObject>

@optional
//currently only received message when new version available
- (void)appVersionControl:(AppVersionControl*)control isNewVersionFounded:(BOOL)isHaveNewVersion;

@end

@interface AppVersionControl : NSObject<PLHttpClientDelegate>{
    HttpClient* _client;
    NSDictionary* _latestAppInfo;
}

/* default is false, using AppVersion instead
 
 build version shoulb be an integer value if set to YES
 
 TODO: add support to (or string that with common compare ability)
 */
@property(nonatomic,assign) BOOL isCheckByBuild;
@property(nonatomic,assign) id   delegate;
@property(nonatomic,assign) int  checkDuration; //default is 24 * 3600 * 2 (2天检查更新)

@property(readonly) NSString* currentVersion;
@property(readonly) NSString* currentBuild;

@property(readonly) BOOL hasUpdateAvailable;
@property(readonly) NSString* latestVersion;
@property(readonly) NSString* latestBuild;
@property(readonly) NSString* changeLog;
@property(readonly) NSString* latestURL;

+ (NSString*)appinfoForKey:(NSString*)key;
- (NSString*)appinfoForKey:(NSString*)key;

//@property(nonatomic,retain) NSURL* urlAppinfo;

////////////////////////////////////////////////////////
// class method
+ (NSComparisonResult)versionComapreFrom:(NSString*)v1 to:(NSString*)v2;
+ (BOOL)needToCheckUpdateInfo:(int)durationBySeconds;

////////////////////////////////////////////////////////
// instance method
#if TARGET_OS_IPHONE
- (void)freezeApp:(NSString*)message atWindow:(UIWindow*)win;
#endif
- (void)getUpdateInfo:(NSURL*)appinfoURL;

// increase next check time interval
- (void)addNextCheckDuration:(int)durationSeconds;
@end
