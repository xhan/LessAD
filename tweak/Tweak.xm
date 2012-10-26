//# define DEBUG
#import <UIKit/UIKit.h>
#import "../shared/LessAD.h"
#import "../shared/PLOG.h"
// #import <Foundation/NSObjCRuntime.h>


#define RNIL {_LOG;_handleAD_alloced(); return nil;}
#define RVOD {_LOG;_handleAD_alloced(); return;}
#define _LOG ((void)0)
//#define _LOG _log(__PRETTY_FUNCTION__)
/*
static void _log(const char*info)
{
	static bool initLog = false;
	if(!initLog){
		[PLLOG_File createDefaultLogger:@"/var/mobile/Library/Logs/ad.log"];
	}	
	PLOGF(@"%@",[NSString stringWithUTF8String:info]);
}
*/

static void _handleAD_alloced(){

	NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithContentsOfFile:PLIST_FILE];
	int cnt = [[plistDict objectForKey:KEYBLOCKCNT] intValue] + 1;
	[plistDict setValue:[NSNumber numberWithInt:cnt] forKey:KEYBLOCKCNT];
	[plistDict writeToFile:PLIST_FILE atomically: YES];
	//TODO: notify messages
}

static void _log_app(NSBundle*bundle,NSString*home){
	NSMutableArray *plistAry = [NSMutableArray arrayWithContentsOfFile:PLIST_APPS];
	if(!plistAry) plistAry = [NSMutableArray array];
		
	NSMutableDictionary*info = [NSMutableDictionary dictionaryWithDictionary:[bundle infoDictionary]];
	[info setObject:home forKey:KEY_APP_HOME_PATH];
	[info setObject:[bundle bundlePath] forKey:KEY_APP_BUNDLE_PATH];
	[plistAry addObject:info];
	
	while(plistAry.count > kMaxRecentlyAppCnt){
		[plistAry removeObjectAtIndex:0];
	}
	[plistAry writeToFile:PLIST_APPS atomically:YES];
	//TODO or use gdc to dispatch after some time
}

%group CommonAD

/*
 Admob "Guohe 果合"  "adsmongo 芒果"
 "domob 多盟" iAD MobWin Wooboo Adwo "youmi 有米广告"  "wiad 微云"
 SmartMad--亿动智道	"mobiSage 艾德思奇"	"Millennial Media"	InMobi baiduMunion 
 "AdChina 易传媒" AdFracta airADView "CaseeAd 架势无线"
 Greystripe IZP Jumptap
 umeng WeiQian ZestADZ VPON "renren ADER" MDotM miidi adwhirl
*/	
///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Admob
%hook GADBannerView
- (id)init {RNIL}
- (id)initWithFrame:(CGRect)frame {RNIL}
- (id)initWithAdSize:(int)size origin:(CGPoint)origin {RNIL}
%end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 果合 guohe
@interface GHAdView :UIView
@end
%hook GHAdView
// - (void)loadAd{}
// - (void)resumeAdRequest{}
// - (void)preloadAd{}
- (id)initWithAdUnitId:(NSString *)adUnitId size:(CGSize)size{RNIL}
%end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 芒果 adsmongo
%hook AdMoGoView
- (id) initWithAppKey:(NSString *)ak  adType:(int)type expressMode:(BOOL)express adMoGoViewDelegate:(id) delegate {RNIL}
- (id) initWithAppKey:(NSString *)ak  adType:(int)type adMoGoViewDelegate:(id) delegate {RNIL}		
+ (AdMoGoView *)requestAdMoGoViewWithDelegate:(id)delegate AndAdType:(int)type {RNIL}
+ (AdMoGoView *)requestAdMoGoViewWithDelegate:(id)delegate AndAdType:(int)type ExpressMode:(BOOL)express {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 多盟 domob
@interface DoMobView : UIView
@end
%hook DoMobView
+ (DoMobView *)requestDoMobViewWithSize:(CGSize)sizeofAd WithDelegate:(id) delegate {RNIL}
+ (DoMobView *)requestDoMobViewWithDelegate:(id)delegate {RNIL}
%end
#pragma mark - 多盟 v3.0
%hook DMAdView
- (id)initWithPublisherId:(NSString *)publisherId size:(CGSize)adSize {RNIL}
- (id)initWithPublisherId:(NSString *)publisherId size:(CGSize)adSize autorefresh:(BOOL)autorefresh {RNIL}
%end
%hook DMInterstitialAdController
- (void)loadAd {RVOD}
- (void)present {RVOD}
%end
///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - iAD
%hook ADBannerView
- (id)initWithFrame:(CGRect)frame {RNIL}
- (id)init {RNIL}
%end
%hook ADInterstitialAd
- (id)init {RNIL}
%end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - MobWin  QQ
%hook MobWinBannerView
- (id)initMobWinBannerSizeIdentifier:(int)sizeIdentifier {RNIL}
- (id)initMobWinBannerSizeIdentifier:(int)sizeIdentifier keyByMobWIN:(NSString*)key {RNIL}
- (id)initMobWinBannerSizeIdentifier:(int)sizeIdentifier integrationKey:(NSString*)key {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Wooboo iOS SDK 2.0 - 2.3
%hook ImpressionADView
-(id)initWithADWith:(NSString *)Wooboo_PID status:(BOOL)isTesting offsetX:(int)x offsetY:(int)y  displayType:(int)screenState 
horizontalOrientation:(int) horizontal{RNIL}
//2.3
-(void)startADRequest {RVOD}
%end
%hook CommonADView
-(id)initWithADWith:(NSString *)Wooboo_PID status:(BOOL)isTesting xLocation:(float)x yLocation:(float)y displayType:(int)screenState
 horizontalOrientation:(int) horizontal{RNIL}
 //2.3
 -(void)startADRequest {RVOD}
%end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Adwo.com
%hook AWAdView
- (id)initWithAdwoPid:(NSString *)unid adIdType:(SInt8) adIdType adTestMode:(SInt8) adTestMode adSizeForPad:(SInt8)adSizeForPad{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - youmi 有米广告
%hook YouMiView
+ (YouMiView *)adViewWithContentSizeIdentifier:(int)contentSizeIdentifier delegate:(id)delegate{RNIL}
- (id)initWithContentSizeIdentifier:(int)contentSizeIdentifier delegate:(id)delegate{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - wiad 微云
%hook WiAdView
+ (WiAdView*)adViewWithResId:(NSString*)resId style:(int)style{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - SmartMad--亿动智道
%hook SmartMadAdView
-(SmartMadAdView*)initRequestAdWithParameters:(NSString*)posID aInterval:(NSTimeInterval)aInterval
									adMeasure:(int)adMeasure adBannerAnimation:(int)adBannerAnimation compileMode:(int)compileMode{
										return nil;
									}
- (id)init {RNIL}
- (id)initWithFrame:(CGRect)s {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - mobiSage 艾德思奇
%hook MobiSageManager
+(MobiSageManager*)getInstance{RNIL}
%end
%hook MobiSageAdBanner
-(id)initWithAdSize:(NSUInteger)adSize{RNIL}
-(id)initWithAdSize:(NSUInteger)adSize PublisherID:(NSString *)publisherID{RNIL}
%end
%hook MobiSageAdPoster
-(id)initWithAdSize:(NSUInteger)adSize{RNIL}
-(id)initWithAdSize:(NSUInteger)adSize PublisherID:(NSString *)publisherID{RNIL}
%end
///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Millennial Media
%hook MMAdView
+ (MMAdView *) adWithFrame:(CGRect)aFrame type:(int) type apid:(NSString *) apid delegate: (id) aDelegate loadAd: (BOOL) loadAd startTimer: (BOOL) startTimer{RNIL}
+ (MMAdView *) interstitialWithType:(int) type apid: (NSString *) apid delegate: (id)aDelegate loadAd: (BOOL) loadAd{RNIL}
%end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - InMobi
%hook IMAdView
- (id)initWithFrame:(CGRect)frame imAppId:(NSString *)_imAppId imAdUnit:(int)_imAdUnit rootViewController:(UIViewController *)_viewController{RNIL}
%end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - baiduMunion
%hook BaiduMobAdView
+ (BaiduMobAdView*) sharedAdViewWithDelegate: (id) delegate{RNIL}
+ (BaiduMobAdView*) sharedAdView{RNIL}
- (id)init {RNIL}
- (id)initWithFrame:(CGRect)r {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - AdChina 易传媒
%hook AdChinaBannerView
+ (AdChinaBannerView *)requestAdWithAdSpaceId:(NSString *)theAdSpaceId delegate:(id)d adSize:(CGSize)s {RNIL}
+ (AdChinaBannerView *)requestAdWithDelegate:(id)theDelegate{RNIL}
+ (AdChinaBannerView *)requestAdWithDelegate:(id)theDelegate animationMask:(int)mask{RNIL}
+ (AdChinaBannerView *)requestAdWithAdSpaceId:(NSString *)theAdSpaceId delegate:(id)theDelegate{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - AdFracta
%hook AdFractaView
+ (AdFractaView*)photoAdWithFrame:(CGRect)frame delegate:(id)delegate adType:(int)adType{RNIL}
%end
%hook FtadBannerView
+ (FtadBannerView*)newFtadBannerViewWithPointAndSize:(CGPoint)point size:(CGSize)size 
adIdentify:(NSString*)adIdentify delegate:(id)d {RNIL}
%end
%hook FtadHtml5BannerView
+ (FtadHtml5BannerView*)newFtadHtml5BannerViewWithPointAndSize:(CGPoint)point size:(CGSize)size 
adIdentify:(NSString*)adIdentify delegate:(id)adstatus {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - airADView
%hook airADView
- (id)init{RNIL}
- (id)initWithFrame:(CGRect)rect{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - CaseeAd 架势无线 www.casee.cn
%hook CaseeAdView
+(CaseeAdView *)adViewWithDelegate:(id)delegate caseeRectStyle:(int)adSize{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Greystripe
%hook GSAdView
+ (id)adViewForSlotNamed:(NSString *)a_name delegate:(id)a refreshInterval:(NSTimeInterval)a_interval{
	return nil;
}
%end
%hook GSBannerAdView
- (id)initWithDelegate:(id)a_delegate GUID:(NSString *)a_GUID autoload:(BOOL)a_autoload {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - IZP
%hook IZPView
- (id)init{RNIL}
- (id)initWithFrame:(CGRect)rect{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Jumptap
%hook JTAdWidget
- (id) initWithDelegate:(id)a shouldStartLoading: (BOOL)s{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - umeng umeng.com
%hook UMAdBannerView
- (id)init{RNIL}
- (id)initWithFrame:(CGRect)rect{RNIL}
%end
%hook UMUFPBannerView
- (id)initWithFrame:(CGRect)frame appKey:(NSString *)appkey slotId:(NSString *)slotId currentViewController:(UIViewController *)controller
{RNIL}
%end
///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - WeiQian
%hook WQAdView
- (id)init{RNIL}
- (id)initWithFrame:(CGRect)rect{RNIL}
+(id) requestAdByLocation:(int) location withSize:(CGSize)size withDelegate:(id)d {RNIL}
+(id) requestAdOfRect:(CGRect)rect withDelegate:(id)d {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - ZestADZ
%hook ZestadzView
+ (ZestadzView *)requestAdWithDelegate:(id)delegate{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - VPON
%hook VponAdOnView
- (id)init{RNIL}
- (id)initWithFrame:(CGRect)rect{RNIL}
- (void) requestAdWithSize:(CGSize)size setAdOnDelegate:(id)d{RVOD}
- (NSArray *)requestDelegate:(id)d LicenseKey:(NSArray *)arrayLicenseKey size:(CGSize)size{RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - RenRen ADER
%hook AderSDK
+ (void)startAdService:(UIView *)v appID:(NSString *)appID adFrame:(CGRect)frame model:(int)model{RVOD}
%end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - MDotM
%hook MdotMAdView
- (id)init {RNIL}
- (id)initWithFrame {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - miidi 
%hook MiidiAdView
- (id)init {RNIL}
- (id)initWithFrame {RNIL}
+ (MiidiAdView *)createMiidiAdViewWithSizeIdentifier:(int)ad delegate:(id)delegate {RNIL}
- (id)initMiidiAdViewWithContentSizeIdentifier:(int)ad delegate:(id)delegate {RNIL}
%end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - adwhirl 
%hook AdWhirlView
+ (AdWhirlView *)requestAdWhirlViewWithDelegate:(id)delegate {RNIL}
%end

// end of group	
%end	


%group WEIBO
%hook WBAdManager
- (void)loadServerAd{RVOD}
- (void)presentAds{RVOD}
%end

%hook WBAdViewContainer
- (void)presentNextAd{RVOD}
- (void)presentAds{RVOD}
%end

%hook HomeViewController
- (void)showAd{RVOD}
%end
%end	
	

%group QQ
	
%hook UITableView
- (void)setTableHeaderView:(UIView*)v
{
	BOOL ad = [v isKindOfClass:NSClassFromString(@"QQPushBannerView_Advertisement")];
	if(ad) return;
	%orig(v);
}
%end	
%end		
	
%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	// init basic group
	// %init;
	NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
	NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithContentsOfFile:PLIST_FILE];
	
	id value = [settings objectForKey:KEYON];
	if(!value)
	{
		value = [NSNumber numberWithBool:YES];
		//create new plist file
		NSDictionary*dict = [NSDictionary dictionaryWithObject:value forKey:KEYON];
		[dict writeToFile:PLIST_FILE atomically:YES];
	}
	BOOL ABEnabled = [value boolValue];
	

	BOOL appBlockAD = YES;
	// appBlockAD = [bundleIdentifier rangeOfString:@"com.qiushibaike."].location == NSNotFound;
	if(ABEnabled){
		if ([bundleIdentifier isEqualToString:@"com.sina.weibo"])
			%init(WEIBO);
		else if ([bundleIdentifier isEqualToString:@"com.tencent.mqq"]){			
			%init(QQ);
//			%init(CommonAD);
		}
		else 
			%init(CommonAD);		
		// appBlockAD && 
		
	}
	_log_app([NSBundle mainBundle],NSHomeDirectory());
	[pool drain];
}	