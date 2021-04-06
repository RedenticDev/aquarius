include $(THEOS)/makefiles/common.mk
THEOS_DEVICE_IP= 192.168.50.157
SUBPROJECTS += tweak prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
