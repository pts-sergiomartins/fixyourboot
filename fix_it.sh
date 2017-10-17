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
