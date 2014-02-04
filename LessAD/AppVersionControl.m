//
//  AppVersionControl.m
//  Secret
//
//  Created by xu xhan on 7/30/11.
//  Copyright 2011 xu han. All rights reserved.
//


#import "AppVersionControl.h"
#import "APIEngine.h"

#define KAppVersionVersion @"version"
#define KAppVersionBuild   @"build"
#define KAppVersionChnageLog @"change"
#define KAppVersionURL @"url"
#define kAppVersionStoreKey @"AppVersionLastChecked"

@implementation AppVersionControl
@synthesize isCheckByBuild = _isCheckByBuild;
@synthesize delegate = _delegate;
@synthesize checkDuration = _checkDuration;
+ (NSComparisonResult)versionComapreFrom:(NSString*)v1 to:(NSString*)v2
{
    
    NSMutableArray* anotherVer = [NSMutableArray arrayWithArray:[v2 componentsSeparatedByString:@"."]];
	NSMutableArray* selfVer = [NSMutableArray arrayWithArray:[v1 componentsSeparatedByString:@"."]];
	NSMutableArray* shortOne = [anotherVer count] > [selfVer count]?selfVer:anotherVer;
	for (int i = 0; i < abs([anotherVer count]-[selfVer count]); i++) {
		[shortOne addObject:@"0"];
	}
	for (int i = 0; i < [anotherVer count]; i++) {
		if ([anotherVer[i] isEqual:selfVer[i]]) {
			continue;
		}else {
			if ([selfVer[i] intValue] > [anotherVer[i] intValue]) {
				return NSOrderedDescending;
			}else {
				return NSOrderedAscending;
			}
		}
	}
	return NSOrderedSame;
}

+ (BOOL)needToCheckUpdateInfo:(int)durationBySeconds
{
    NSInteger integer = [[NSUserDefaults standardUserDefaults] integerForKey:kAppVersionStoreKey];
    NSInteger now     = [[NSDate date] timeIntervalSince1970];
    return now - integer >= durationBySeconds;
}


- (id)init
{
    self = [super init];
    if (self) {
        _isCheckByBuild = NO;
        self.checkDuration = 24 * 3600 * 2;
    }
    
    return self;
}

- (void)dealloc
{
    PLCleanRelease(_client);
    PLSafeRelease(_latestAppInfo);
    [super dealloc];     
}

#pragma mark - properties
+ (NSString*)appinfoForKey:(NSString*)key
{
    return [[NSBundle mainBundle] infoDictionary][key];
}

- (NSString*)appinfoForKey:(NSString*)key
{
    return [[self class] appinfoForKey:key];
}

- (NSString*)currentBuild
{
    return [self appinfoForKey:@"CFBundleVersion"];
}

- (NSString*)currentVersion
{
    return [self appinfoForKey:@"CFBundleShortVersionString"]; 
}

- (BOOL)hasUpdateAvailable
{
    if (!_latestAppInfo) {
        return NO;
    }
    
    if (_isCheckByBuild) {
        return [self.currentBuild intValue] < [self.latestBuild intValue];
    }else{
        if ([self.currentVersion isKindOfClass:NSString.class] && 
            [self.latestVersion isKindOfClass:NSString.class]) {
                return [[self class] versionComapreFrom:self.currentVersion to:self.latestVersion] == NSOrderedAscending;
        }else{
            return NO;
        }        

    }
}

- (NSString*)latestVersion
{
    id version = SETNIL([_latestAppInfo objectForKey:KAppVersionVersion], self.currentVersion);
    if ([version isKindOfClass:NSNumber.class]) {
        version = [version stringValue];
    }
    return version;
}

- (NSString*)latestBuild
{
    return SETNIL([_latestAppInfo objectForKey:KAppVersionBuild],self.currentBuild);    
}

- (NSString*)changeLog
{
    return SETNIL([_latestAppInfo objectForKey:KAppVersionChnageLog], @""); 
}

- (NSString*)latestURL
{
    return _latestAppInfo[KAppVersionURL];
}

#pragma mark - actions
#if TARGET_OS_IPHONE
- (void)freezeApp:(NSString*)message atWindow:(UIWindow*)win
{
    win.userInteractionEnabled = NO;
    
    UIView* v = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    v.backgroundColor = [UIColor darkGrayColor];
    v.alpha = 0.7;
    [win addSubview:v];
    [v release];
    
    NSString* title = @"软件已过期";
    NSString* info = SETNIL(message, @"请下载最新版本继续体验");
    UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:title
                                                       message:info
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:nil];
    [alerView show];
    [alerView release];    
}
#endif
#pragma mark - http client delegates

- (void)httpClient:(PLHttpClient *)hc failed:(NSError *)error
{
    
}

- (void)httpClient:(PLHttpClient *)hc successed:(NSData *)data
{
    /*
     {
         version: "1.0.1"
         build: 20
         change: "added editing ability to your artilces"
     }
     */
    NSError* error = nil;
    NSDictionary * dict = [APIEngine parseContent:[hc stringValue]
                                        withError:&error];
    PLSafeRelease(_latestAppInfo);
    if (error) {
        [self httpClient:hc failed:error];
    }else{
        _latestAppInfo = [dict retain];
        if ([_delegate respondsToSelector:@selector(appVersionControl:isNewVersionFounded:)]) {                
            [_delegate appVersionControl:self isNewVersionFounded:self.hasUpdateAvailable];
        }
        NSInteger time = [[NSDate date] timeIntervalSince1970];
        [[NSUserDefaults standardUserDefaults] setInteger:time forKey:kAppVersionStoreKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (void)getUpdateInfo:(NSURL*)appinfoURL
{
    if (!_client) {
        _client = [[HttpClient alloc] initWithDelegate:self];
    }
    [_client get:appinfoURL];
}


- (void)addNextCheckDuration:(int)durationSeconds
{
    NSInteger oldValue = [[NSUserDefaults standardUserDefaults] integerForKey:kAppVersionStoreKey];
    [[NSUserDefaults standardUserDefaults] setInteger:oldValue+durationSeconds
                                               forKey:kAppVersionStoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
