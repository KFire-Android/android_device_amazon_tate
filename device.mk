DEVICE_FOLDER := device/amazon/tate
TARGET_BOOTLOADER_BOARD_SUBTYPE := tate

$(call inherit-product, device/amazon/bowser-common/common.mk)

# Device overlay
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay

PRODUCT_AAPT_CONFIG := large hdpi xhdpi

# Rootfs
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/init.bowser.rc:root/init.bowser.rc \
    $(DEVICE_FOLDER)/init.bowser.usb.rc:root/init.bowser.usb.rc \
    $(DEVICE_FOLDER)/ueventd.bowser.rc:root/ueventd.bowser.rc

# Prebuilt /system/usr
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/usr/idc/cyttsp4-i2c.idc:system/usr/idc/cyttsp4-i2c.idc \
    $(DEVICE_FOLDER)/prebuilt/usr/idc/AtmelTouch.idc:system/usr/idc/AtmelTouch.idc \
    $(DEVICE_FOLDER)/prebuilt/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl\
    $(DEVICE_FOLDER)/prebuilt/usr/keylayout/twl6030_pwrbutton.kl:system/usr/keylayout/twl6030_pwrbutton.kl

# Recovery Trigger / TS module/config
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/vendor/firmware/atmel_mxt_ts.ko:recovery/root/vendor/firmware/atmel_mxt_ts.ko \
    $(DEVICE_FOLDER)/prebuilt/vendor/firmware/maxtouch.cfg:recovery/root/vendor/firmware/maxtouch.cfg \
    $(DEVICE_FOLDER)/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

# Device settings
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=213 \
    persist.hwc.mirroring.region=0:0:800:1280 \
    persist.hwc.mirroring.transform=1 \
    persist.lab126.touchnoisereject=1 \
    persist.lab126.chargeprotect=1 \
    ro.nf.profile=2 \
    ro.nf.level=512 \
    omap.audio.mic.main=DMic0L \
    omap.audio.mic.sub=DMic0R \
    omap.audio.power=PingPong \
    dolby.audio.sink.info=speaker \
    sys.usb.vid=1949 \
    sys.usb.pid=0007

# Set dirty regions off
PRODUCT_PROPERTY_OVERRIDES += \
    hwui.render_dirty_regions=false

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)
$(call inherit-product-if-exists, vendor/amazon/tate/tate-vendor.mk)
