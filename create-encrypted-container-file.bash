#!/bin/bash
export loopdev=$(sudo losetup -f)
con="container"
echo "What do you wants?"
echo "1. Create $con"
echo "2. Mount $con"
echo "3. Umount $con"
echo -n "[1,2,3] "
read res_menu
if [[ $res_menu == 1 ]]; then
    echo -n "Name container: "
    read con_name
    echo -n "Size container(minimal 16MB): [MB] "
    read size_con
    if [[ $size_con < 16 ]]
    then
    echo "Enter right size"
    exit 1
    fi
    echo "$PWD/$con_name"
    echo -n "This is the absolute path are you sure? [y/N] "
    read res_menu
    if [[ $res_menu == y ]]; then
    echo "create container"
    sudo dd if=/dev/zero of=$PWD/$con_name bs=1M count=$size_con
    sudo losetup $loopdev $PWD/$con_name
    sudo cryptsetup --cipher=aes --hash=sha256 open --type luks $loopdev $con_name
    sudo mkfs.ext4 /dev/mapper/$con_name
    echo "mount container"
    if [[ $(ls /run/media/sleepyparanoid/ | grep -o $con_name) == $con_name ]]; then
    sudo mkdir /run/media/sleepyparanoid/$con_name
    fi
    sudo mount -t ext4 /dev/mapper/$con_name /run/media/sleepyparanoid/$con_name
    sudo chown -R $UID.$UID /run/media/sleepyparanoid/$con_name/ 2>/dev/null
    fi
fi
if [[ $res_menu == 2 ]]; then
    echo -n "Name container: "
    read con_name
    echo "$PWD/$con_name"
    echo -n "This is the absolute path are you sure? [y/N] "
    read respond_2
    echo "mount container"
    if [[ $(ls /run/media/sleepyparanoid/ | grep -o $con_name) == $con_name ]]; then
    sudo mkdir /run/media/sleepyparanoid/$con_name
    fi
    sudo mount -t ext4 /dev/mapper/$con_name /run/media/sleepyparanoid/$con_name
    sudo chown -R $UID.$UID /run/media/sleepyparanoid/$con_name/ 2>/dev/null
fi
if [[ $res_menu == 3 ]]; then
    echo -n "Name container: "
    read con_name
    echo "$PWD/$con_name"
    echo -n "This is the absolute path are you sure? [y/N] "
    read respond_3
    echo "umount container"
    sudo umount /run/media/sleepyparanoid/$con_name;
    sudo cryptsetup close $con_name;
    sudo losetup -d $loopdev
fi
