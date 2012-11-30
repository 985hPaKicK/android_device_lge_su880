$(call inherit-product, build/target/product/full.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product-if-exists, vendor/lge/su880/su880-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_COPY_FILES += device/common/gps/gps.conf_AS:system/etc/gps.conf

# Ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/init.rc:root/init.rc \
    $(LOCAL_PATH)/ramdisk/init.bssq.rc:root/init.bssq.rc \
    $(LOCAL_PATH)/ramdisk/init.bssq.usb.rc:root/init.bssq.usb.rc \
    $(LOCAL_PATH)/ramdisk/ueventd.bssq.rc:root/ueventd.bssq.rc \

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/setup-recovery:system/bin/setup-recovery \
    $(LOCAL_PATH)/ramdisk/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh \
    $(LOCAL_PATH)/ramdisk/busybox:recovery/root/sbin/busybox2 \

# Configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/audio_effects.conf:system/etc/audio_effects.conf \
    $(LOCAL_PATH)/configs/asound.conf:system/etc/asound.conf \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/configs/gps_brcm_conf.xml:system/etc/gps_brcm_conf.xml \
    $(LOCAL_PATH)/configs/lge_synaptics.idc:system/usr/idc/lge_synaptics.idc \
    $(LOCAL_PATH)/configs/lge_synaptics.kl:system/usr/keylayout/lge_synaptics.kl

# For ril
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/init.vsnet:system/bin/init.vsnet \
    $(LOCAL_PATH)/prebuilt/init.vsnet-down:system/bin/init.vsnet-down

# Wifi module
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/wireless.ko:system/lib/modules/wireless.ko

# Vold
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/vold.fstab:system/etc/vold.fstab

# KoreanIME
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/KoreanIME.apk:/system/app/LatinIME.apk \
    $(LOCAL_PATH)/prebuilt/libjni_koreanime.so:/system/lib/libjni_koreanime.so

# RootExplorer
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/RootBrowser.apk:/system/app/RootBrowser.apk \
    $(LOCAL_PATH)/prebuilt/.root_browser:/system/etc/.root_browser

# Permission files
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_LOCALES += ko_KR hdpi

# Audio
PRODUCT_PACKAGES += \
    audio.primary.bssq \
    audio_policy.bssq \
    audio.a2dp.default

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# Bluetooth
PRODUCT_PACKAGES += \
    brcm_patchram_plus

# Bluetooth
PRODUCT_PACKAGES += \
    hcitool \
    hciconfig \
    hwaddrs

# Baseband
PRODUCT_PACKAGES += \
    lgcpversion

# HWComposer
PRODUCT_PACKAGES += \
    hwcomposer.default

# Lights
PRODUCT_PACKAGES += \
    lights.bssq

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/prebuilt/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel \

# Radio fixes
FRAMEWORKS_BASE_SUBDIRS += ../../$(LOCAL_PATH)/ril/

$(call inherit-product, frameworks/native/build/phone-hdpi-dalvik-heap.mk)

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
