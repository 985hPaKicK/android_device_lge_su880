LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
 
ALL_PREBUILT += $(INSTALLED_KERNEL_TARGET)

subdir_makefiles:= \
	$(LOCAL_PATH)/bbversion/Android.mk \
	$(LOCAL_PATH)/liblights/Android.mk \

include $(subdir_makefiles)

# include the non-open-source counterpart to this file
-include vendor/lge/su880/AndroidBoardVendor.mk
