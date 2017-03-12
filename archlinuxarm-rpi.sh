#!/bin/bash
#Ask the sd card location
echo "Type your sdcard location (ex: /dev/sdc)"
read device

echo "o
n
p
1

+100M
t
c
n
p
2


w
" | fdisk $device

mkfs.vfat $device'1'
mkdir boot
mount $device'1' boot

mkfs.ext4 -F $device'2'
mkdir root
mount $device'2' root

wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-latest.tar.gz
bsdtar -xpf ArchLinuxARM-rpi-latest.tar.gz -C root
sync

mv root/boot/* boot

umount boot root

rm -rf boot root

rm ArchLinuxARM-rpi-latest.tar.gz
