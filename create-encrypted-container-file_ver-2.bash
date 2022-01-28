#!/bin/bash
#umount_con() {
#echo "umount container"
#sudo umount /run/media/sleepyparanoid/$con_name;
#sudo cryptsetup close $con_name;
#sudo losetup -d $loopdev
#}
#
#mount_con() {
#echo "mount container"
#if [[ $(ls /run/media/sleepyparanoid/ | grep -o $con_name) == $con_name ]]; then
#sudo mkdir /run/media/sleepyparanoid/$con_name
#fi
#sudo mount -t ext4 /dev/mapper/$con_name /run/media/sleepyparanoid/$con_name;
#sudo chown -R $UID.$UID /run/media/sleepyparanoid/$con_name/;
#}
#
#create_con() {
#echo "create container"
#dd if=/dev/zero of=$PWD/$1 bs=1M count=$2
#sudo losetup $3 $PWD/$1
#sudo cryptsetup --cipher=aes --hash=sha256 open --type luks $3 $1
#sudo mkfs.ext4 /dev/mapper/$1
#}
