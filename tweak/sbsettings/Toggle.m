#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define PLIST_FILE @"/var/mobile/Library/Preferences/com.xhan.LessAD.plist"
#define KEY_ACTIVE @"ABEnabled"
// Required

BOOL isCapable()
{
	return YES;
}

BOOL isEnabled()
{
	NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:PLIST_FILE];
	id value = [settings objectForKey:KEY_ACTIVE];
	BOOL ABEnabled =  value ? [value boolValue] : YES;
	return ABEnabled;
}

void setState(BOOL enabled)
{
    NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithContentsOfFile:PLIST_FILE];
    if (enabled) 
    {
            [plistDict setValue:[NSNumber numberWithBool:YES] forKey:KEY_ACTIVE];
            [plistDict writeToFile:PLIST_FILE atomically: YES];
    }
    else
    {
            [plistDict setValue:[NSNumber numberWithBool:NO] forKey:KEY_ACTIVE];
            [plistDict writeToFile:PLIST_FILE atomically: YES];
    }
}

float getDelayTime()
{
	return 0.0f;
}

/* Optional

BOOL getStateFast()
{
	
}

void invokeHoldAction()
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

