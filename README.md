# Multipla-API
A guide of the API included with Multipla!

## Getting Started
Multipla loads bundles of widgets located at /Library/Multipla/Widgets. To add your own widget, simply make a DragonBuild/Theos bundle project. An template of a DragonMake for a third party widget is as follows:

```yaml
name: TweakName
icmd: killall -9 SpringBoard

all:
    targetvers: 13.0
    archs:
        - arm64
        - arm64e

TweakName:
    type: tweak
    logos_files: "Tweak.xm"

ExternalWidgetExample:
    dir: Widget
    type: bundle
    files:
        - ExternalWidgetExample.m
    frameworks:
        - UIKit
        - Foundation
    install_location: /Library/Multipla/Widgets/
 ```

**NOTE:** As of builds before 12/7/2020, dragon seems to be broken with the `bundle` option. The Info.plist is installed in /Library/Multipla/Widgets/ExternalWidgetExample.bundle/ExternalWidgetExample.bundle/Info.plist, as opposed to /Library/Multipla/Widgets/ExternalWidgetExample.bundle/Info.plist. This will cause a crash.

This bug has been reported to kritanta, and has since been fixed by him. Update dragon by running `dragon update`


## Requirements

Your bundle must have an Info.plist with the following information:
- NSPrincipalClass (the class of which your widget is, for example: EXPExternalWidget)
- CFBundleExecutable (the executable name of the compiled widget class)
- name (the display name you want to show on the dock label and in Settings

Template for a Info.plist for the battery widget class shown above in the DragonMake example:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleExecutable</key>
	<string>ExternalWidgetExample</string>
	<key>NSPrincipalClass</key>
	<string>ExternalWidgetExample</string>
	<key>name</key>
	<string>External Widget</string>
</dict>
</plist>

```

Multipla will load your widget bundle at runtime and add an instance of it to the dock if the user has selected your widget. Please **do not** rely on the widget being initialized at runtime, for it is not guaranteed to be. Instead, consider adding a `sharedInstance` method to your widget class, so you can tell if an instance exists or not (provided you are checking from SpringBoard)

Your widget class must implement the following protocol:
```objc
@protocol MPAWidgetProtocol

// you MUST implement this method, or it will crash.
@required

// called when scrolling ends and the widget needs an update.
// will be called even if your widget was the one that was
// showing already. if the user cancels their scroll, your
// widget will be called to update again.
- (void)updateWidget;

// these methods are optional, and solely to make your life easier.
// only available in 2.1.0~rc5 and later, please make your package depend on
// the version being greater or equal to this if your widget needs it to function.
@optional

// called when the widget is set as the currently displaying widget
// and it wasn't before
- (void)widgetBecameFocused;

// widget is completely hidden and scrolling has stopped
// feel free to reset your views here if you need to,
// the user should not be able to see any changes you make,
// so you don't even need animations.
- (void)widgetLostFocus;
@end```

If you need to refresh your widget while it is showing, you can make use of system post notifications being sent, or even include a tweak subproject for the purpose of sending these notifications to update whenever you choose. Just add an observer in the init method for the notification you want to listen for, and have it call the selector `updateWidget`.

## Closing notes
If you are confused, dm me on Twitter (@burrit0ztweaks) or take a look at the template/example project (catgirl-widget) in this repository. The widget will appear in the select widgets page in Multipla's settings.
