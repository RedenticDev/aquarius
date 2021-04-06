ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Aquarius
Aquarius_FILES = Tweak.xm $(wildcard *.m)
Aquarius_CFLAGS = -fobjc-arc
# FRAMEWORKS

include $(THEOS_MAKE_PATH)/tweak.mk
