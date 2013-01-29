DEVICE_FOLDER := device/amazon/tate
TARGET_BOOTLOADER_BOARD_SUBTYPE := tate

$(call inherit-product, device/amazon/bowser-common/common.mk)

# Device overlay
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay

PRODUCT_AAPT_CONFIG := large hdpi xhdpi

# Rootfs
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/root/init.bowser.rc:root/init.bowser.rc

# Prebuilts /system/bin
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/bin/provision_device:/system/bin/provision_device \
    $(DEVICE_FOLDER)/prebuilt/bin/provisioning_client:/system/bin/provisioning_client \
    $(DEVICE_FOLDER)/prebuilt/bin/start_smc.sh:/system/bin/start_smc.sh \
    $(DEVICE_FOLDER)/prebuilt/bin/atmel_touch.sh:/system/bin/atmel_touch.sh

# Remove ducati for now until I fix ducati load crash
# Prebuilt firmware
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/firmware/maxtouch.cfg:/system/vendor/firmware/maxtouch.cfg \
    $(DEVICE_FOLDER)/firmware/maxtouch.fw:/system/vendor/firmware/maxtouch.fw \
    $(DEVICE_FOLDER)/firmware/mxt-fw20.enc:/system/vendor/firmware/mxt-fw20.enc \
    $(DEVICE_FOLDER)/firmware/smc_pa.ift:/system/vendor/firmware/smc_pa.ift \
    $(DEVICE_FOLDER)/firmware/smc_pa.ift.version:/system/vendor/firmware/smc_pa.ift.version \
    $(DEVICE_FOLDER)/firmware/ducati-m3.bin:/system/vendor/firmware/ducati-m3.bin.bak

# Prebuilts /system/etc
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/audio-bowser/tate.xml:/system/etc/sound/tate \

# Prebuilt /system/usr
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/usr/idc/cyttsp4-i2c.idc:system/usr/idc/cyttsp4-i2c.idc \
    $(DEVICE_FOLDER)/prebuilt/usr/idc/AtmelTouch.idc:system/usr/idc/AtmelTouch.idc \
    $(DEVICE_FOLDER)/prebuilt/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl\
    $(DEVICE_FOLDER)/prebuilt/usr/keylayout/twl6030_pwrbutton.kl:system/usr/keylayout/twl6030_pwrbutton.kl

# Prebuilt /system/lib
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/lib/sensors.omap4.so:system/lib/hw/sensors.omap4.so \
    $(DEVICE_FOLDER)/prebuilt/lib/libinvensense_hal.so:system/lib/libinvensense_hal.so \
    $(DEVICE_FOLDER)/prebuilt/lib/libmllite.so:system/lib/libmllite.so \
    $(DEVICE_FOLDER)/prebuilt/lib/libmlplatform.so:system/lib/libmlplatform.so \
    $(DEVICE_FOLDER)/prebuilt/lib/libmplmpu.so:system/lib/libmplmpu.so \
    $(DEVICE_FOLDER)/prebuilt/lib/libril-lab126qmi.so:/system/lib/libril-lab126qmi.so \

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=210 \
    persist.hwc.mirroring.region=0:0:800:1280 \
    persist.hwc.mirroring.transform=0 \
    persist.lab126.touchnoisereject=1 \
    persist.lab126.chargeprotect=1 \
    ro.nf.profile=2 \
    ro.nf.level=512 \
