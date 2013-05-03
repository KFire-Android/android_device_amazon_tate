DEVICE_FOLDER := device/amazon/tate
TARGET_BOARD_OMAP_CPU := 4460

# inherit from common
-include device/amazon/bowser-common/BoardConfigCommon.mk

# inherit from the proprietary version
-include vendor/amazon/tate/BoardConfigVendor.mk

# Kernel Build
TARGET_KERNEL_SOURCE := kernel/amazon/bowser-common
TARGET_KERNEL_CONFIG := tate_android_defconfig

# External SGX Module
SGX_MODULES:
	make clean -C $(COMMON_FOLDER)/pvr-source/eurasiacon/build/linux2/omap4430_android
	cp $(TARGET_KERNEL_SOURCE)/drivers/video/omap2/omapfb/omapfb.h $(KERNEL_OUT)/drivers/video/omap2/omapfb/omapfb.h
	make -j8 -C $(COMMON_FOLDER)/pvr-source/eurasiacon/build/linux2/omap4430_android ARCH=arm KERNEL_CROSS_COMPILE=arm-eabi- CROSS_COMPILE=arm-eabi- KERNELDIR=$(KERNEL_OUT) TARGET_PRODUCT="blaze_tablet" BUILD=release TARGET_SGX=540 PLATFORM_VERSION=4.0
	mv $(KERNEL_OUT)/../../target/kbuild/pvrsrvkm_sgx540_120.ko $(KERNEL_MODULES_OUT)
	$(ARM_EABI_TOOLCHAIN)/arm-eabi-strip --strip-unneeded $(KERNEL_MODULES_OUT)/pvrsrvkm_sgx540_120.ko

# Put the touchscreen driver into rootfs
TS_MODULE:
	make -j8 -C $(KERNEL_SRC) O=$(KERNEL_OUT) ARCH=arm KERNEL_CROSS_COMPILE=arm-eabi- CROSS_COMPILE=arm-eabi- KERNELDIR=$(KERNEL_OUT) modules
	cp $(KERNEL_OUT)/drivers/input/touchscreen/atmel_mxt_ts.ko $(OUT)/root/sbin/

TARGET_KERNEL_MODULES += SGX_MODULES TS_MODULE

# OTA Packaging / Bootimg creation
BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_FOLDER)/boot.mk

# hack the ota
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := ./$(DEVICE_FOLDER)/releasetools/bowser_ota_from_target_files
# not tested at all
TARGET_RELEASETOOL_IMG_FROM_TARGET_SCRIPT := ./$(DEVICE_FOLDER)/releasetools/bowser_img_from_target_files

# TWRP Config
TARGET_OTA_ASSERT_DEVICE := blaze_tablet,bowser,tate
DEVICE_RESOLUTION := 800x1280
TW_BRIGHTNESS_PATH := /sys/class/backlight/lcd-backlight/brightness

