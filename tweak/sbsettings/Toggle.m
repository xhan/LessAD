#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../../shared/LessAD.h"
#import <SpringBoard/SpringBoard.h>
#import "theos/include/SpringBoard/SBIcon.h"
#import "theos/include/SpringBoard/SBApplication.h"
#import "theos/include/SpringBoard/SBApplicationController.h"
#import "theos/include/SpringBoard/SBUIController.h"



// Required

BOOL isCapable()
{
	return YES;
}

BOOL isEnabled()
{
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:PLIST_FILE];
	id value = [settings objectForKey:KEYON];
	BOOL ABEnabled =  value ? [value boolValue] : YES;
	return ABEnabled;
}

void setState(BOOL enabled)
{
    NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithContentsOfFile:PLIST_FILE];

    [plistDict setValue:[NSNumber numberWithBool:enabled] forKey:KEYON];
    [plistDict writeToFile:PLIST_FILE atomically: YES];

}

float getDelayTime()
{
	return 0.0f;
}


void invokeHoldAction()
{
	// SBApplication *app = [[objc_getClass("SBApplicationController") sharedInstance] applicationWithDisplayIdentifier:@"com.xhan.LessAD"];
	// [[objc_getClass("SBUIController") sharedInstance] activateApplicationFromSwitcher: app];
	// SBApplication *app = [[SBApplicationController sharedInstance] applicationWithDisplayIdentifier:@"com.xhan.LessAD"];
	// [[SBUIController sharedInstance] activateApplicationAnimated: app];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"lessad://go"]];
}

/* Optional

BOOL getStateFast()
{
	
}



void closeWindow()
{
	
}

// Convenience method to get the SBSettings window

UIWindow *getAppWindow()
{
	for (UIWindow *window in [[UIApplication sharedApplication] windows])
	{
		if ([window respondsToSelector:@selector(getCurrentTheme)])
			return window;
	}

	return nil;
}

*/

