TARGET := iphone:clang:latest:14.0

ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = test

test_FILES = XXXRootListController.m  CLCRootListController.m OTLRootListController.m SETRootListController.m
test_FRAMEWORKS = UIKit CoreGraphics QuartzCore
test_PRIVATE_FRAMEWORKS = Preferences SpringBoardServices OnBoardingKit
test_INSTALL_PATH = /Library/PreferenceBundles
test_CFLAGS = -fobjc-arc
test_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk
