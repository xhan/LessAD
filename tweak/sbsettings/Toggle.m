#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../../shared/LessAD.h"


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

