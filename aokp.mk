# Inherit device configuration for AMZ Tate
$(call inherit-product, device/amazon/tate/full_tate.mk)

# Inherit common product files.
$(call inherit-product, vendor/aokp/configs/common_tablet.mk)

DEVICE_PACKAGE_OVERLAYS += device/amazon/tate/overlay/aokp

# Setup device specific product configuration.
PRODUCT_NAME := aokp_tate
PRODUCT_DEVICE := tate
PRODUCT_BRAND := Android
PRODUCT_MODEL := Amazon Kindle Fire
PRODUCT_MANUFACTURER := Amazon
PRODUCT_RELEASE_NAME := KFireHD

PRODUCT_COPY_FILES +=  \
    vendor/aokp/prebuilt/bootanimation/bootanimation_1280_800.zip:system/media/bootanimation.zip

