#!/sbin/sh

# Resets the boot counter and the BCB instructions
echo 0 > /sys/block/mmcblk0boot0/force_ro

# Ask for normal boot next time
echo -n 1 | dd of=/dev/block/mmcblk0boot0 bs=1 count=1 seek=4104

# Zero out the boot counter
dd if=/dev/zero of=/dev/block/mmcblk0boot0 bs=1 count=1 seek=4120

# reset bootmsg
dd if=/dev/zero of=/dev/block/platform/omap/omap_hsmmc.1/by-name/misc bs=1 count=31

