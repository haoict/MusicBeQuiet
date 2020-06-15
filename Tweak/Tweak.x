#import <UIKit/UIKit.h>

@interface SBVolumeControl : NSObject
- (float)_effectiveVolume;
@end

@interface SBMediaPlayer : NSObject
+ (id)sharedInstance;
- (BOOL)isPaused;
- (BOOL)playForEventSource:(long long)arg1 ;
- (BOOL)pauseForEventSource:(long long)arg1;
@end

%group MusicBeQuiet

%hook SBVolumeControl

- (void)increaseVolume {

	%orig;

	if (self._effectiveVolume < 0.1 && [[%c(SBMediaController) sharedInstance] isPaused])
		[[%c(SBMediaController) sharedInstance] playForEventSource:0];

}

- (void)decreaseVolume {

	%orig;

	if (self._effectiveVolume < 0.1 && ![[%c(SBMediaController) sharedInstance] isPaused])
		[[%c(SBMediaController) sharedInstance] pauseForEventSource:0];

}

%end

%end

%ctor {

	%init(MusicBeQuiet);

}
