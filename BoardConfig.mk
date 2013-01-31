DEVICE_FOLDER := device/amazon/tate

# inherit from common
-include device/amazon/bowser-common/BoardConfigCommon.mk

# inherit from the proprietary version
-include vendor/amazon/tate/BoardConfigVendor.mk

# Kernel Build
BOARD_KERNEL_CMDLINE := ttyO2,115200n8 rootdelay=2 mem=1G init=/init vmalloc=256M vram=32M omapfb.vram=0:20M androidboot.console=ttyO2 androidboot.hardware=bowser
#TARGET_KERNEL_SOURCE := kernel/amazon/bowser-common
#TARGET_KERNEL_CONFIG := tate_android_defconfig
TARGET_PREBUILT_KERNEL := $(DEVICE_FOLDER)/kernel

# OTA Packaging / Bootimg creation
BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_FOLDER)/boot.mk

# hack the ota
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := ./$(DEVICE_FOLDER)/releasetools/bowser_ota_from_target_files
# not tested at all
TARGET_RELEASETOOL_IMG_FROM_TARGET_SCRIPT := ./$(DEVICE_FOLDER)/releasetools/bowser_img_from_target_files

# TWRP Config
TARGET_OTA_ASSERT_DEVICE := blaze_tablet,bowser,tate
DEVICE_RESOLUTION := 800x1280

