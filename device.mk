# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DEVICE_FOLDER := device/amazon/tate
TARGET_BOOTLOADER_BOARD_SUBTYPE := tate

$(call inherit-product, device/amazon/bowser-common/common.mk)

# Device overlay
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay

PRODUCT_AAPT_CONFIG := normal large tvdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := tvdpi

# Rootfs
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/fstab.tate:/root/fstab.bowser \
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
    $(DEVICE_FOLDER)/prebuilt/vendor/firmware/maxtouch.cfg:recovery/root/vendor/firmware/maxtouch.cfg \
    $(DEVICE_FOLDER)/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

# Device settings
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=213 \
    persist.hwc.mirroring.region=0:0:800:1280 \
    persist.hwc.mirroring.transform=3 \
    persist.demo.hdmirotationlock=true \
    persist.lab126.touchnoisereject=1 \
    persist.lab126.chargeprotect=1 \
    ro.nf.profile=2 \
    ro.nf.level=512 \
    omap.audio.mic.main=DMic0L \
    omap.audio.mic.sub=DMic0R \
    omap.audio.power=PingPong \
    dolby.audio.sink.info=speaker \
    sys.usb.vid=1949 \
    sys.usb.pid=0007 \
    ro.cwm.forbid_format=/bootloader,/xloader,/misc \
    ro.camera.sound.forced=0 \
    ro.camera.video_size=1280x720

# Set dirty regions off
PRODUCT_PROPERTY_OVERRIDES += \
    hwui.render_dirty_regions=false

# RIL turn off
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=1 \
    ro.radio.use-ppp=no \
    ro.config.nocheckin=yes \
    ro.radio.noril=yes

# wifi-only device
PRODUCT_PROPERTY_OVERRIDES += \
    ro.carrier=wifi-only

# Dalvik VM settings
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=128m \
    dalvik.vm.heapsize=384m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=2m \
    dalvik.vm.heapmaxfree=8m

$(call inherit-product-if-exists, vendor/amazon/tate/tate-vendor.mk)
$(call inherit-product-if-exists, vendor/amazon/omap4-common/omap4-common-vendor-540_120.mk)
