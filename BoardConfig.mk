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
TARGET_BOARD_OMAP_CPU := 4460

# inherit from common
-include device/amazon/bowser-common/BoardConfigCommon.mk

# inherit from the proprietary version
-include vendor/amazon/tate/BoardConfigVendor.mk

# Kernel Build
TARGET_KERNEL_SOURCE := kernel/amazon/bowser-common
TARGET_KERNEL_CONFIG := android_omap4_defconfig
TARGET_KERNEL_VARIANT_CONFIG := android_tate_defconfig
BOARD_KERNEL_CMDLINE := mem=1G rootdelay=2 init=/init androidboot.console=ttyO2 androidboot.hardware=bowser androidboot.selinux=permissive

# External SGX Module
SGX_MODULES:
	make clean -C $(COMMON_FOLDER)/pvr-source/eurasiacon/build/linux2/omap4430_android
	cp $(TARGET_KERNEL_SOURCE)/drivers/video/omap2/omapfb/omapfb.h $(KERNEL_OUT)/drivers/video/omap2/omapfb/omapfb.h
	make -j8 -C $(COMMON_FOLDER)/pvr-source/eurasiacon/build/linux2/omap4430_android ARCH=arm KERNEL_CROSS_COMPILE=arm-eabi- CROSS_COMPILE=arm-eabi- KERNELDIR=$(KERNEL_OUT) TARGET_PRODUCT="blaze_tablet" BUILD=release TARGET_SGX=540 PLATFORM_VERSION=4.0
	mv $(KERNEL_OUT)/../../target/kbuild/pvrsrvkm_sgx540_120.ko $(KERNEL_MODULES_OUT)
	$(ARM_EABI_TOOLCHAIN)/arm-eabi-strip --strip-unneeded $(KERNEL_MODULES_OUT)/pvrsrvkm_sgx540_120.ko

TOUCH_MODULES:
	mkdir -p $(OUT)/recovery/root/vendor/firmware/
	cp $(KERNEL_MODULES_OUT)/atmel_mxt_ts.ko $(OUT)/recovery/root/vendor/firmware/

TARGET_KERNEL_MODULES += SGX_MODULES TOUCH_MODULES

# OTA Packaging / Bootimg creation
BOARD_CUSTOM_BOOTIMG := true
BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_FOLDER)/boot.mk

# Recovery/TWRP Config
TARGET_RECOVERY_FSTAB = $(DEVICE_FOLDER)/fstab.tate
RECOVERY_FSTAB_VERSION = 2
TARGET_OTA_ASSERT_DEVICE := blaze_tablet,bowser,tate
DEVICE_RESOLUTION := 800x1280
TW_BRIGHTNESS_PATH := /sys/class/backlight/lcd-backlight/brightness
TW_NO_SCREEN_BLANK := true
TW_NO_SCREEN_TIMEOUT := true
