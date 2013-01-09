#!/system/bin/sh

#
# Find sensor vendor based on gpadc value
# Now we do not copy the corresponding cfg file to /data/firmware
#

SENSOR_VENDOR_SYSFS=/sys/bus/i2c/devices/1-0049/twl6030_gpadc/in4_channel
ATMEL_MXT_TS_SYSFS=/sys/bus/i2c/drivers/atmel_mxt_ts/2-004c

CFG_FILE_DIR=/system/vendor/firmware
#CFG_FILE_DESTINATION=$CFG_FILE_DIR/maxtouch.cfg
CFG_FILE_DESTINATION=/data/firmware/maxtouch.cfg

CFG_FILE_TPK=$CFG_FILE_DIR/maxtouch_tpk.cfg
CFG_FILE_WINTEK=$CFG_FILE_DIR/maxtouch_wintek.cfg
CFG_FILE_CMI=$CFG_FILE_DIR/maxtouch_cmi.cfg
CFG_FILE_HANNSTOUCH=$CFG_FILE_DIR/maxtouch_hannstouch.cfg
CFG_FILE_SOURCE=$CFG_FILE_DIR/maxtouch.cfg

CFG_FILE_OK=1
RETRY_COUNT=10
echo "===========ATMEL TOUCH SENSOR DETECT================" > /dev/kmsg

if [ -e $SENSOR_VENDOR_SYSFS ]; then

	SENSOR_VENDOR_GPADC=$(cat $SENSOR_VENDOR_SYSFS)
	while [ $SENSOR_VENDOR_GPADC -eq 0  -a $RETRY_COUNT -gt 0 ]; do
		echo "Touchscreen Vendor ID value is $SENSOR_VENDOR_GPADC... Retrying..." > /dev/kmsg
		SENSOR_VENDOR_GPADC=$(cat $SENSOR_VENDOR_SYSFS)
		((RETRY_COUNT--))
	done

	echo "Atmel touch sensor vendor gpadc value: $SENSOR_VENDOR_GPADC" > /dev/kmsg

	if [ $SENSOR_VENDOR_GPADC -lt 550 ]; then
		echo "Atmel touch sensor is TPK." > /dev/kmsg
	elif [ $SENSOR_VENDOR_GPADC -lt 617 ]; then
		echo "Atmel touch sensor is Wintek." > /dev/kmsg
	elif [ $SENSOR_VENDOR_GPADC -lt 678 ]; then
		echo "Atmel touch sensor is CMI." > /dev/kmsg
	elif [ $SENSOR_VENDOR_GPADC -lt 725 ]; then
		echo "Atmel touch sensor is HannsTouch." > /dev/kmsg
	else
		echo "Out of range reading. Atmel touch sensor can not be determined." > /dev/kmsg
	fi

	if [ ! -f "$CFG_FILE_SOURCE" ]; then
		echo "Atmel source config file not found" > /dev/kmsg
	fi
else
	echo "Atmel touch sensor vendor sysfs entry not found" > /dev/kmsg
fi

 
#
# Load the driver as module
#

ATMEL_DRIVER=/system/lib/modules/atmel_mxt_ts.ko

if [ -e $ATMEL_DRIVER ]; then
	echo "loading atmel touch driver" > /dev/kmsg
	insmod $ATMEL_DRIVER
	sleep 1;
else
	echo "Atmel touch driver module not found" > /dev/kmsg
fi


#
# Modify sysfs permission so TouchNoiseRejection service can access it
#
echo "atmel chown of sysfs entry" > /dev/kmsg
chown system.system $ATMEL_MXT_TS_SYSFS/t48_ctrl
chown system.system $ATMEL_MXT_TS_SYSFS/action


#
# Firmware Upgrade
#

# Read version and build
FIRMWARE_VERSION=$(cat $ATMEL_MXT_TS_SYSFS/version)
FIRMWARE_BUILD=$(cat $ATMEL_MXT_TS_SYSFS/build)

# If not 2.0 AA
if [ $FIRMWARE_VERSION -ne 32 ] || [ $FIRMWARE_BUILD -ne 170 ]; then
	# upgrade firmware using in-kernel firmware loader
	# this requires appropriate maxtouch.fw file in /data/firmware/
#	echo 1 > $ATMEL_MXT_TS_SYSFS/update_fw
fi



