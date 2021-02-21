export ARCHS = arm64 arm64e
export TARGET := iphone:clang:latest:13.0
export SYSROOT = $(THEOS)/sdks/iPhoneOS.sdk
export FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = EXTExternalWidgetExample

EXTExternalWidgetExample_FILES = Widget/EXTExternalWidgetExample.m
EXTExternalWidgetExample_FRAMEWORKS = UIKit
EXTExternalWidgetExample_INSTALL_PATH = /Library/Multipla/Widgets
EXTExternalWidgetExample_CFLAGS = -fobjc-arc

ADDITIONAL_CFLAGS += -DTHEOS_LEAN_AND_MEAN

include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
