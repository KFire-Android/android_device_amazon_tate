# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration for bowser
$(call inherit-product, device/amazon/tate/full_tate.mk)
$(call inherit-product, device/amazon/bowser-common/cm.mk)

TARGET_SCREEN_WIDTH := 1280
TARGET_SCREEN_HEIGHT := 800

PRODUCT_NAME := cm_tate
PRODUCT_DEVICE := tate
PRODUCT_MODEL := Amazon Kindle Fire HD
PRODUCT_RELEASE_NAME := KindleFireHD
PRODUCT_BRAND := google
PRODUCT_MANUFACTURER := Amazon

