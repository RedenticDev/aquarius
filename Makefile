THEOS_DEVICE_IP= 192.168.50.157
DEBUG = 0
include $(THEOS)/makefiles/common.mk

SUBPROJECTS += tweak prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
