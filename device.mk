#
# Copyright (C) 2012 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_FOLDER := device/amazon/bowser
COMMON_FOLDER := device/amazon/omap4-common
TARGET_BOOTLOADER_BOARD_SUBTYPE := tate

$(call inherit-product, $(COMMON_FOLDER)/common.mk)

PRODUCT_AAPT_CONFIG := large hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi


# Hardware HALs
PRODUCT_PACKAGES += \
    hwcomposer.bowser \
    lights.bowser \
    power.bowser \
    camera.bowser \
    audio.primary.bowser \
    audio.hdmi.bowser \

# BT
PRODUCT_PACKAGES += \
    uim-sysfs \
    brcm_patchram_plus

# Rootfs
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/root/init.bowser.rc:root/init.bowser.rc \
    $(DEVICE_FOLDER)/root/init.bowser.usb.rc:root/init.bowser.usb.rc \
    $(DEVICE_FOLDER)/root/ueventd.bowser.rc:root/ueventd.bowser.rc \

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
    $(DEVICE_FOLDER)/prebuilt/bin/hdcp.keys:/system/vendor/firmware/hdcp.keys \
    $(DEVICE_FOLDER)/firmware/smc_pa.ift.version:/system/vendor/firmware/smc_pa.ift.version \
    $(DEVICE_FOLDER)/firmware/ducati-m3.bin:/system/vendor/firmware/ducati-m3.bin.bak \

# Prebuilts /system/etc
PRODUCT_COPY_FILES += \
    $(COMMON_FOLDER)/audio-bowser/tate.xml:/system/etc/sound/tate \
    $(COMMON_FOLDER)/audio-bowser/audio_policy.conf:/system/etc/audio_policy.conf \
    $(DEVICE_FOLDER)/prebuilt/etc/media_codecs.xml:/system/etc/media_codecs.xml \
    $(DEVICE_FOLDER)/prebuilt/etc/media_profiles.xml:/system/etc/media_profiles.xml \
    $(DEVICE_FOLDER)/prebuilt/etc/vold.fstab:system/etc/vold.fstab \

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

# postrecoveryboot for recovery
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=210 \
    persist.hwc.mirroring.region=0:0:800:1280 \
    persist.hwc.mirroring.transform=0 \
    persist.lab126.touchnoisereject=1 \
    persist.lab126.chargeprotect=1 \
    ro.nf.profile=2 \
    ro.nf.level=512 \

$(call inherit-product, frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk)
$(call inherit-product-if-exists, $(DEVICE_FOLDER)/prebuilt/camera/vendor-camera.mk)
$(call inherit-product-if-exists, $(COMMON_FOLDER)/imgtec/sgx-imgtec-bins-540.mk)
$(call inherit-product-if-exists, $(COMMON_FOLDER)/bcmdhd-wifi/bcmdhd-wifi.mk)
