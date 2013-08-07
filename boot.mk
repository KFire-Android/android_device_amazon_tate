DEVICE_FOLDER := device/amazon/tate
COMMON_FOLDER := device/amazon/omap4-common

BOWSER_BOOTLOADER := $(DEVICE_FOLDER)/prebuilt/boot/u-boot.bin
BOWSER_BOOT_CERT_FILE := $(DEVICE_FOLDER)/prebuilt/boot/boot_cert
BOWSER_BOOT_ADDRESS := '\x00\x50\x7c\x80'
BOWSER_STACK_FILE := /tmp/stack.tmp

define make_stack
  for i in $$(seq 1024) ; do echo -ne $(BOWSER_BOOT_ADDRESS) >>$(1) ; done
endef

INTERNAL_BOOTIMAGE_ARGS2 := \
	--kernel $(INSTALLED_KERNEL_TARGET) \
	--ramdisk $(COMMON_FOLDER)/initrd.img-touch \
	--cmdline "$(BOARD_KERNEL_CMDLINE)" \
	--base $(BOARD_KERNEL_BASE) \
	--pagesize $(BOARD_KERNEL_PAGESIZE)

$(INSTALLED_BOOTIMAGE_TARGET): \
		$(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(BOWSER_BOOTLOADER)
	$(call pretty,"Making target Ubuntu-Touch boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS2) --output $@.tmp
	$(hide) cat $(BOWSER_BOOT_CERT_FILE) $@.tmp >$@
	$(hide) rm -f $@.tmp
	$(call pretty,"Adding kindle specific u-boot for boot.img")
	$(hide) dd if=$(BOWSER_BOOTLOADER) of=$@ bs=8117072 seek=1 conv=notrunc
	$(call pretty,"Adding kindle specific payload to boot.img")
	$(call make_stack,$(BOWSER_STACK_FILE))
	$(hide) dd if=$(BOWSER_STACK_FILE) of=$@ bs=6519488 seek=1 conv=notrunc
	$(hide) rm -f $(BOWSER_STACK_FILE)

# XXX - While I'd like to do this check, currently it adds some reserve
# that totally kills the deal.
#	$(hide) $(call assert-max-image-size,$@, \
#		$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)

$(INSTALLED_RECOVERYIMAGE_TARGET): \
		$(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel) \
		$(BOWSER_BOOTLOADER)
	@echo ----- Making recovery image ------
	$(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) --output $@.tmp
	$(hide) cat $(BOWSER_BOOT_CERT_FILE) $@.tmp >$@
	$(hide) rm -f $@.tmp
	$(call pretty,"Adding kindle specific u-boot for recovery.img")
	$(hide) dd if=$(BOWSER_BOOTLOADER) of=$@ bs=8117072 seek=1 conv=notrunc
# XXX - While I'd like to do this check, currently it adds some reserve
# that totally kills the deal.
#	$(hide) $(call assert-max-image-size,$@,\
#		$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)

