#!/system/bin/sh

mkdir -p /efs/smc

echo "start smc .... "  > /dev/console

echo 0 > /sys/devices/system/cpu/cpu1/online

/vendor/bin/smc_pa_ctrl -c /vendor/etc/smc_normal_world_android_cfg.ini \
    start /vendor/firmware/smc_pa.ift > /dev/console

echo "start tf_daemon .... "  > /dev/console
/vendor/bin/tf_daemon -c /vendor/etc/smc_normal_world_android_cfg.ini &
chmod 666 /dev/tf_driver > /dev/console

echo "start provisioning ..." > /dev/console
/vendor/bin/provision_device

echo "loading hdcp keys into hdcp driver" > /dev/console
/system/xbin/hdcp-test 1 /efs/hdcp/hdcp.kek.wrapped 1

echo 1 > /sys/devices/system/cpu/cpu1/online
