#!/sbin/sh

sleep 3

## Exchage dd
rm /sbin/dd
ln -s /sbin/busybox2 /sbin/dd

## Clear "boot-recovery...enable-wipe" flag
dd if=/dev/zero of=/dev/block/mmcblk0p6 seek=6144 count=75 bs=1
echo 1 > /sys/devices/platform/bssq_qwerty_led/leds/button-backlight/brightness
