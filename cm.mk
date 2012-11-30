## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := OptimusEX

TARGET_BOOTANIMATION_NAME := vertical-480x800

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/su880/su880.mk)

# Device naming
PRODUCT_DEVICE := su880
PRODUCT_NAME := cm_su880
PRODUCT_BRAND := lge
PRODUCT_MODEL := LG-SU880
PRODUCT_MANUFACTURER := LGE
PRODUCT_DEFAULT_LANGUAGE := ko
PRODUCT_DEFAULT_REGION := KR

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=x2_skt_kr BUILD_FINGERPRINT=lge/x2_skt_kr/x2:4.0.4/IMM76L/LG-SU880-V19c.1209251458:user/release-keys PRIVATE_BUILD_DESC="x2_skt_kr-user 4.0.4 IMM76L LG-SU880-V19c.1209251458 release-keys"
