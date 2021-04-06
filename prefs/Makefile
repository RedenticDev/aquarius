ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.0


include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Aquarius

Aquarius_FILES = $(wildcard *.m)
Aquarius_FRAMEWORKS = UIKit CoreGraphics QuartzCore
Aquarius_PRIVATE_FRAMEWORKS = Preferences SpringBoardServices OnBoardingKit
Aquarius_INSTALL_PATH = /Library/PreferenceBundles
Aquarius_CFLAGS = -fobjc-arc
Aquarius_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk
