# Multipla-API
A guide of the API included with Multipla!

## Getting Started
Multipla loads bundles of widgets located at /Library/Multipla/Widgets. To add your own widget, simply make a DragonBuild/Theos bundle project. 

A template of the Makefile for a third party widget is as follows:
```Makefile
export ARCHS = arm64 arm64e
export TARGET := iphone:clang:latest:13.0
export SYSROOT = $(THEOS)/sdks/iPhoneOS.sdk
export FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CRPCryptoWidget

CRPCryptoWidget_FILES = Widget/CRPCryptoWidget.m
CRPCryptoWidget_FRAMEWORKS = UIKit
CRPCryptoWidget_INSTALL_PATH = /Library/Multipla/Widgets
CRPCryptoWidget_CFLAGS = -fobjc-arc

ADDITIONAL_CFLAGS += -DTHEOS_LEAN_AND_MEAN

include $(THEOS_MAKE_PATH)/bundle.mk
SUBPROJECTS += Prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
```

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
	<string>CRPCryptoWidget</string>
	<key>NSPrincipalClass</key>
	<string>CRPCryptoWidget</string>
	<key>name</key>
	<string>Crypto</string>
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
If you are confused, dm me on Twitter (@burrit0ztweaks) or take a look at the template/example projects (catgirl-widget and crypto-widget) in this repository. The widget will appear in the select widgets page in Multipla's settings.
