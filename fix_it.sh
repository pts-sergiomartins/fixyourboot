#! /bin/bash

set -e

cryptsetup luksOpen /dev/nvme0n1p2 luks-b63c4c92-3419-4a15-9ecf-93b38f5a7bb0

echo "Did it work? Press any key to continue..."
read

mount /dev/mapper/vgroot-lvroot /mnt
cd /mnt
mount /dev/nvme0n1p1 ./boot
mount --bind /dev ./dev
mount -t proc proc ./proc
mount -t sysfs sys ./sys
mount -t devpts devpts ./dev/pts

chroot .

update-initramfs -k all -u
update-grub

echo "DONE"

# Other Notes
# https://askubuntu.com/questions/804929/ubuntu-luks-volume-group-vgcrypt-not-found-drop-to-busybox
#
# Format for /etc/crypttab:  <device-name> UUID=<luks-uuid> none luks
# For example, ls -l /dev/disks/bt-uuid/
# 95fdfc15-12c1-4614-b0d6-95c8325db0a0 -> ../sdc2  (and I know this is my LUKS partition, named luksroot)
# luksroot UUID=95fdfc15-12c1-4614-b0d6-95c8325db0a0 none luks
# 
